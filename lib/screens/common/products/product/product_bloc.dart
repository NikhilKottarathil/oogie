import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/common/products/product/product_event.dart';
import 'package:oogie/screens/common/products/product/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;
  String parentPage;
  String productId;

  ProductBloc(
      {@required this.productRepository,
      this.parentPage,
      @required this.productId})
      : super(ProductState(
            isLoading: true, reviewModels: [], relatedProducts: [])) {
    state.parentPage = parentPage;
    print('inter 0');

    getProductData(productId);
  }

  getRelatedProducts({String categoryId}) async {
    var relatedProducts = await productRepository.getProductsByFilter(categoryId: categoryId,page: 1,rowsPerPage: 4);
    add(UpdateRelatedProducts(productModels: relatedProducts));
  }

  getProductReviews() async {
    var reviewModels =
        await productRepository.getProductReviews(1, 10, productId);
    add(UpdateReviews(reviewModels: reviewModels));
  }

  getProductData(String id) async {
    print('inter');
    ProductModel productModel =
        await productRepository.getDetailsOfSelectedProduct(id);
    bool isViewOnly=!(FlavorConfig().flavorValue=='user' && productModel.creatorId!=AppData().userId);
    add(UpdateProductData(productModel: productModel,isViewOnly: isViewOnly));
    getRelatedProducts(categoryId:productModel.categoryId);
    getProductReviews();
  }

  checkProductVariantAvailability() {
    state.variantProductId = null;

    state.productModel.variants.forEach((variant) {
      bool isVariant = true;
      variant['product_attribute'].forEach((element) {
        state.productModel.attributes.forEach((attribute) {
          if (attribute.id.toString() == element['id'].toString()) {
            attribute.values.forEach((radioItem) {
              if (radioItem.isSelected) {
                if (radioItem.text.toString() != element['value'].toString()) {
                  isVariant = false;
                }
              }
            });
          }
        });
        print('step 2');
      });
      if (isVariant) {
        state.variantProductId = variant['product_id'].toString();
        state.variantProductName = variant['display_name'].toString();
        print('step 3');
      }
    });
  }

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is UpdateProductData) {
      print('update');
      yield state.copyWith(
          productModel: event.productModel,
          isLoading: false,
          variantProductId: event.productModel.id,
          // isViewOnly: event.isViewOnly,
          isViewOnly: false,
          variantProductName: event.productModel.displayName);
    } else if (event is CheckProductVariant) {
      print('step 0');

      state.productModel.attributes[event.index].values.forEach((element) {
        element.isSelected = false;
        if (element.text == event.value) {
          element.isSelected = true;
        }
      });
      print('step 1');

      await checkProductVariantAvailability();
      print('step 4');
      yield state.copyWith();
    } else if (event is FetchProductData) {
      if (state.variantProductId != null) {
        getProductData(state.variantProductId);
      } else {
        getProductData(productId);
      }
      yield state.copyWith(isLoading: true);
    } else if (event is UpdateRelatedProducts) {
      yield state.copyWith(relatedProducts: event.productModels);
    } else if (event is UpdateReviews) {
      yield state.copyWith(reviewModels: event.reviewModels);
    } else if (event is AddProductToCart) {
      if (AppData().isUser) {
        try {
          print('product is used ${state.productModel.isUsedProduct}');
          await productRepository.addNewProductToCart(
              cartType: state.productModel.isUsedProduct?'used':'new', noOfItem: 1, productId: event.id);
          state.productModel.isAddedToCart = true;
          yield state.copyWith();
        } catch (e) {
          yield state.copyWith(actionErrorMessage: e);
        }
      }
    } else if (event is LikeAndUnLikeProduct) {
      if (AppData().isUser) {
        if (state.productModel.isInWishList) {
          try {
            await productRepository.deleteProductFromWishlist(
                wishlistId: state.productModel.wishListId);
            state.productModel.isInWishList = false;

            yield state.copyWith(isProductAddedToCart: true);
          } catch (e) {
            yield state.copyWith(actionErrorMessage: e);
          }
        } else {
          try {
            String wishlistId = await productRepository.addProductToWishList(
                productId: state.productModel.id);
            state.productModel.isInWishList = true;
            state.productModel.wishListId = wishlistId;

            yield state.copyWith();
          } catch (e) {
            yield state.copyWith(actionErrorMessage: e);
          }
        }
      }
    }
  }
}
