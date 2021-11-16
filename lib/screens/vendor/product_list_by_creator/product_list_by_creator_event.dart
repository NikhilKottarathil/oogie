import 'package:oogie/models/product_model.dart';

class ProductListByCreatorEvent {}

class FetchInitialData extends ProductListByCreatorEvent {}
class NewProductAdded extends ProductListByCreatorEvent {
  String productId;
  NewProductAdded({this.productId});
}
class NewProductUpdatedToList extends ProductListByCreatorEvent {
   ProductModel productModel;
  NewProductUpdatedToList({this.productModel});
}

class UpdatedList extends ProductListByCreatorEvent {
  List<ProductModel> productModels;

  UpdatedList({this.productModels});
}

class RefreshList extends ProductListByCreatorEvent {}

class FetchMoreData extends ProductListByCreatorEvent {}

class LikeAndUnLikeFeed extends ProductListByCreatorEvent {
  int index;

  LikeAndUnLikeFeed({this.index});
}
