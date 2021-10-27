import 'package:oogie/models/product_model.dart';

class ProductSearchEvent {}

class SearchProduct extends ProductSearchEvent {
  String text;
  SearchProduct({this.text});
}
class FetchInitialData extends ProductSearchEvent {}

class UpdatedList extends ProductSearchEvent {
  List<ProductModel> productModels;
  UpdatedList({this.productModels});
}

class RefreshList extends ProductSearchEvent {}

class FetchMoreData extends ProductSearchEvent {}

class LikeAndUnLikeFeed extends ProductSearchEvent {
  int index;

  LikeAndUnLikeFeed({this.index});
}
