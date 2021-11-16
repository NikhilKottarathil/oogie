import 'package:oogie/models/product_model.dart';

class ProductListEvent {}

class FetchInitialData extends ProductListEvent {}

class UpdatedList extends ProductListEvent {
  List<ProductModel> productModels;

  UpdatedList({this.productModels});
}

class RefreshList extends ProductListEvent {}

class FetchMoreData extends ProductListEvent {}

class LikeAndUnLikeFeed extends ProductListEvent {
  int index;

  LikeAndUnLikeFeed({this.index});
}
