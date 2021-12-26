import 'package:oogie/models/order_model.dart';
import 'package:oogie/models/product_model.dart';

class DeliveryOrdersEvent {}

class FetchInitialData extends DeliveryOrdersEvent {}

class UpdateOrderModels extends DeliveryOrdersEvent {
  List<OrderModel> models;

  UpdateOrderModels({this.models});
}

class UpdateReturnOrderModels extends DeliveryOrdersEvent {
  List<OrderModel> models;

  UpdateReturnOrderModels({this.models});
}

class RemoveProductFromCart extends DeliveryOrdersEvent {
  int index;
  String cartType;

  RemoveProductFromCart({this.index, this.cartType});
}
class OrderDateSelected extends DeliveryOrdersEvent {
  DateTime fromDate, toDate;

  OrderDateSelected({this.toDate, this.fromDate});
}
class ReturnOrderDateSelected extends DeliveryOrdersEvent {
  DateTime fromDate, toDate;

  ReturnOrderDateSelected({this.toDate, this.fromDate});
}

class FilterApplied extends DeliveryOrdersEvent {

}class ClearFilter extends DeliveryOrdersEvent {
String type;
ClearFilter({this.type});
}
