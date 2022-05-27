import 'package:oogie/models/attribute_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/order_model.dart';

enum ProductStatus {Published,InReview}
class ProductModel {
  String id,
      name,
      unitPrice,
      offerPrice,
      price,
      discountedPrice,
      discountPercentage,
      brandName,
      brandId,
      description,
      imageUrl,
      modelId,
      unitOfMeasureId,
      displayName,
      rating,
      ratingCount,
      reviewCount,
      categoryId,
      creatorId;
  ProductStatus productStatus;

  bool isAddedToCart;
  bool isInWishList;
  List<String> medias = [];
  int qty;
  String cartId, wishListId;
  double totalPrice;
  List<Map<String, dynamic>> variants = [];
  List<AttributeModel> attributes = [];
  List<SpecificationModel> specificationModels = [];
  List<String> highlights;
  List<KeyValueRadioModel> attributeLines;
  String deliveryState;
  String deliveryOrderId;
  bool isUsedProduct;

  int qtyAvailable;
  String userRole;

  ProductModel(
      {this.medias,
      this.highlights,
      this.creatorId,
      this.deliveryState,
      this.offerPrice,
      this.price,
      this.deliveryOrderId,
      this.isUsedProduct,
      this.totalPrice,
      this.categoryId,
      this.unitOfMeasureId,
      this.modelId,
      this.cartId,
      this.wishListId,
      this.attributeLines,
      this.isInWishList,
      this.qtyAvailable,
      this.qty,
      this.specificationModels,
      this.variants,
      this.attributes,
      this.name,
      this.id,
      this.discountedPrice,
      this.discountPercentage,
      this.unitPrice,
      this.imageUrl,
      this.description,
      this.brandName,
      this.brandId,
      this.displayName,
      this.reviewCount,
      this.isAddedToCart,
      this.ratingCount,
        this.userRole,
        this.productStatus,
      this.rating});
}

class SpecificationModel {
  String heading;
  List<SubSpecificationModel> values;

  SpecificationModel({this.values, this.heading});
}

class SubSpecificationModel {
  String key, value;

  SubSpecificationModel({this.value, this.key});
}
