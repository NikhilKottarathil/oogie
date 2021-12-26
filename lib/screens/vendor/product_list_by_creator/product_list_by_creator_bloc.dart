import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_event.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_state.dart';

class ProductListByCreatorBloc
    extends Bloc<ProductListByCreatorEvent, ProductListByCreatorState> {
  ProductRepository productRepository;
  String parentPage;

  ProductListByCreatorBloc(
      {@required this.productRepository, @required this.parentPage})
      : super(ProductListByCreatorState(productModels: [], productIDs: [])) {
    state.parentPage = parentPage;
    print('inside list');
    getInitialProducts();
  }

  @override
  Stream<ProductListByCreatorState> mapEventToState(
      ProductListByCreatorEvent event) async* {
    if (event is FetchInitialData) {
      yield state.copyWith(isLoading: true);
      await getInitialProducts();
    } else if (event is FetchMoreData) {
      yield state.copyWith(isLoading: true);
      await getMoreProducts();
    } else if (event is UpdatedList) {
      state.productModels.addAll(event.productModels);
      yield state.copyWith(isLoading: false);
    } else if (event is NewProductAdded) {
      yield state.copyWith(isLoading: true);
      getUpdatedProduct(productID: event.productId);
    } else if (event is NewProductUpdatedToList) {
      state.productModels.insert(0, event.productModel);
      yield state.copyWith(
        isLoading: false,
      );
    }
  }

  getInitialProducts() async {
    state.productModels.clear();
    state.productIDs.clear();
    state.page = 1;
    var productModels = await productRepository.getProductsByCreator(
        page: state.page,
        rowsPerPage: 10,
        parentPage: parentPage,
        isUsedProduct: parentPage=='usedProductsHome'?'True':'False');
    add(UpdatedList(productModels: productModels));
  }

  getMoreProducts() async {
    state.page = state.page + 1;
    var productModels = await productRepository.getProductsByCreator(
        page: state.page,
        rowsPerPage: 10,
        parentPage: parentPage,
        isUsedProduct: parentPage=='usedProductsHome'?'True':'False');
    add(UpdatedList(productModels: productModels));
  }

  Future<void> getUpdatedProduct({String productID}) async {
    ProductModel productModel =
        await productRepository.getDetailsOfSelectedProduct(productID);
    add(NewProductUpdatedToList(productModel: productModel));
  }
}
