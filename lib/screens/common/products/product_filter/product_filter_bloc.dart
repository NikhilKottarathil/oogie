import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/filter_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/common/products/product_filter/product_filter_event.dart';
import 'package:oogie/screens/common/products/product_filter/product_filter_state.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProductFilterBloc extends Bloc<ProductFilterEvent, ProductFilterState> {
  ProductRepository productRepository;
  String parentPage;
  String parentCategoryId;
  bool isUsedProduct=false;
  String parentAdvertisementId;
  String advertisementId;

  ProductFilterBloc(
      {@required this.productRepository,
      @required this.parentPage,this.parentAdvertisementId,
      this.parentCategoryId})
      : super(ProductFilterState(
            productModels: [],
            productIDs: [],
            filterModels: [],
            categoryModels: [],
            titleText: '',
            searchString: '',
            // minimumPrice: '0',
            // maximumPrice: '1000',
            sortFilter: sortingFilterDefault,
            ratingFilter: ratingFilterDefault,
  sfRangeValues: SfRangeValues(0.0,100000.0))) {
    //parent pages= category,search,usedProducts,searchThen,featuredProducts,newlyArrivedProducts,advertisement
    state.parentPage = parentPage;
    getAllCategories();

    if (state.parentPage == 'search') {
      state.titleText = 'Search Results';
    }
    if (state.parentPage == 'category') {
      state.selectedCategoryId = parentCategoryId;
      getInitialProducts();

    }
    if(state.parentPage=='usedProduct'){
      isUsedProduct=true;
      state.titleText = 'Used Phones';
      getInitialProducts();

    }
    if(state.parentPage=='newlyArrivedProducts'){
      state.titleText = 'Newly Arrived';
      state.sortFilter.values.every((element) => element.isSelected=false);
      state.sortFilter.values[0].isSelected=true;
      getInitialProducts();
    }
    if(state.parentPage=='featuredProducts'){
      state.titleText = 'Featured Products';
      state.sortFilter.values.every((element) => element.isSelected=false);

      state.sortFilter.values[1].isSelected=true;
      getInitialProducts();
    }
    if(state.parentPage=='advertisement'){
      state.titleText = 'Offers';
      advertisementId=parentAdvertisementId;
      getInitialProducts();
    }
  }

  getAllCategories() async {
    List<CategoryModel> categoryModels =
        await productRepository.getCategories();
    if (state.parentPage == 'category') {
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

  getFiltersOfSelectedCategory({String categoryId}) async {
    state.filterModels.clear();
    List<FilterModel> filterModels = await productRepository
        .getFiltersOfSelectedCategory(categoryId: categoryId);
    state.sortFilter = sortingFilterDefault;
    state.ratingFilter = ratingFilterDefault;
    print("filterModelslength");
    print(filterModels.length);
    add(UpdatedFilters(filterModels: filterModels));
  }

  getInitialProducts() async {
    state.productModels.clear();
    state.productIDs.clear();

    state.page = 1;
    if(state.parentPage=='search'|| state.parentPage=='searchThen'){
      state.filterModels.clear();
      state.selectedCategoryId = null;
      getSearchProducts();
    }else{
      getFilterProducts();
    }
  }

  getMoreProducts() async {
    state.page=state.page+1;
    if(state.parentPage=='search'|| state.parentPage=='searchThen'){
      getSearchProducts();
    }else{
      getFilterProducts();
    }
  }

  getFilterProducts() async {
    String rating ;
    if(state.ratingFilter.values.any((element) => element.isSelected)){
     rating= state.ratingFilter.values
          .singleWhere((element) => element.isSelected,
          orElse: () => state.ratingFilter.values[state.ratingFilter.values.length-1])
          .value;
    }
    String sort = state.sortFilter.values
        .singleWhere((element) => element.isSelected,
            orElse: () => state.sortFilter.values[0])
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
      if(values.isNotEmpty){
        filters.add({'product_attribute_id': filterModel.id, 'value': values});
      }
    });

    print(filters);


    var productModels = await productRepository.getProductsByFilter(
      page: state.page,
      rowsPerPage: 6,
      rating: rating,
      sort: sort,
      filters: filters,
      categoryId: state.selectedCategoryId,
      minPrice: state.sfRangeValues.start,
      maxPrice: state.sfRangeValues.end,
      advertisementId: advertisementId,
      isUsedProduct: state.parentPage=='usedProduct'
    );
    add(UpdatedList(productModels: productModels));

  }

  getSearchProducts() async {
    advertisementId=null;
    var data = await productRepository.getProductBySearch(
        searchString: state.searchString, page: state.page, rowsPerPage: 6);

    add(UpdatedList(productModels: data[1]));
  }

  @override
  Stream<ProductFilterState> mapEventToState(ProductFilterEvent event) async* {
    if (event is UpdatedList) {

      yield state.copyWith(
          productModels: state.productModels + event.productModels,isLoading: false);
    } else if (event is UpdatedCategories) {

      yield state.copyWith(
          categoryModels: event.categoryModels, titleText: event.titleText);
    } else if (event is CategorySelected) {

      String categoryName = state.categoryModels
          .singleWhere((element) => element.id == event.categoryId)
          .name;
      getFiltersOfSelectedCategory(categoryId: event.categoryId);
      yield state.copyWith(
          selectedCategoryId: event.categoryId, titleText: categoryName);
    } else if (event is UpdatedFilters) {

      yield state.copyWith(filterModels: event.filterModels);
    } else if (event is FilterApplied) {

      getInitialProducts();
    } else if (event is MinimumPriceChanged) {
      yield state.copyWith(minimumPrice: event.minimumPrice);
    } else if (event is MaximumPriceChanged) {


      yield state.copyWith(maximumPrice: event.maximumPrice);
    } else if (event is FetchMoreData) {

      yield state.copyWith(isLoading: true);

     getMoreProducts();
    } else if (event is SearchTextChanged) {

      yield state.copyWith(searchString: event.searchString);
    } else if (event is SearchSubmitted) {


      getInitialProducts();
      yield state.copyWith(titleText: 'Search Results');
    } else if (event is PriceRangeValuesChanged) {
      yield state.copyWith(sfRangeValues: event.sfRangeValues);

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
  ),KeyValueRadioModel(
    key: 'Featured',
    value: 'featured_product',
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
