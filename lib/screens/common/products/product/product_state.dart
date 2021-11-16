import 'package:oogie/models/product_model.dart';
import 'package:oogie/models/review_model.dart';

class ProductState {
  ProductModel productModel;
  List<ReviewModel> reviewModels;
  List<ProductModel> relatedProducts;
  List<Map<String, dynamic>> attributes;
  List<Map<String, dynamic>> variants;
  bool isLoading;
  String parentPage;
  String variantProductId;
  String variantProductName;
  Exception actionErrorMessage;

  ProductState({
    this.productModel,
    this.relatedProducts,
    this.reviewModels,
    this.attributes,
    this.variants,
    this.parentPage,
    this.variantProductId,
    this.variantProductName,
    this.actionErrorMessage,
    this.isLoading = false,
  });

  ProductState copyWith({
    ProductModel productModel,
    List<ReviewModel> reviewModels,
    List<ProductModel> relatedProducts,
    List<Map<String, dynamic>> attributes,
    List<Map<String, dynamic>> variants,
    bool isLoading,
    String parentPage,
    String variantProductId,
    String variantProductName,
    Exception actionErrorMessage,
    bool isProductAddedToCart,
  }) {
    return ProductState(
      productModel: productModel ?? this.productModel,
      reviewModels: reviewModels ?? this.reviewModels,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      attributes: attributes ?? this.attributes,
      isLoading: isLoading ?? this.isLoading,
      variants: variants ?? this.variants,
      parentPage: parentPage ?? this.parentPage,
      variantProductId: variantProductId ?? this.variantProductId,
      variantProductName: variantProductName ?? this.variantProductName,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
    );
  }
}
