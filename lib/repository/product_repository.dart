import 'package:oogie/components/radio_buttons.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/functions/api_calls.dart';
import 'package:oogie/functions/date_conversion.dart';
import 'package:oogie/models/attribute_model.dart';
import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/filter_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/models/review_model.dart';

List<CategoryModel> categoryModels = [];
List<ProductModel> featuresProductModels = [];
List<ProductModel> newArrivedProductModels = [];

List<ProductModel> cartUsedProducts = [];
List<ProductModel> cartNewProducts = [];
List<ProductModel> wishListProducts = [];

class ProductRepository {

  ProductRepository(){
   if( AppData().isUser) {
     setProductsInCart();
     setProductInWishlist();
   }
  }

// CATEGORY
  Future<void> setCategories() async {
    try {
      var body = await getDataRequest(address: 'product_category/list');
      if (body['Product Category'] != null) {
        categoryModels.clear();
        body['Product Category'].forEach((category) {
          categoryModels.add(CategoryModel(
            name: category['display_name'].toString(),
            imageUrl: category['media'] != null
                ? Urls().serverAddress + category['media'].toString()
                : null,
            id: category['id'].toString(),
          ));
        });
      } else {
        throw Exception('Please retry');
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

  Future<List<CategoryModel>> getCategories() async {
    return categoryModels;
  }






  //PRODUCT
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
            discountedPrice: product['unit_price'].toString(),
            discountPercentage: '',
            unitPrice: product['unit_price'].toString(),
          ));
        });

        return productModels;
      } else {
        throw Exception('Please retry');
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
            description: product['description'],
            discountedPrice: product['unit_price'].toString(),
            discountPercentage: '',
            unitPrice: product['unit_price'].toString(),
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
      sort,
      isUsedProduct}) async {
    try {
      print('inside filter page $page rowsPerPage $rowsPerPage');
      var requestBody = {
        'rows_per_page': rowsPerPage,
        'page': page,
        'fields': fields,
        'filters': filters,
        'product_brand_id': productBrandId,
        'category_id': categoryId,
        'product_model_id': productModelId,
        'min_price': minPrice,
        'max_price': maxPrice,
        'rating': rating,
        'sort': sort,
        'is_used_product': isUsedProduct
      };
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
            description: product['description'],
            discountedPrice: product['unit_price'].toString(),
            discountPercentage: '',
            unitPrice: product['unit_price'].toString(),
          ));
        });
        print('productModels');
        print(productModels.length);
        return productModels;
      } else {
        throw Exception('Please retry');
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

        List<String> highlights=[];

        if(product['highlights']!=null){
          product['highlights'].forEach((element){
            highlights.add(element.toString());
          });
        }
        bool isInCart = false, isInWishList = false;
        int cartQty = 1;
        String cartId,wishlistId;

        cartNewProducts.forEach((element) {
          if (element.id == id) {
            isInCart = true;
            cartQty = element.qty;
            cartId=element.cartId;
          }
        });

        cartUsedProducts.forEach((element) {
          if (element.id == id) {
            isInCart = true;
            cartQty = element.qty;
            cartId=element.cartId;

          }
        });
        wishListProducts.forEach((element) {
          if (element.id == id) {
            isInWishList = true;
            wishlistId=element.wishListId;

          }
        });


        ProductModel productModel = new ProductModel(
            id: product['id'].toString(),
            name: product['name'],
            displayName: product['display_name'],
            brandName: product['product_brand'] != null
                ? product['product_brand']['name']
                : null,
            brandId: product['product_brand'] != null
                ? product['product_brand']['id'].toString()
                : null,
            description: product['description'],
            discountedPrice: product['unit_price'].toString(),
            discountPercentage: '',
            unitPrice: product['unit_price'].toString(),
            rating: product['rating'].toString(),
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
    List<ProductModel> cartList=[];
    cartList.addAll(cartUsedProducts);
    cartList.addAll(cartNewProducts);
    cartList.forEach((element) {
      if(element.id ==productId)
        {
          cartId=element.cartId;
          qty=element.qty+1;
        }
    });
    if(cartId==null){
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
    }else{
     await  updateProductQtyInCart(noOfItem: qty,cartId: cartId);
    }

  }

  Future<void> updateProductQtyInCart(
      {String cartId, noOfItem}) async {
    dynamic requestBody = {
      'no_of_item': noOfItem,
    };
    print(requestBody);
    try {
      var body =
          await postDataRequest(address: 'cart_line/$cartId', myBody: requestBody);
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
                totalPrice: double.parse(product['no_of_item'].toString())*double.parse(product['unit_price'].toString()),
                brandName: product['product_brand'].toString(),
                discountedPrice: product['unit_price'].toString(),
                unitPrice: product['unit_price'].toString(),
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
                totalPrice: double.parse(product['no_of_item'].toString())*double.parse(product['unit_price'].toString()),

                name: product['product_name'],
                displayName: product['display_name'],
                brandName: product['product_brand'].toString(),
                discountedPrice: product['unit_price'].toString(),
                unitPrice: product['unit_price'].toString(),
              ));
            });
          }
        }

      } else {
        throw Exception('Please retry');
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
        if(body['id']!=null){
          return body['id'].toString();
        }else{
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
            displayName: product['display_name'],
            brandName: product['product_brand'] != null
                ? product['product_brand']
                : '',
            discountedPrice: product['unit_price'].toString(),
            unitPrice: product['unit_price'].toString(),
          ));
        });
      } else {
        throw Exception('Please retry');
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
