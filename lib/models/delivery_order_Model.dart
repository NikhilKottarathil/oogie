import 'package:oogie/models/address_model.dart';
import 'package:oogie/models/product_model.dart';

class DeliveryOrderModel {
  String id, name, date;
  double total;
  List<ProductModel>products;
  List<DeliveryState>deliveryStatuses;
  AddressModel shippingAddressModel;
  AddressModel pickingAddressModel;
  String deliveryState;
  String deliveryType;
  String orderId;
  bool isUSedProductOrder;
  String reviewId;
  String createdDate;


  DeliveryOrderModel({this.reviewId,this.createdDate,this.isUSedProductOrder,this.orderId, this.pickingAddressModel,this.shippingAddressModel,this.id, this.date, this.total,this.products,this.deliveryState,this.deliveryType,this.deliveryStatuses});
}
class DeliveryState{
  String name;
  DateTime datetime;
  String datetimeString;

  DeliveryState({this.name,this.datetime,this.datetimeString});
}
