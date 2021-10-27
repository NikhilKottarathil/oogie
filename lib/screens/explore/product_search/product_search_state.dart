
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/product_model.dart';

class ProductSearchState {
  List<ProductModel> productModels=[];
  List<CategoryModel> categoryModels=[];
  PageScrollStatus pageScrollStatus;
  int page;
  List<String> productIDs=[];
  bool isLoading;
  String parentPage;
  Exception actionErrorMessage;

  ProductSearchState({
    this.productModels,
    this.categoryModels,
    this.pageScrollStatus=const InitialScrollStatus(),
    this.productIDs,
    this.page=1,
    this.parentPage,
    this.actionErrorMessage,
    this.isLoading=false
  });

  ProductSearchState copyWith({
    var productModels,
    var categoryModels,
    var productIDs,
    bool isLoading,
    String parentPage,
    Exception actionErrorMessage,
    PageScrollStatus pageScrollStatus,
    int page,
  }) {
    return ProductSearchState(
      productModels: productModels ?? this.productModels,
      categoryModels: categoryModels ?? this.categoryModels,
      productIDs: productIDs ?? this.productIDs,
      pageScrollStatus: pageScrollStatus ?? this.pageScrollStatus,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      parentPage: parentPage ?? this.parentPage,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
    );
  }
}
