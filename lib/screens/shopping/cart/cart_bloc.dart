import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/shopping/cart/cart_event.dart';
import 'package:oogie/screens/shopping/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  ProductRepository productRepository;
  String parentPage;

  CartBloc({@required this.productRepository, this.parentPage})
      : super(CartState(
            newProductModels: [], usedProductModels: [], currentPageIndex: 0)) {
    state.parentPage = parentPage;

    getCartProducts();
  }

  getCartProducts() async {
    state.usedProductModels.clear();
    state.newProductModels.clear();

    await productRepository.setProductsInCart();

    var data = await productRepository.getProductsInCart();
    add(UpdateNewProductModels(productModels: data[0]));
    add(UpdateUsedProductModels(productModels: data[1]));
  }

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is FetchInitialData) {
      yield state.copyWith(isLoading: true);
      await getCartProducts();
    } else if (event is UpdateNewProductModels) {
      yield state.copyWith(newProductModels: event.productModels);
    } else if (event is UpdateUsedProductModels) {
      yield state.copyWith(usedProductModels: event.productModels);
    } else if (event is MoveProductToWishList) {
      print('move to wishlist ${event.index} t ${event.cartType}');
      try {
        String productId = '';
        if (event.cartType == 'new') {
          productId = state.newProductModels[event.index].id;
        } else {
          productId = state.usedProductModels[event.index].id;
        }

        String cartId = '';
        if (event.cartType == 'new') {
          cartId = state.newProductModels[event.index].cartId;
        } else {
          cartId = state.usedProductModels[event.index].cartId;
        }
        print('if condition k');
        await productRepository.deleteProductFromCart(cartID: cartId);
        await productRepository.addProductToWishList(productId: productId);

        await getCartProducts();
      } catch (e) {
        yield state.copyWith(actionErrorMessage: e);
      }
    } else if (event is RemoveProductFromCart) {
      try {
        String cartId = '';
        if (event.cartType == 'new') {
          cartId = state.newProductModels[event.index].cartId;
        } else {
          cartId = state.usedProductModels[event.index].cartId;
        }
        await productRepository.deleteProductFromCart(cartID: cartId);
        await getCartProducts();
      } catch (e) {
        yield state.copyWith(actionErrorMessage: e);
      }
    }
  }
}
