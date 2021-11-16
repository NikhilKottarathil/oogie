import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/models/product_model.dart';

class ProductListByCreatorState {
  List<ProductModel> productModels = [];
  PageScrollStatus pageScrollStatus;
  int page;
  List<String> productIDs = [];
  bool isLoading;
  String parentPage;
  Exception actionErrorMessage;

  ProductListByCreatorState(
      {this.productModels,
      this.pageScrollStatus = const InitialScrollStatus(),
      this.productIDs,
      this.page = 1,
      this.parentPage,
      this.actionErrorMessage,
      this.isLoading = false});

  ProductListByCreatorState copyWith({
    var productModels,
    var productIDs,
    bool isLoading,
    String parentPage,
    Exception actionErrorMessage,
    PageScrollStatus pageScrollStatus,
    int page,
  }) {
    return ProductListByCreatorState(
      productModels: productModels ?? this.productModels,
      productIDs: productIDs ?? this.productIDs,
      pageScrollStatus: pageScrollStatus ?? this.pageScrollStatus,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      parentPage: parentPage ?? this.parentPage,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
    );
  }
}
