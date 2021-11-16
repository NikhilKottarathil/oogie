import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/wishlist/wishlist_event.dart';
import 'package:oogie/screens/wishlist/wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  ProductRepository productRepository;
  String parentPage;

  WishlistBloc({@required this.productRepository, this.parentPage})
      : super(WishlistState(productModels: [], currentPageIndex: 0)) {
    state.parentPage = parentPage;

    getWishlistProducts();
  }

  getWishlistProducts() async {
    state.productModels.clear();

    await productRepository.setProductInWishlist();
    var productModels = await productRepository.getProductInWishlist();
    add(UpdateProductModels(productModels: productModels));
  }

  @override
  Stream<WishlistState> mapEventToState(WishlistEvent event) async* {
    if (event is FetchInitialData) {
      yield state.copyWith(isLoading: true);
      await getWishlistProducts();
    } else if (event is UpdateProductModels) {
      yield state.copyWith(productModels: event.productModels);
    } else if (event is AddProductToCart) {
      print('move to wishlist ${event.index} t ${event.cartType}');
      try {
        String productId = state.productModels[event.index].id;
        await productRepository.addNewProductToCart(
            productId: productId, cartType: 'new', noOfItem: 1);

        await getWishlistProducts();
      } catch (e) {
        yield state.copyWith(actionErrorMessage: e);
      }
    } else if (event is RemoveProductFromWishlist) {
      try {
        print('wishlist ${event.index}');
        print('wishlist ${state.productModels[event.index].id}');

        String id = state.productModels[event.index].wishListId;

        await productRepository.deleteProductFromWishlist(wishlistId: id);
        await getWishlistProducts();
      } catch (e) {
        yield state.copyWith(actionErrorMessage: e);
      }
    }
  }
}
