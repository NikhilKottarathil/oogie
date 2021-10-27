import 'package:oogie/models/product_model.dart';

class WishlistEvent {}

class FetchInitialData extends WishlistEvent {}

class UpdateProductModels extends WishlistEvent {
  List<ProductModel> productModels;

  UpdateProductModels({this.productModels});
}

class RemoveProductFromWishlist extends WishlistEvent {
  int index;
  String cartType;

  RemoveProductFromWishlist({this.index, this.cartType});
}

class AddProductToCart extends WishlistEvent {
  int index;
  String cartType;

  AddProductToCart({this.index, this.cartType});
}

class LikeAndUnLikeFeed extends WishlistEvent {
  int index;

  LikeAndUnLikeFeed({this.index});
}
