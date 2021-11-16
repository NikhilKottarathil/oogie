import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/common/products/product_search/product_search_event.dart';
import 'package:oogie/screens/common/products/product_search/product_search_state.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  ProductRepository productRepository;
  String parentPage;

  ProductSearchBloc(
      {@required this.productRepository, @required this.parentPage})
      : super(ProductSearchState(productModels: [], productIDs: [])) {
    state.parentPage = parentPage;
    print('inside list');
  }

  getSearchResults() async {
    state.productModels.clear();
    state.productIDs.clear();
    state.categoryModels.clear();
    state.page = 1;
    // var productModels =
    // await productRepository.getSearchProduct(state.page, 10, parentPage);
    // add(UpdatedList(productModels: productModels));
  }

  getMoreProducts() async {
    state.page = state.page + 1;
    var productModels =
        await productRepository.getProducts(state.page, 10, parentPage);
    add(UpdatedList(productModels: productModels));
  }

  @override
  Stream<ProductSearchState> mapEventToState(ProductSearchEvent event) async* {
    if (event is FetchInitialData) {
      yield state.copyWith(isLoading: true);
      // await getInitialProducts();
    } else if (event is FetchMoreData) {
      yield state.copyWith(isLoading: true);
      await getMoreProducts();
    } else if (event is UpdatedList) {
      state.productModels.addAll(event.productModels);
      yield state.copyWith(isLoading: false);
    } else if (event is LikeAndUnLikeFeed) {}
  }
}
