import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/models/address_model.dart';
import 'package:oogie/models/product_model.dart';

enum PaymentTypeState { cod, online, none }
enum OrderStatus {
  InitialStatus,
  OrderCreating,
  OrderCreationSuccess,
  OrderCreationFailed,
  PaymentProcessing,
  PaymentSuccess,
  PaymentFailed,
  InvoiceCreating,
  InvoiceFailed,
  OrderCompleted
}

class CheckoutState {
  List<ProductModel> productModels = [];
  AddressModel addressModel;
  double subTotal, deliveryCharge, taxes, total;

  DateTime expectedDeliveryDate;
  bool isLoading;
  String parentPage;
  Exception actionErrorMessage;
  PaymentTypeState paymentTypeState;

  OrderStatus orderStatus;

  CheckoutState(
      {this.productModels,
      this.addressModel,
      this.parentPage,
      this.actionErrorMessage,
      this.isLoading = false,
      this.total,
      this.deliveryCharge,
      this.expectedDeliveryDate,
      this.taxes,
      this.paymentTypeState,this.orderStatus,
      this.subTotal});

  CheckoutState copyWith({
    var productModels,
    var addressModel,
    var productIDs,
    bool isLoading,
    String parentPage,
    Exception actionErrorMessage,
    PageScrollStatus pageScrollStatus,
    double subTotal,
    PaymentTypeState paymentTypeState,
    deliveryCharge,
    OrderStatus orderStatus,
    taxes,
    total,
    DateTime expectedDeliveryDate,
    int currentPageIndex,
  }) {
    return CheckoutState(
      productModels: productModels ?? this.productModels,
      subTotal: subTotal ?? this.subTotal,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      addressModel: addressModel ?? this.addressModel,
      taxes: taxes ?? this.taxes,
      total: total ?? this.total,
      isLoading: isLoading ?? this.isLoading,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      parentPage: parentPage ?? this.parentPage,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
      paymentTypeState: paymentTypeState ?? this.paymentTypeState,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }
}
