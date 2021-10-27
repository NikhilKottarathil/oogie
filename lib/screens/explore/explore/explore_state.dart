import 'package:oogie/models/advertisement_model.dart';
import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/product_model.dart';

class ExploreState {

  int notificationCount;
  int messageCount;
  int itemsInCartCount;


  List<CategoryModel> categoryModels;
  CategoryModel selectedCategoryModel;

  List<AdvertisementModel> advertisementModels;


  List<ProductModel> newArrivedProductModels;
  List<ProductModel> featuredProductModels;


  ExploreState({
    this.advertisementModels,this.categoryModels,this.featuredProductModels,this.itemsInCartCount,this.messageCount,this.newArrivedProductModels,this.notificationCount,this.selectedCategoryModel
  });

  ExploreState copyWith({
    int notificationCount,
    int messageCount,
    int itemsInCartCount,

    List<CategoryModel> categoryModels,
    CategoryModel selectedCategoryModel,

    List<AdvertisementModel> advertisementModels,


    List<ProductModel> newArrivedProductModels,
    List<ProductModel> featuredProductModels,

  }) {
    return ExploreState(
      notificationCount:notificationCount ?? this.notificationCount,
      messageCount:messageCount ?? this.messageCount,
      itemsInCartCount:itemsInCartCount ?? this.itemsInCartCount,

      categoryModels:categoryModels ?? this.categoryModels,
      selectedCategoryModel:selectedCategoryModel ?? this.selectedCategoryModel,

      advertisementModels:advertisementModels ?? this.advertisementModels,

      newArrivedProductModels:newArrivedProductModels ?? this.newArrivedProductModels,
      featuredProductModels:featuredProductModels ?? this.featuredProductModels,

    );
  }
}
