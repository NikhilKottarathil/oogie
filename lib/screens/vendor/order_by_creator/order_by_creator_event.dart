import 'package:oogie/models/order_model.dart';
import 'package:oogie/models/product_model.dart';

class OrderByCreatorEvent {}

class FetchInitialData extends OrderByCreatorEvent {}

class UpdateOrderModels extends OrderByCreatorEvent {
  List<OrderModel> models;

  UpdateOrderModels({this.models});
}

class UpdateReturnOrderModels extends OrderByCreatorEvent {
  List<OrderModel> models;

  UpdateReturnOrderModels({this.models});
}

class RemoveProductFromCart extends OrderByCreatorEvent {
  int index;
  String cartType;

  RemoveProductFromCart({this.index, this.cartType});
}
class OrderDateSelected extends OrderByCreatorEvent {
  DateTime fromDate, toDate;

  OrderDateSelected({this.toDate, this.fromDate});
}
class ReturnOrderDateSelected extends OrderByCreatorEvent {
  DateTime fromDate, toDate;

  ReturnOrderDateSelected({this.toDate, this.fromDate});
}

class MoveProductToWishList extends OrderByCreatorEvent {
  int index;
  String cartType;

  MoveProductToWishList({this.index, this.cartType});
}

class LikeAndUnLikeFeed extends OrderByCreatorEvent {
  int index;

  LikeAndUnLikeFeed({this.index});
}
