import 'package:oogie/models/order_model.dart';
import 'package:oogie/models/product_model.dart';

class OrderByDeliveryPartnerEvent {}

class FetchInitialData extends OrderByDeliveryPartnerEvent {}

class UpdateOrderModels extends OrderByDeliveryPartnerEvent {
  List<OrderModel> models;

  UpdateOrderModels({this.models});
}

class UpdateReturnOrderModels extends OrderByDeliveryPartnerEvent {
  List<OrderModel> models;

  UpdateReturnOrderModels({this.models});
}

class RemoveProductFromCart extends OrderByDeliveryPartnerEvent {
  int index;
  String cartType;

  RemoveProductFromCart({this.index, this.cartType});
}
class OrderDateSelected extends OrderByDeliveryPartnerEvent {
  DateTime fromDate, toDate;

  OrderDateSelected({this.toDate, this.fromDate});
}
class ReturnOrderDateSelected extends OrderByDeliveryPartnerEvent {
  DateTime fromDate, toDate;

  ReturnOrderDateSelected({this.toDate, this.fromDate});
}

class MoveProductToWishList extends OrderByDeliveryPartnerEvent {
  int index;
  String cartType;

  MoveProductToWishList({this.index, this.cartType});
}

class LikeAndUnLikeFeed extends OrderByDeliveryPartnerEvent {
  int index;

  LikeAndUnLikeFeed({this.index});
}
