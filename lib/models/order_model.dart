import 'package:oogie/models/product_model.dart';

class OrderModel {
  String id, name, date;
  double total;
  List<ProductModel>products;
  String state;
  String deliveryType;

  OrderModel({this.name, this.id, this.date, this.total,this.products,this.state,this.deliveryType});
}
