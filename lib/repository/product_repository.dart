import 'package:http/http.dart';
import 'package:oogie/components/radio_buttons.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/functions/api_calls.dart';
import 'package:oogie/functions/date_conversion.dart';
import 'package:oogie/models/advertisement_model.dart';
import 'package:oogie/models/attribute_model.dart';
import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/filter_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/models/review_model.dart';
import 'package:oogie/screens/common/products/add_product/add_product_state.dart';

List<CategoryModel> categoryModels = [];
List<ProductModel> featuresProductModels = [];
List<ProductModel> newArrivedProductModels = [];

List<ProductModel> cartUsedProducts = [];
List<ProductModel> cartNewProducts = [];
List<ProductModel> wishListProducts = [];

class ProductRepository {
  ProductRepository() {
    if (FlavorConfig().flavorName == 'user' && AppData().isUser) {
      setProductsInCart();
      setProductInWishlist();
    }
  }

// CATEGORY
  Future<void> setCategories() async {
    try {
      var body = await getDataRequest(address: 'product_category/list?rows_per_page=100&page=1');
      if (body['Product Category'] != null) {
        categoryModels.clear();
        body['Product Category'].forEach((category) {
          List<AttributeModel> attributeModels = [];
          category['filters'].forEach((element) {
            List values = element['values'].toString().split(',');
            List<RadioModel> subModels = [];

            values.forEach((subElement) {
              subModels.add(RadioModel(false, subElement));
            });

            attributeModels.add(AttributeModel(
                id: element['id'].toString(),
                name: element['name'],
                values: subModels));
          });
          List<CategoryModel> subCategories = [];
          categoryModels.add(CategoryModel(
            name: category['name'].toString(),
            isSelected: false,
            attributeModels: attributeModels,
            imageUrl: category['media'] != null
                ? Urls().serverAddress + category['media'].toString()
                : null,
            id: category['id'].toString(),
          ));
        });
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<KeyValueRadioModel>> getProductBrand() async {
    try {
      var body = await getDataRequest(address: 'product_brand/list?rows_per_page=100&page=1');
      if (body['Product Brand'] != null) {
        List<KeyValueRadioModel> models = [];
        body['Product Brand'].forEach((element) {
          List<KeyValueRadioModel> subModels = [];

          element['product_models'].forEach((subElement) {
            subModels.add(KeyValueRadioModel(
                isSelected: false,
                value: subElement['id'].toString(),
                key: subElement['name']));
          });

          models.add(KeyValueRadioModel(
              isSelected: false,
              value: element['id'].toString(),
              key: element['name'],
              subKeyValueModels: subModels));
        });
        return models;
      } else {
        if (body['message'] != null) {
          throw Exception(body['Message']);
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List> getAttributes() async {
    try {
      var body = await getDataRequest(address: 'product_attribute/list?rows_per_page=100&page=1');
      if (body['Product Attribute'] != null) {
        List<AttributeModel> models = [];
        body['Product Attribute'].forEach((element) {
          List values = element['values'].toString().split(',');
          List<RadioModel> subModels = [];

          values.forEach((subElement) {
            subModels.add(RadioModel(false, subElement));
          });

          models.add(AttributeModel(
              id: element['id'].toString(),
              name: element['name'],
              values: subModels));
        });
        return models;
      } else {
        if (body['message'] != null) {
          throw Exception(body['Message']);
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List> getUnitOfMeasures() async {
    try {
      var body = await getDataRequest(address: 'unit_of_measure/list?rows_per_page=100&page=1');
      if (body['Unit Of Measure'] != null) {
        List<KeyValueRadioModel> models = [];
        body['Unit Of Measure'].forEach((element) {
          models.add(KeyValueRadioModel(
            isSelected: false,
            value: element['id'].toString(),
            key: element['name'],
          ));
        });
        return models;
      } else {
        if (body['message'] != null) {
          throw Exception(body['Message']);
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<FilterModel>> getFiltersOfSelectedCategory(
      {String categoryId}) async {
    List<FilterModel> filterModels = [];
    try {
      var body = await getDataRequest(address: 'product_category/$categoryId');
      if (body['Product Category'] != null) {
        if (body['Product Category']['filters'] != null) {
          filterModels.clear();
          body['Product Category']['filters'].forEach((filter) {
            List<KeyValueRadioModel> values = [];
            if (filter['values'] != null) {
              // filter['values'].forEach((value) {
              //   values.add(KeyValueRadioModel(isSelected: false, key:value.toString(),value: value.toString()));
              // });
              List valuesList = filter['values'].toString().split(',');
              valuesList.forEach((value) {
                values.add(KeyValueRadioModel(
                    isSelected: false,
                    key: value.toString(),
                    value: value.toString()));
              });
            }
            filterModels.add(FilterModel(
                name: filter['name'].toString(),
                id: filter['id'].toString(),
                values: values));
          });
          return filterModels;
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      print(e);
      throw AppExceptions().serverException;
    }
  }

  Future<List<CategoryModel>>


  getCategories() async {
    return categoryModels;
  }

  Future<String> addProduct(
      {AddProductState state,
      String parentPage,
      String isUsedProduct,
      String productId}) async {
    try {
      print('add product pressed');
      // String highLights = '';
      // state.highlights.forEach((element) {
      //   if (highLights.isEmpty) {
      //     highLights = element;
      //   } else {
      //     highLights = highLights + ',' + element;
      //   }
      // });
      // List<Map<String, Map<String, String>>> specifications = [];
      // state.specificationModels.forEach((element) {
      //   Map<String, String> subSpec = {};
      //   element.values.forEach((element) {
      //     subSpec.addAll({element.key: element.value});
      //   });
      //   specifications.add({element.heading: subSpec});
      // });
      List<Map<String, String>> attributes = [];
      state.attributes.forEach((element) {
        Map<String, String> attribute = {'product_attribute_id': element.id};
        element.values.forEach((element) {
          if (element.isSelected) {
            attribute.addAll({'value': element.text});
          }
        });
        attributes.add(attribute);
      });
      dynamic requestBody = {
        'name': state.name,
        // 'media': state.media,
        'unit_price': state.unitPrice,
        'vendor_price': state.unitPrice,
        'description': state.description,
        'category_id': state.categories
            .singleWhere((element) => element.isSelected == true)
            .id,
        'product_brand_id': state.brands
            .singleWhere((element) => element.isSelected == true)
            .value,
        'unit_of_measure_id': state.unitMeasures
            .singleWhere((element) => element.isSelected == true)
            .value,
        'product_model_id': state.models
            .singleWhere((element) => element.isSelected == true)
            .value,
        'qty_available': state.qtyAvailable,
        'product_variants': attributes,
        'vendor_id': '',
        'is_used_product': isUsedProduct,
        // 'specifications': specifications,
        // 'highlights': highLights
      };
      if (state.offerPrice.toString().trim().length != 0) {
        requestBody.addAll({'offer_price': state.offerPrice});
      }
      print(requestBody);
      if (productId == null) {
        var body =
            await postDataRequest(address: 'product', myBody: requestBody);

        if (body['id'] != null) {
          try {
            Map<String, String> imageBody = {};
            await patchMediaDataRequest(
                address: 'product/${body['id'].toString()}',
                myBody: imageBody,
                imageAddress: 'images',
                imageFiles: state.images);
            return body['id'].toString();
          } catch (e) {
            throw Exception(body['Image Upload failed! product created']);
          }
        } else {
          if (body['message'] != null) {
            throw Exception(body['Message']);
          } else {
            throw AppExceptions().somethingWentWrong;
          }
        }
      } else {
        var body = await patchDataRequest(
            address: 'product/$productId', myBody: requestBody);
        if (body['message'] == 'Successfully Updated') {
          return productId;
        } else {
          if (body['message'] != null) {
            throw Exception(body['Message']);
          } else {
            throw AppExceptions().somethingWentWrong;
          }
        }
      }
    } catch (e) {
      print('Error add Product' + e);
      throw e;
    }
  }

  Future<List> getProductsByCreator(
      {int page, rowsPerPage, String parentPage, String isUsedProduct}) async {
    try {
      print('page $page rowsPerPage $rowsPerPage');
      var requestBody = {
        'rows_per_page': rowsPerPage.toString(),
        'page': page.toString()
      };
      var body = await getDataRequest(
          address:
              'product/by_creator?rows_per_page=$rowsPerPage&page=$page&is_used_product=$isUsedProduct');

      if (body['Products'] != null) {
        List<ProductModel> productModels = [];
        body['Products'].forEach((product) {
          String imageUrl;
          int i = 0;
          if (product['media'] != null) {
            product['media'].forEach((media) {
              if (i == 0) {
                imageUrl = Urls().serverAddress + media['url'];
              }
            });
          }
          productModels.add(new ProductModel(
            id: product['id'].toString(),
            imageUrl: imageUrl,
            name: product['name'],
            displayName: product['display_name'],
            brandName: product['product_brand'] != null
                ? product['product_brand']['name']
                : null,
            brandId: product['product_brand'] != null
                ? product['product_brand']['id'].toString()
                : null,
            description: product['description'],
            isUsedProduct: product['is_used_product'] != null
                ? product['is_used_product']
                : false,
            unitPrice: product['unit_price'].toString(),
            offerPrice: product['offer_price'] != null
                ? product['offer_price'].toString()
                : null,
            price: product['offer_price'] != null
                ? product['offer_price'].toString()
                : product['unit_price'].toString(),
            discountPercentage: product['discount_percentage'] != null
                ? product['discount_percentage'].toStringAsFixed(1)
                : '0.0',
            userRole: product['user_role'].toString(),
            productStatus: product['published']?ProductStatus.Published:ProductStatus.InReview
          ));
        });

        return productModels;
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // PRODUCT
  Future<List> getProducts(int page, rowsPerPage, parentPage) async {
    try {
      print('page $page rowsPerPage $rowsPerPage');
      var requestBody = {
        'rows_per_page': rowsPerPage.toString(),
        'page': page.toString()
      };
      var body =
          await postDataRequest(address: 'product/filter', myBody: requestBody);

      if (body['Products'] != null) {
        List<ProductModel> productModels = [];
        body['Products'].forEach((product) {
          String imageUrl;
          int i = 0;
          product['media'].forEach((media) {
            if (i == 0) {
              imageUrl = Urls().serverAddress + media['url'];
            }
          });
          productModels.add(new ProductModel(
            id: product['id'].toString(),
            imageUrl: imageUrl,
            name: product['name'],
            displayName: product['display_name'],
            brandName: product['product_brand'] != null
                ? product['product_brand']['name']
                : null,
            brandId: product['product_brand'] != null
                ? product['product_brand']['id'].toString()
                : null,
            description: product['description'],
            isUsedProduct: product['is_used_product']!=null?product['is_used_product']:false,
            unitPrice: product['unit_price'].toString(),
            offerPrice: product['offer_price']!=null?product['offer_price'].toString():null,
            price: product['offer_price']!=null?product['offer_price'].toString():product['unit_price'].toString(),
            discountPercentage: product['discount_percentage']!=null?product['discount_percentage'].toStringAsFixed(1):'0.0',
            userRole: product['user_role'].toString(),

          ));
        });

        return productModels;
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List> getProductBySearch(
      {String searchString, int page, rowsPerPage}) async {
    try {
      var body = await getDataRequest(
        address:
            'product/name/search?name=$searchString&page=$page&rows_per_page=$rowsPerPage',
      );
      List<CategoryModel> categoryModels = [];
      List<ProductModel> productModels = [];
      if (body['Categories'] != null) {
        body['Categories'].forEach((category) {
          categoryModels.add(CategoryModel(
            name: category['display_name'].toString(),
            imageUrl: category['media'] != null
                ? Urls().serverAddress + category['media'].toString()
                : null,
            id: category['id'].toString(),
          ));
        });
      }

      if (body['Products'] != null) {
        body['Products'].forEach((product) {
          String imageUrl;
          int i = 0;
          product['media'].forEach((media) {
            if (i == 0) {
              imageUrl = Urls().serverAddress + media['url'];
            }
          });
          productModels.add(new ProductModel(
            id: product['id'].toString(),
            imageUrl: imageUrl,
            name: product['name'],
            displayName: product['display_name'],
            brandName: product['product_brand'] != null
                ? product['product_brand']['name']
                : null,
            brandId: product['product_brand'] != null
                ? product['product_brand']['id'].toString()
                : null,
            isUsedProduct: product['is_used_product'] != null
                ? product['is_used_product']
                : false,
            description: product['description'],
            unitPrice: product['unit_price'].toString(),
            offerPrice: product['offer_price'] != null
                ? product['offer_price'].toString()
                : null,
            price: product['offer_price'] != null
                ? product['offer_price'].toString()
                : product['unit_price'].toString(),
            discountPercentage: product['discount_percentage'] != null
                ? product['discount_percentage'].toStringAsFixed(1)
                : '0.0',
            userRole: product['user_role'].toString(),
          ));
        });
      }
      return [categoryModels, productModels];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List> getProductsByFilter(
      {int rowsPerPage,
      page,
      List<Map<String, String>> filters,
      String fields,
      productBrandId,
      categoryId,
      productModelId,
      minPrice,
      maxPrice,
      rating,
      advertisementId,
      sort,
      isUsedProduct}) async {
    try {
      print('inside filter page $page rowsPerPage $rowsPerPage');
      var requestBody = {
        'rows_per_page': rowsPerPage,
        'page': page,

      };
      if (isUsedProduct != null) {
        requestBody.addAll({
          'is_used_product': isUsedProduct ? 'True' : 'False'
        });
      }
      if (minPrice != null) {
        requestBody.addAll({
          'min_price': minPrice,
        });
      }
      if (maxPrice != null) {
        requestBody.addAll({
          'max_price': maxPrice,
        });
      }
      if (sort != null) {
        requestBody.addAll({
          'sort': sort,
        });
      }
      if (rating != null) {
        requestBody.addAll({
          'rating': rating,
        });
      }
      if (advertisementId != null) {
        requestBody.addAll({
          'advertisment_id': advertisementId,
        });
      }
      if (productBrandId != null) {
        requestBody.addAll({
          'product_brand_id': productBrandId,
        });
      }
      if (productModelId != null) {
        requestBody.addAll({
          'product_model_id': productModelId,
        });
      }
      if (categoryId != null) {
        requestBody.addAll({
          'category_id': categoryId,
        });
      }
      if (filters != null && filters.isNotEmpty) {
        requestBody.addAll({
          'filters': filters,
        });
      }
      if (fields != null && fields.isNotEmpty) {
        requestBody.addAll({
          'fields': fields,
        });
      }
      print('filter requestBody');
      print(requestBody);
      var body =
          await postDataRequest(address: 'product/filter', myBody: requestBody);

      if (body['Products'] != null) {
        List<ProductModel> productModels = [];
        body['Products'].forEach((product) {
          String imageUrl;
          int i = 0;
          product['media'].forEach((media) {
            if (i == 0) {
              imageUrl = Urls().serverAddress + media['url'];
            }
          });
          productModels.add(new ProductModel(
            id: product['id'].toString(),
            imageUrl: imageUrl,
            name: product['name'],
            displayName: product['display_name'],
            brandName: product['product_brand'] != null
                ? product['product_brand']['name']
                : null,
            brandId: product['product_brand'] != null
                ? product['product_brand']['id'].toString()
                : null,
            isUsedProduct: product['is_used_product'] != null
                ? product['is_used_product']
                : false,
            description: product['description'],
            unitPrice: product['unit_price'].toString(),
            offerPrice: product['offer_price'] != null
                ? product['offer_price'].toString()
                : null,
            price: product['offer_price'] != null
                ? product['offer_price'].toString()
                : product['unit_price'].toString(),
            discountPercentage: product['discount_percentage'] != null
                ? product['discount_percentage'].toStringAsFixed(1)
                : '0.0',
            userRole: product['user_role'].toString(),
          ));
        });
        print('productModels');
        print(productModels.length);
        return productModels;
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<ProductModel> getDetailsOfSelectedProduct(String id) async {
    try {
      var body = await getDataRequest(address: 'product/$id');

      if (body['Product'] != null) {
        var product = body['Product'];
        List<Map<String, dynamic>> variants = [];
        List<AttributeModel> attributes = [];
        List<String> medias = [];
        product['media'].forEach((media) {
          medias.add(Urls().serverAddress + media['url']);
        });
        await Future.forEach(product['product_variants'], (variant) async {
          variants.add(variant);
          await Future.forEach(variant['product_attribute'], (element) async {
            bool isAttributeNew = true;
            await Future.forEach(attributes, (attribute) {
              if (attribute.id.toString() == element['id'].toString()) {
                List<String> attributeValues = [];
                Future.forEach(attribute.values,
                    (element) => attributeValues.add(element.text));
                if (!attributeValues.contains(element['value'])) {
                  attribute.values.add(RadioModel(
                      variant['product_id'].toString() ==
                          product['id'].toString(),
                      element['value']));
                }
                isAttributeNew = false;
              }
            });
            if (isAttributeNew) {
              attributes.add(AttributeModel(values: [
                RadioModel(
                    variant['product_id'].toString() ==
                        product['id'].toString(),
                    element['value'])
              ], name: element['name'], id: element['id'].toString()));
            }
          });
        });
        List<SpecificationModel> specificationModels = [];
        product['specifications'].forEach((element) {
          List<SubSpecificationModel> subSpecificationModels = [];
          element.forEach((spec, values) {
            values.forEach((key, value) {
              subSpecificationModels.add(SubSpecificationModel(
                  key: key.toString(), value: value.toString()));
            });
            specificationModels.add(SpecificationModel(
                heading: spec.toString(), values: subSpecificationModels));
          });
        });
        List<KeyValueRadioModel> attributeLines = [];

        product['product_variant_attribute_lines'].forEach((element) {
          element.forEach((spec, values) {
            attributeLines.add(KeyValueRadioModel(
                key: element['value'].toString(),
                value: element['product_attribute']['id'].toString()));
          });
        });

        List<String> highlights = [];

        if (product['highlights'] != null) {
          product['highlights'].forEach((element) {
            highlights.add(element.toString());
          });
        }
        bool isInCart = false, isInWishList = false;
        int cartQty = 1;
        String cartId, wishlistId;

        cartNewProducts.forEach((element) {
          if (element.id == id) {
            isInCart = true;
            cartQty = element.qty;
            cartId = element.cartId;
          }
        });

        cartUsedProducts.forEach((element) {
          if (element.id == id) {
            isInCart = true;
            cartQty = element.qty;
            cartId = element.cartId;
          }
        });
        wishListProducts.forEach((element) {
          if (element.id == id) {
            isInWishList = true;
            wishlistId = element.wishListId;
          }
        });

        ProductModel productModel = new ProductModel(
            id: product['id'].toString(),
            name: product['name'],
            displayName: product['display_name'],
            categoryId: product['product_category'] != null
                ? product['product_category']['id'].toString()
                : null,
            brandName: product['product_brand'] != null
                ? product['product_brand']['name']
                : null,
            modelId: product['product_model'] != null
                ? product['product_model']['id'].toString()
                : null,
            brandId: product['product_brand'] != null
                ? product['product_brand']['id'].toString()
                : null,
            unitOfMeasureId: product['unit_of_measure'] != null
                ? product['unit_of_measure']['id'].toString()
                : null,
            description: product['description'],
            unitPrice: product['unit_price'].toString(),
            offerPrice: product['offer_price'] != null
                ? product['offer_price'].toString()
                : null,
            price: product['offer_price'] != null
                ? product['offer_price'].toString()
                : product['unit_price'].toString(),
            discountPercentage: product['discount_percentage'] != null
                ? product['discount_percentage'].toStringAsFixed(1)
                : '0.0',
            userRole: product['user_role'].toString(),
            rating: product['rating'].toString(),
            creatorId: product['user_id'].toString(),
            isUsedProduct: product['is_used_product'] != null
                ? product['is_used_product']
                : false,
            qtyAvailable: product['qty_available'],
            ratingCount: double.parse(product['total_rating'].toString())
                .toStringAsFixed(0),
            reviewCount: double.parse(product['total_rating'].toString())
                .toStringAsFixed(0),
            medias: medias,
            imageUrl: medias.isNotEmpty ? medias[0] : null,
            variants: variants,
            attributes: attributes,
            highlights: highlights,
            isAddedToCart: isInCart,
            qty: cartQty,
            isInWishList: isInWishList,
            attributeLines: attributeLines,
            cartId: cartId,
            wishListId: wishlistId,
            specificationModels: specificationModels);
        return productModel;
      } else {
        print('else1');

        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      print(e);

      throw AppExceptions().serverException;
    }
  }

  //PRODUCT REVIEWS
  Future<List<ReviewModel>> getProductReviews(
      int page, rowsPerPage, productId) async {
    try {
      var body = await getDataRequest(
          address:
              'review/by_product/$productId?rows_per_page=$rowsPerPage&page=$page');
      if (body['Reviews'] != null) {
        List<ReviewModel> reviewModels = [];
        body['Reviews'].forEach((element) {
          reviewModels.add(ReviewModel(
            name: element['comment'].toString(),
            ratingCount: element['rating'].toString(),
            userName: element['user'].toString(),
            createdTime: getTimeDifferenceFromNowString(
                element['updated_date'].toString()),
            id: element['id'].toString(),
          ));
        });
        return reviewModels;
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      print(e);
      throw AppExceptions().serverException;
    }
  }

  //CART
  Future<void> addNewProductToCart(
      {String productId, noOfItem, cartType}) async {
    String cartId;
    int qty;
    List<ProductModel> cartList = [];
    cartList.addAll(cartUsedProducts);
    cartList.addAll(cartNewProducts);
    cartList.forEach((element) {
      if (element.id == productId) {
        cartId = element.cartId;
        qty = element.qty + 1;
      }
    });
    if (cartId == null) {
      dynamic requestBody = {
        'product_id': productId,
        'no_of_item': noOfItem,
        'cart_type': cartType
      };
      print(requestBody);
      try {
        var body =
            await postDataRequest(address: 'add/cart', myBody: requestBody);
        setProductsInCart();
      } catch (e) {
        throw AppExceptions().serverException;
      }
    } else {
      await updateProductQtyInCart(noOfItem: qty, cartId: cartId);
    }
  }

  Future<void> updateProductQtyInCart({String cartId, noOfItem}) async {
    dynamic requestBody = {
      'no_of_item': noOfItem,
    };
    print(requestBody);
    try {
      var body = await postDataRequest(
          address: 'cart_line/$cartId', myBody: requestBody);
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  Future<void> deleteProductFromCart({String cartID}) async {
    print('deltete fromcart $cartID');
    try {
      var body = await deleteDataRequest(address: 'cart_line/$cartID');
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  Future<void> setProductsInCart() async {
    try {
      cartNewProducts.clear();
      cartUsedProducts.clear();
      var body = await getDataRequest(address: 'cart/by_creator');

      if (body['Cart'] != null) {
        if (body['Cart']['new_product'] != null) {
          if (body['Cart']['new_product']['cart_line'] != null) {
            await Future.forEach(body['Cart']['new_product']['cart_line'],
                (product) {
              String imageUrl;
              int i = 0;
              if (product['media'] != null) {
                product['media'].forEach((media) {
                  if (i == 0) {
                    imageUrl = Urls().serverAddress + media['url'];
                    i++;
                  }
                });
              }
              cartNewProducts.add(new ProductModel(
                cartId: product['id'].toString(),
                id: product['product_id'].toString(),
                qty: int.parse(product['no_of_item'].toString()),
                imageUrl: imageUrl,
                name: product['product_name'],
                displayName: product['display_name'],
                totalPrice: double.parse(product['no_of_item'].toString()) *
                    double.parse(product['unit_price'].toString()),
                brandName: product['product_brand'].toString(),
                isUsedProduct: product['is_used_product'] != null
                    ? product['is_used_product']
                    : false,
                unitPrice: product['unit_price'].toString(),
                offerPrice: product['offer_price'] != null
                    ? product['offer_price'].toString()
                    : null,
                price: product['offer_price'] != null
                    ? product['offer_price'].toString()
                    : product['unit_price'].toString(),
                discountPercentage: product['discount_percentage'] != null
                    ? product['discount_percentage'].toStringAsFixed(1)
                    : '0.0',
                userRole: product['user_role'].toString(),
              ));
            });
          }
        }
        if (body['Cart']['used_product'] != null) {
          if (body['Cart']['used_product']['cart_line'] != null) {
            await Future.forEach(body['Cart']['used_product']['cart_line'],
                (product) {
              String imageUrl;
              int i = 0;
              if (product['media'] != null) {
                product['media'].forEach((media) {
                  if (i == 0) {
                    imageUrl = Urls().serverAddress + media['url'];
                    i++;
                  }
                });
              }
              cartUsedProducts.add(new ProductModel(
                cartId: product['id'].toString(),
                id: product['product_id'].toString(),
                qty: int.parse(product['no_of_item'].toString()),
                imageUrl: imageUrl,
                totalPrice: double.parse(product['no_of_item'].toString()) *
                    double.parse(product['unit_price'].toString()),
                name: product['product_name'],
                displayName: product['display_name'],
                isUsedProduct: product['is_used_product'] != null
                    ? product['is_used_product']
                    : false,
                brandName: product['product_brand'].toString(),
                unitPrice: product['unit_price'].toString(),
                offerPrice: product['offer_price'] != null
                    ? product['offer_price'].toString()
                    : null,
                price: product['offer_price'] != null
                    ? product['offer_price'].toString()
                    : product['unit_price'].toString(),
                discountPercentage: product['discount_percentage'] != null
                    ? product['discount_percentage'].toStringAsFixed(1)
                    : '0.0',
                userRole: product['user_role'].toString(),
              ));
            });
          }
        }
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future getProductsInCart() async {
    return [cartNewProducts, cartUsedProducts];
  }

  //WishList

  Future<String> addProductToWishList({String productId}) async {
    bool isNotInWishList = true;
    print('productInWishList');
    wishListProducts.forEach((element) {
      if (element.id == productId) {
        isNotInWishList = false;
      }
    });
    print(isNotInWishList);
    if (isNotInWishList) {
      dynamic requestBody = {
        'product_id': productId,
      };
      print(requestBody);
      try {
        var body =
            await postDataRequest(address: 'wishlist', myBody: requestBody);
        if (body['id'] != null) {
          return body['id'].toString();
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      } catch (e) {
        throw AppExceptions().serverException;
      }
    }
  }

  Future<void> deleteProductFromWishlist({String wishlistId}) async {
    try {
      var body = await deleteDataRequest(address: 'wishlist/$wishlistId');
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  Future<void> setProductInWishlist() async {
    try {
      var body = await getDataRequest(address: 'wishlist/by_creator');
      wishListProducts.clear();

      if (body['Wishlist'] != null) {
        body['Wishlist'].forEach((product) {
          String imageUrl;
          int i = 0;
          if (product['media'] != null) {
            product['media'].forEach((media) {
              if (i == 0) {
                imageUrl = Urls().serverAddress + media['url'];
                i++;
              }
            });
          }

          wishListProducts.add(new ProductModel(
            wishListId: product['id'].toString(),
            id: product['product_id'].toString(),
            imageUrl: imageUrl,
            rating:
                product['rating'] != null ? product['rating'].toString() : '1',
            name: product['name'],
            isUsedProduct: product['is_used_product'] != null
                ? product['is_used_product']
                : false,
            displayName: product['display_name'],
            brandName: product['product_brand'] != null
                ? product['product_brand']
                : '',
            unitPrice: product['unit_price'].toString(),
            offerPrice: product['offer_price'] != null
                ? product['offer_price'].toString()
                : null,
            price: product['offer_price'] != null
                ? product['offer_price'].toString()
                : product['unit_price'].toString(),
            discountPercentage: product['discount_percentage'] != null
                ? product['discount_percentage'].toStringAsFixed(1)
                : '0.0',
            userRole: product['user_role'].toString(),
          ));
        });
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<AdvertisementModel>> getAdvertisements() async {
    try {
      var body = await getDataRequest(address: 'advertisment/list');
      List<AdvertisementModel> advertisementModels = [];

      if (body['Advertisments'] != null) {
        body['Advertisments'].forEach((product) {
          String imageUrl;
          List<String> medias = [];
          int i = 0;
          if (product['media'] != null) {
            product['media'].forEach((media) {
              if (i == 0) {
                imageUrl = Urls().serverAddress + media['url'];
                i++;
              }
            });
          }

          advertisementModels.add(new AdvertisementModel(
            id: product['id'].toString(),
            imageUrl: imageUrl,
            description: product['description'].toString(),
            title: product['title'].toString(),
            medias: medias,
          ));
        });
        return advertisementModels;
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<ProductModel>> getProductInWishlist({String wishlistId}) async {
    return wishListProducts;
  }
}
