import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/models/address_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/repository/order_repository.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/screens/shopping/checkout/checkout_event.dart';
import 'package:oogie/screens/shopping/checkout/checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  ProductRepository productRepository;
  ProfileRepository profileRepository;
  OrderRepository orderRepository;
  String parentPage;
  List<String> productIds;
  String orderId, invoiceId, transactionId;

  CheckoutBloc(
      {@required this.productRepository,
      this.parentPage,
      @required this.orderRepository,
      @required this.profileRepository,
      @required this.productIds})
      : super(CheckoutState(
            paymentTypeState: PaymentTypeState.none,
            productModels: [],
            orderStatus: OrderStatus.InitialStatus,
            isLoading: true,
            total: 0.0,
            taxes: 0.0,
            subTotal: 0.0,
            deliveryCharge: 0.0,
            expectedDeliveryDate: DateTime.now().add(Duration(days: 7)))) {
    print('productIds ${productIds.length}');
    getCheckoutProducts();
    getDefaultAddress();
  }

  getCheckoutProducts() async {
    List<ProductModel> productModels = [];
    await Future.forEach(productIds, (element) async {
      productModels
          .add(await productRepository.getDetailsOfSelectedProduct(element));
    });
    state.productModels = productModels;
    qtyChangedUpdateList();
  }

  getDefaultAddress() async {
    AddressModel defaultAddress;

    List<AddressModel> addressModels = await profileRepository.getAddresses();
    await Future.forEach(addressModels, (element) {
      if (element.isDefault) {
        defaultAddress = element;
      }
    });

    add(DefaultAddressChanged(addressModel: defaultAddress));
  }

  qtyChangedUpdateList() {
    state.subTotal = 0.0;
    state.deliveryCharge = 20.0;
    state.productModels.forEach((element) {
      element.totalPrice = double.parse(element.qty.toString()) *
          double.parse(element.price.toString());
      state.subTotal += double.parse(element.qty.toString()) *
          double.parse(element.price.toString());
    });
    state.total = state.subTotal + state.deliveryCharge;
    add(UpdateProductModels(productModels: state.productModels));
  }

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    if (event is FetchInitialData) {
      yield state.copyWith(isLoading: true, actionErrorMessage:null);
      await getCheckoutProducts();
    } else if (event is DefaultAddressChanged) {
      yield state.copyWith(addressModel: event.addressModel, actionErrorMessage:null);
    } else if (event is GetDefaultAddress) {
      print('call reach 11');
      await getDefaultAddress();
    } else if (event is UpdateProductModels) {
      yield state.copyWith(productModels: event.productModels, actionErrorMessage:null);
    } else if (event is QtyUpdated) {
      qtyChangedUpdateList();
    } else if (event is PaymentMethodChanged) {
      yield state.copyWith(paymentTypeState: event.paymentTypeState, actionErrorMessage:null);
    } else if (event is OrderStatusChanged) {
      yield state.copyWith(orderStatus: event.orderStatus, actionErrorMessage:null);
    } else if (event is CreateOrder) {
      yield state.copyWith(orderStatus: OrderStatus.OrderCreating, actionErrorMessage:null);

      try {
        await createOrder();
        if (state.paymentTypeState == PaymentTypeState.cod) {
          try {
            await createInvoice();
            yield state.copyWith(
                orderStatus: OrderStatus.InvoiceSuccess,
                actionErrorMessage: null);

            try {
              await confirmOrder();
              yield state.copyWith(
                  orderStatus: OrderStatus.OrderConfirmCompleted,
                  actionErrorMessage: null);
            } catch (e) {
              yield state.copyWith(
                  orderStatus: OrderStatus.OrderConfirmFailed,
                  actionErrorMessage: null);
            }
          } catch (e) {
            yield state.copyWith(
                orderStatus: OrderStatus.InvoiceFailed, actionErrorMessage: e);
          }
        } else {
          yield state.copyWith(
              orderStatus: OrderStatus.OrderCreationSuccess,
              actionErrorMessage: null);
          yield state.copyWith(
              orderStatus: OrderStatus.PaymentProcessing,
              actionErrorMessage: null);
        }
      } catch (e) {
        yield state.copyWith(
            orderStatus: OrderStatus.OrderCreationFailed,
            actionErrorMessage: e);
      }
    } else if (event is CreateInvoice) {
      yield state.copyWith(
          orderStatus: OrderStatus.InvoiceCreating, actionErrorMessage: null);
      try {
        await createInvoice(transactionId: event.transactionId);
        yield state.copyWith(
            orderStatus: OrderStatus.InvoiceSuccess, actionErrorMessage:null);

      }catch(e){
        yield state.copyWith(
            orderStatus: OrderStatus.InvoiceFailed, actionErrorMessage: e);

      }
    } else if (event is ConfirmOrder) {
      yield state.copyWith(
          orderStatus: OrderStatus.OrderConfirming, actionErrorMessage: null);
      try{
        await confirmOrder();

        yield state.copyWith(
            orderStatus: OrderStatus.OrderConfirmCompleted, actionErrorMessage: null);

      }catch(e){
        yield state.copyWith(
            orderStatus: OrderStatus.OrderConfirmFailed, actionErrorMessage: e);

      }
    }

  }

  createOrder() async {
    orderId = await orderRepository.createAnOrder(
        deliveryCharge: state.deliveryCharge,
        total: state.total,
        productModels: state.productModels,
        addressId: state.addressModel.id);
  }

  createInvoice({String transactionId}) async {
    invoiceId = await orderRepository.createAnInvoice(
        total: state.total,
        orderId: orderId,
        paymentTypeState: state.paymentTypeState,
        fullName: AppData().userName);

  }

  confirmOrder() async {
    await orderRepository.confirmSelectedOrder(
        invoiceId: invoiceId, orderId: orderId);
    try {
      await cartBloc.deleteAllCartItems(productIds: productIds);
    } catch (e) {}
  }
}
