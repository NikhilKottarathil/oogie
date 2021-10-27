import 'package:oogie/models/address_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/screens/shopping/checkout/checkout_state.dart';

class CheckoutEvent {}

class FetchInitialData extends CheckoutEvent {}

class UpdateProductModels extends CheckoutEvent {
  List<ProductModel> productModels;

  UpdateProductModels({this.productModels});
}

class GetDefaultAddress extends CheckoutEvent {
  GetDefaultAddress();
}

class QtyUpdated extends CheckoutEvent {
  QtyUpdated();
}

class DefaultAddressChanged extends CheckoutEvent {
  AddressModel addressModel;

  DefaultAddressChanged({this.addressModel});
}
class PaymentMethodChanged extends CheckoutEvent {
  PaymentTypeState paymentTypeState;

  PaymentMethodChanged({this.paymentTypeState});
}
class OrderStatusChanged extends CheckoutEvent {
  OrderStatus orderStatus;

  OrderStatusChanged({this.orderStatus});
}
