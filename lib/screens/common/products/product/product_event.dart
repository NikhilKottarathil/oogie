import 'package:oogie/models/product_model.dart';
import 'package:oogie/models/review_model.dart';

class ProductEvent {
  const ProductEvent();
}

class FetchProductData extends ProductEvent {}

class CheckProductVariant extends ProductEvent {
  String value;
  int index;

  CheckProductVariant({this.value, this.index});
}

class UpdateProductData extends ProductEvent {
  ProductModel productModel;
  bool isViewOnly;

  UpdateProductData({this.productModel,this.isViewOnly});
}

class UpdateRelatedProducts extends ProductEvent {
  List<ProductModel> productModels;

  UpdateRelatedProducts({this.productModels});
}

class UpdateReviews extends ProductEvent {
  List<ReviewModel> reviewModels;

  UpdateReviews({this.reviewModels});
}

class LikeAndUnLikeProduct extends ProductEvent {}

class AddProductToCart extends ProductEvent {
  String id;

  AddProductToCart({this.id});
}
