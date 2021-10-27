import 'package:oogie/models/product_model.dart';

class CartEvent {}

class FetchInitialData extends CartEvent {}

class UpdateNewProductModels extends CartEvent {
  List<ProductModel> productModels;

  UpdateNewProductModels({this.productModels});
}

class UpdateUsedProductModels extends CartEvent {
  List<ProductModel> productModels;

  UpdateUsedProductModels({this.productModels});
}

class RemoveProductFromCart extends CartEvent {
  int index;
  String cartType;

  RemoveProductFromCart({this.index, this.cartType});
}

class MoveProductToWishList extends CartEvent {
  int index;
  String cartType;

  MoveProductToWishList({this.index, this.cartType});
}

class LikeAndUnLikeFeed extends CartEvent {
  int index;

  LikeAndUnLikeFeed({this.index});
}
