import 'package:oogie/models/advertisement_model.dart';
import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/product_model.dart';

abstract class ExploreEvent {}

class CategoriesUpdated extends ExploreEvent {
  List<CategoryModel> categoryModels;

  CategoriesUpdated({this.categoryModels});
}

class CategorySelected extends ExploreEvent {
  CategoryModel categoryModel;

  CategorySelected({this.categoryModel});
}

class AdvertisementUpdated extends ExploreEvent {
  List<AdvertisementModel> advertisementModels;

  AdvertisementUpdated({this.advertisementModels});
}

class NewArrivedProductUpdated extends ExploreEvent {
  List<ProductModel> newArrivedProductModels;

  NewArrivedProductUpdated({this.newArrivedProductModels});
}

class FeaturedProductUpdated extends ExploreEvent {
  List<ProductModel> featuredProductModels;

  FeaturedProductUpdated({this.featuredProductModels});
}
