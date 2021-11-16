import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/models/product_model.dart';

class CartState {
  List<ProductModel> newProductModels = [];
  List<ProductModel> usedProductModels = [];
  PageScrollStatus pageScrollStatus;
  int currentPageIndex;
  bool isLoading;
  String parentPage;
  Exception actionErrorMessage;

  CartState(
      {this.newProductModels,
      this.usedProductModels,
      this.pageScrollStatus = const InitialScrollStatus(),
      this.currentPageIndex = 0,
      this.parentPage,
      this.actionErrorMessage,
      this.isLoading = false});

  CartState copyWith({
    var newProductModels,
    var usedProductModels,
    var productIDs,
    bool isLoading,
    String parentPage,
    Exception actionErrorMessage,
    PageScrollStatus pageScrollStatus,
    int currentPageIndex,
  }) {
    return CartState(
      newProductModels: newProductModels ?? this.newProductModels,
      usedProductModels: usedProductModels ?? this.usedProductModels,
      pageScrollStatus: pageScrollStatus ?? this.pageScrollStatus,
      isLoading: isLoading ?? this.isLoading,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      parentPage: parentPage ?? this.parentPage,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
    );
  }
}
