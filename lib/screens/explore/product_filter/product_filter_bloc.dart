import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/filter_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_event.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_state.dart';

class ProductFilterBloc extends Bloc<ProductFilterEvent, ProductFilterState> {
  ProductRepository productRepository;
  String parentPage;
  String parentCategoryId;

  ProductFilterBloc(
      {@required this.productRepository,
      @required this.parentPage,
      this.parentCategoryId})
      : super(ProductFilterState(
            productModels: [],
            productIDs: [],
            filterModels: [],
            categoryModels: [],
            titleText: '',
            searchString: '',
            minimumPrice: '',
            maximumPrice: '',
            sortFilter: sortingFilterDefault,
            ratingFilter: ratingFilterDefault)) {
    state.parentPage = parentPage;
    if(parentPage=='search') {
      state.titleText = parentPage;
    }
    getAllCategories();

    if (parentPage == 'exploreCategory') {
      state.selectedCategoryId = parentCategoryId;
      getProducts();
    }
  }

  getAllCategories() async {
    List<CategoryModel> categoryModels =
        await productRepository.getCategories();
    if (parentPage == 'exploreCategory') {
      String titleText = categoryModels
          .singleWhere((element) => element.id == parentCategoryId)
          .name;
      add(UpdatedCategories(
          categoryModels: categoryModels, titleText: titleText));
      add(CategorySelected(categoryId: parentCategoryId));
    } else {
      add(UpdatedCategories(categoryModels: categoryModels));
    }
  }

  getFilters({String categoryId}) async {
    state.filterModels.clear();
    List<FilterModel> filterModels = await productRepository
        .getFiltersOfSelectedCategory(categoryId: categoryId);
    state.sortFilter = sortingFilterDefault;
    state.ratingFilter = ratingFilterDefault;
    print("filterModelslength");
    print(filterModels.length);
    add(UpdatedFilters(filterModels: filterModels));
  }

  getProducts() async {
    state.productModels.clear();
    state.productIDs.clear();
    state.page = 1;
    var productModels = await productRepository.getProductsByFilter(
        categoryId: state.selectedCategoryId);
    add(UpdatedList(productModels: productModels));
  }

  getMoreProducts() async {
    state.page = state.page + 1;
    var productModels =
        await productRepository.getProducts(state.page, 10, parentPage);
    add(UpdatedList(productModels: productModels));
  }

  getFilterProducts() async {
    state.page = 0;
    String rating = state.ratingFilter.values
        .singleWhere((element) => element.isSelected,
            orElse: () => state.ratingFilter.values[3])
        .value;
    String sort = state.sortFilter.values
        .singleWhere((element) => element.isSelected,
            orElse: () => state.ratingFilter.values[0])
        .value;
    List<Map<String, String>> filters = [];
    state.filterModels.forEach((filterModel) {
      String values = '';
      filterModel.values.forEach((element) {
        if (element.isSelected) {
          if (values == '') {
            values = values + element.value;
          } else {
            values = values + ',' + element.value;
          }
        }
      });
      filters.add({'product_attribute_id': filterModel.id, 'value': values});
    });
    // print('fjkdgh ');
    // print(state.page);
    // print(rating);
    // print(sort);
    print(filters);
    // print(state.selectedCategoryId);
    // print(state.minimumPrice.isNotEmpty ? state.minimumPrice : null);
    //

    var productModels = await productRepository.getProductsByFilter(
      page: state.page,
      rowsPerPage: 10,
      rating: rating,
      sort: sort,
      filters: filters,
      categoryId: state.selectedCategoryId,
      minPrice: state.minimumPrice.isNotEmpty ? state.minimumPrice : null,
      maxPrice: state.maximumPrice.isNotEmpty ? state.maximumPrice : null,
    );

  }

  getSearchProducts() async {
    var data = await productRepository.getProductBySearch(
        searchString: state.searchString, page: state.page, rowsPerPage: 10);
    state.filterModels.clear();
    state.selectedCategoryId=null;
    state.productModels.clear();
    add(UpdatedList(productModels: data[1]));
  }

  @override
  Stream<ProductFilterState> mapEventToState(ProductFilterEvent event) async* {
    if (event is UpdatedList) {
      print('1111111');

      yield state.copyWith(

          productModels: state.productModels + event.productModels);
    } else if (event is UpdatedCategories) {
      print('11111112');

      yield state.copyWith(
          categoryModels: event.categoryModels, titleText: event.titleText);
    } else if (event is CategorySelected) {
      print('11111113');

      String categoryName = state.categoryModels
          .singleWhere((element) => element.id == event.categoryId)
          .name;
      getFilters(categoryId: event.categoryId);
      yield state.copyWith(
          selectedCategoryId: event.categoryId, titleText: categoryName);
    } else if (event is UpdatedFilters) {
      print('11111114');

      yield state.copyWith(filterModels: event.filterModels);
    } else if (event is FilterApplied) {
      print('11111115');

      getFilterProducts();
    } else if (event is MinimumPriceChanged) {
      print('minimuum price changed');
      yield state.copyWith(minimumPrice: event.minimumPrice);
    } else if (event is MaximumPriceChanged) {
      print('111111126');

      yield state.copyWith(maximumPrice: event.maximumPrice);
    } else if (event is SearchTextChanged) {
      print('11111117');

      yield state.copyWith(searchString: event.searchString);
    } else if (event is SearchSubmitted) {
      print('11111118');

      getSearchProducts();
    }
  }
}

FilterModel ratingFilterDefault =
    FilterModel(name: 'Customer Rating', id: 'rating', values: [
  KeyValueRadioModel(
    key: '4 & above',
    value: '4',
    isSelected: false,
  ),
  KeyValueRadioModel(
    key: '3 & above',
    value: '3',
    isSelected: false,
  ),
  KeyValueRadioModel(
    key: '2 & above',
    value: '2',
    isSelected: false,
  ),
  KeyValueRadioModel(
    key: '1 & above',
    value: '1',
    isSelected: false,
  ),
]);
FilterModel sortingFilterDefault =
    FilterModel(name: 'Sort By', id: 'sort', values: [
  KeyValueRadioModel(
    key: 'Newest First',
    value: 'newest_first',
    isSelected: false,
  ),
  KeyValueRadioModel(
    key: 'Price: Low to High',
    value: 'price_low_to_high',
    isSelected: false,
  ),
  KeyValueRadioModel(
    key: 'Price: High to Low',
    value: 'price_high_to_low',
    isSelected: false,
  ),
]);
