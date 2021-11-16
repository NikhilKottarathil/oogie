import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/common/products/product_list/product_list_event.dart';
import 'package:oogie/screens/common/products/product_list/product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductRepository productRepository;
  String parentPage;

  ProductListBloc({@required this.productRepository, @required this.parentPage})
      : super(ProductListState(productModels: [], productIDs: [])) {
    state.parentPage = parentPage;
    print('inside list');
    getInitialProducts();
  }

  getInitialProducts() async {
    state.productModels.clear();
    state.productIDs.clear();
    state.page = 1;
    var productModels =
        await productRepository.getProducts(state.page, 10, parentPage);
    add(UpdatedList(productModels: productModels));
  }

  getMoreProducts() async {
    state.page = state.page + 1;
    var productModels =
        await productRepository.getProducts(state.page, 10, parentPage);
    add(UpdatedList(productModels: productModels));
  }

  @override
  Stream<ProductListState> mapEventToState(ProductListEvent event) async* {
    if (event is FetchInitialData) {
      yield state.copyWith(isLoading: true);
      await getInitialProducts();
    } else if (event is FetchMoreData) {
      yield state.copyWith(isLoading: true);
      await getMoreProducts();
    } else if (event is UpdatedList) {
      state.productModels.addAll(event.productModels);
      yield state.copyWith(isLoading: false);
    } else if (event is LikeAndUnLikeFeed) {
      // try {
      //   if (!state.productModels[event.index].isLiked) {
      //     await feedRepository.likeFeed(
      //         feedId: state.feedModelList[event.index].id);
      //     state.feedModelList[event.index].isLiked = true;
      //     state.feedModelList[event.index].likeCount =
      //         (int.parse(state.feedModelList[event.index].likeCount) + 1)
      //             .toString();
      //     yield state.copyWith();
      //   } else {
      //     await feedRepository.unLikeFeed(
      //         connectionId: state.feedModelList[event.index].likeId);
      //     state.feedModelList[event.index].isLiked = false;
      //     state.feedModelList[event.index].likeCount =
      //         (int.parse(state.feedModelList[event.index].likeCount) - 1)
      //             .toString();
      //     yield state.copyWith();
      //   }
      // } catch (e) {
      //   yield state.copyWith();
      // }

    }
  }
}
