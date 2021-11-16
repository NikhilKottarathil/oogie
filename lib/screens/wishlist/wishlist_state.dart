import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/models/product_model.dart';

class WishlistState {
  List<ProductModel> productModels = [];
  PageScrollStatus pageScrollStatus;
  int currentPageIndex;
  bool isLoading;
  String parentPage;
  Exception actionErrorMessage;

  WishlistState(
      {this.productModels,
      this.pageScrollStatus = const InitialScrollStatus(),
      this.currentPageIndex = 0,
      this.parentPage,
      this.actionErrorMessage,
      this.isLoading = false});

  WishlistState copyWith({
    var productModels,
    var productIDs,
    bool isLoading,
    String parentPage,
    Exception actionErrorMessage,
    PageScrollStatus pageScrollStatus,
    int currentPageIndex,
  }) {
    return WishlistState(
      productModels: productModels ?? this.productModels,
      pageScrollStatus: pageScrollStatus ?? this.pageScrollStatus,
      isLoading: isLoading ?? this.isLoading,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      parentPage: parentPage ?? this.parentPage,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
    );
  }
}
