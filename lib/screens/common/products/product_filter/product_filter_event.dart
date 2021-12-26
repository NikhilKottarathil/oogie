import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/filter_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProductFilterEvent {}

class FetchInitialData extends ProductFilterEvent {}

class UpdatedCategories extends ProductFilterEvent {
  List<CategoryModel> categoryModels;
  String titleText;

  UpdatedCategories({this.categoryModels, this.titleText});
}

class UpdatedFilters extends ProductFilterEvent {
  List<FilterModel> filterModels;

  UpdatedFilters({this.filterModels});
}

class UpdatedList extends ProductFilterEvent {
  List<ProductModel> productModels;

  UpdatedList({this.productModels});
}

class CategorySelected extends ProductFilterEvent {
  String categoryId;

  CategorySelected({this.categoryId});
}

class RefreshList extends ProductFilterEvent {}

class FilterApplied extends ProductFilterEvent {}

class SearchSubmitted extends ProductFilterEvent {}

class SearchTextChanged extends ProductFilterEvent {
  String searchString;

  SearchTextChanged({this.searchString});
}

class MinimumPriceChanged extends ProductFilterEvent {
  String minimumPrice;

  MinimumPriceChanged({this.minimumPrice});
}

class MaximumPriceChanged extends ProductFilterEvent {
  String maximumPrice;

  MaximumPriceChanged({this.maximumPrice});
}

class FetchMoreData extends ProductFilterEvent {}
class PriceRangeValuesChanged extends ProductFilterEvent {
  SfRangeValues sfRangeValues;
  PriceRangeValuesChanged({this.sfRangeValues});
}

class LikeAndUnLikeProduct extends ProductFilterEvent {
  int index;

  LikeAndUnLikeProduct({this.index});
}
