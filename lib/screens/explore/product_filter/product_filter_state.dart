import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/filter_model.dart';
import 'package:oogie/models/product_model.dart';

class ProductFilterState {
  List<ProductModel> productModels = [];
  List<CategoryModel> categoryModels = [];
  String selectedCategoryId;
  List<FilterModel> filterModels = [];
  FilterModel ratingFilter;

  FilterModel sortFilter;
  List<String> productIDs = [];
  PageScrollStatus pageScrollStatus;
  int page;
  bool isLoading;
  String parentPage, titleText;
  Exception actionErrorMessage;

  String searchString;
  bool isSearching;
  String minimumPrice,maximumPrice;
  FormSubmissionStatus formSubmissionStatus;
  bool iPriceValid;

  String get priceValidator {
    if (minimumPrice.isEmpty || maximumPrice.isEmpty) {
      return null;
    } else if (int.parse(minimumPrice.trim())> int.parse(maximumPrice.trim())) {
      return '';
    } else {
      return null;
    }
  }

  ProductFilterState({
    this.productModels,
    this.categoryModels,
    this.selectedCategoryId,
    this.pageScrollStatus = const InitialScrollStatus(),
    this.productIDs,
    this.page = 1,
    this.parentPage,
    this.actionErrorMessage,
    this.isLoading = false,
    this.titleText,
    this.filterModels,
    this.ratingFilter,
    this.sortFilter,
    this.searchString,
  this.isSearching,
    this.maximumPrice,
    this.minimumPrice,
    this.iPriceValid,
    this.formSubmissionStatus,
  });

  ProductFilterState copyWith({
    var productModels,
    var categoryModels,
    var filterModels,
    FilterModel ratingFilter,
    FilterModel sortFilter,
    String selectedCategoryId,
    var productIDs,
    bool isLoading,
    String titleText,
    String parentPage,
    Exception actionErrorMessage,
    PageScrollStatus pageScrollStatus,
    int page,
    String searchString,
    bool  isSearching,
    String minimumPrice,maximumPrice,
    bool iPriceValid,
    FormSubmissionStatus formSubmissionStatus,

  }) {
    return ProductFilterState(
      productModels: productModels ?? this.productModels,
      categoryModels: categoryModels ?? this.categoryModels,
      filterModels: filterModels ?? this.filterModels,
      ratingFilter: ratingFilter ?? this.ratingFilter,
      sortFilter: sortFilter ?? this.sortFilter,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      productIDs: productIDs ?? this.productIDs,
      pageScrollStatus: pageScrollStatus ?? this.pageScrollStatus,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      titleText: titleText ?? this.titleText,
      parentPage: parentPage ?? this.parentPage,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
      searchString: searchString ?? this.searchString,
      isSearching: isSearching ?? this.isSearching,
      maximumPrice: maximumPrice ?? this.maximumPrice,
      minimumPrice: minimumPrice ?? this.minimumPrice,
      iPriceValid: iPriceValid ?? this.iPriceValid,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }
}
