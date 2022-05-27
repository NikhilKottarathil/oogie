import 'dart:io';

import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/functions/api_calls.dart';
import 'package:oogie/functions/date_conversion.dart';
import 'package:oogie/models/address_model.dart';
import 'package:oogie/models/delivery_order_Model.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/screens/shopping/checkout/checkout_state.dart';

class OrderRepository {
  Future<String> createAnOrder({double total,
    deliveryCharge,
    String addressId,
    List<ProductModel> productModels}) async {
    var products = [];
    await Future.forEach(productModels, (element) async {
      var product = {
        'product_id': element.id,
        "unit_price": element.unitPrice,
        'no_of_item': element.qty,
        'total': element.totalPrice
      };
      products.add(product);
    });

    dynamic requestBody = {
      'total': total,
      'products': products,
      'delivery_charge': deliveryCharge,
      'address_id': addressId,
    };
    print(requestBody);
    try {
      var body = await postDataRequest(address: 'order', myBody: requestBody);
      if (body['id'] != null) {
        return body['id'].toString();
      }
      if (body['message'] != null) {
        throw Exception(body['message'].toString());
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> confirmSelectedOrder({String orderId, invoiceId}) async {
    dynamic requestBody = {
      'invoice_id': invoiceId,
    };
    print(requestBody);
    try {
      var body = await postDataRequest(
          address: 'order/confirm/$orderId', myBody: requestBody);
      if (body['message'] != null &&
          body['message'] == 'Your Order Is Confirmed') {} else {
        if (body['message'] != null) {
          throw Exception(body['message'].toString());
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<String> createAnInvoice({double total,
    PaymentTypeState paymentTypeState,
    String fullName,
    remarks,
    orderId}) async {
    Map requestBody = {
      'full_name': fullName,
      'order_id': orderId,
      'mode_of_payment':
      paymentTypeState == PaymentTypeState.online ? 'online' : 'cod',
      'invoice_type': 'invoice',
      'total': total,
    };
    if (remarks
        .toString()
        .trim()
        .isNotEmpty) {
      requestBody.addAll({'remarks': remarks});
    }
    print(requestBody);
    try {
      var body = await postDataRequest(
          address: 'account_invoice', myBody: requestBody);
      if (body['id'] != null) {
        return body['id'].toString();
      } else {
        if (body['message'] != null) {
          throw Exception(body['message'].toString());
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<OrderModel>> getOrdersByUser(
      {int page, rowsPerPage, String orderStatus}) async {
    try {
      var body = await getDataRequest(
          address: 'order/by_creator?page=$page&rows_per_page=$rowsPerPage');
      if (body['Orders'] != null) {
        if (body['Orders'] != null) {
          List<OrderModel> models = [];

          await Future.forEach(body['Orders'], (element) {
            List<ProductModel> productModels = [];

            element['delivery'].forEach((delivery) {
              delivery['order_line'].forEach((product) {
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
                  id: product['product_id'].toString(),
                  deliveryOrderId: delivery['id'].toString(),
                  deliveryState: delivery['state'],
                  imageUrl: imageUrl,
                  qty: product['no_of_item'],
                  name: product['product_name'],
                  price: product['unit_price'].toString(),

                ));
              });
            });
            models.add(new OrderModel(
              id: element['order']['id'].toString(),
              date: getDateTimeFromStringFormat(
                  element['order']['create_date']),
              //         state: element['state'],
              products: productModels,
              //         total: element['total']
            ));
          });

          return models;
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      } else {
        if (body['message'] != null) {
          throw Exception(body['message'].toString());
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<OrderModel> getDetailsOfSelectedOrder({String orderId}) async {
    try {
      var body = await getDataRequest(address: 'order/$orderId');
      if (body['Order'] != null) {
        var element = body['Order'];
        List<ProductModel> productModels = [];

        // element['delivery'].forEach((delivery) {
        // });
        element['order_line'].forEach((product) {
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
            id: product['product_id'].toString(),
            // deliveryOrderId: delivery['id'].toString(),
            // deliveryState: delivery['state'],
            imageUrl: imageUrl,
            qty: product['no_of_item'],
            name: product['product_name'],
            price: product['unit_price'].toString(),

          ));
        });

        return OrderModel(
          id: element['id'].toString(),
          date: getDateTimeFromStringFormat(element['create_date']),
          //         state: element['state'],
          products: productModels,
          //         total: element['total']
        );
      } else {
        if (body['message'] != null) {
          throw Exception(body['message'].toString());
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<DeliveryOrderModel> getDetailsOfSelectedDeliveryOrder(
      {String deliveryOrderId}) async {
    try {
      var body =
      await getDataRequest(address: 'delivery_order/$deliveryOrderId');
      if (body['Delivery Order'] != null) {
        List<ProductModel> productModels = [];

        var delivery = body['Delivery Order'];
        print('delivery');
        print(delivery);
        List<DeliveryState> deliveryStatuses = [];
        delivery['delivery_status'].forEach((state) {
          deliveryStatuses.add(DeliveryState(
              name: state['name'].toString(),
              datetimeString: state['create_date']));
        });

        delivery['order_line'].forEach((product) {
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
            id: product['product_id'].toString(),
            deliveryOrderId: delivery['id'].toString(),
            deliveryState: delivery['state'],
            imageUrl: imageUrl,
            qty: product['no_of_item'],
            name: product['product_name'],
            price: product['unit_price'].toString(),
            totalPrice: double.parse(product['unit_price'].toString()) *
                double.parse(product['no_of_item'].toString()),

          ));
        });
        AddressModel shippingAddressModel;
        if (delivery['shipping_address'] != null) {
          var address = delivery['shipping_address'];
          shippingAddressModel = AddressModel(
            id: address['id'].toString(),
            name: address['name'].toString(),
            phoneNumber: address['mobile'].toString(),
            alternativePhoneNumber: address['alternative_mobile'].toString(),
            pinCode: address['zipcode'].toString(),
            state: address['state'].toString(),
            city: address['city'].toString(),
            address1: address['address1'].toString(),
            address2: address['address2'].toString(),
            landmark: address['landmark'] != null
                ? address['landmark'].toString()
                : '',
          );
        }
        bool isUserProductOrder = delivery['is_used_product'] != null
            ? delivery['is_used_product']
            : false;
        AddressModel pickingAddressModel;
        if (delivery['picking_address'] != null) {
          var address = delivery['picking_address'];

          pickingAddressModel = isUserProductOrder ? AddressModel(
            id: address['id'].toString(),
            name: address['name'].toString(),
            phoneNumber: address['mobile'].toString(),
            alternativePhoneNumber: address['alternative_mobile'].toString(),
            pinCode: address['zipcode'].toString(),
            state: address['state'].toString(),
            city: address['city'].toString(),
            address1: address['address1'].toString(),
            address2: address['address2'].toString(),
            landmark: address['landmark'] != null
                ? address['landmark'].toString()
                : '',
          ) : AddressModel(
            id: address['id'].toString(),
            name: address['name'].toString(),
            phoneNumber: address['mobile'].toString(),
            // alternativePhoneNumber: address['alternative_mobile'].toString(),
            pinCode: address['zip_code'].toString(),
            state: address['country'].toString(),
            city: address['street_name'].toString() +
                ', ' +
                address['district'].toString(),
            address1: address['contact_person_name'].toString(),
            address2: address['building_name'].toString(),
            landmark: address['landmark'] != null
                ? address['landmark'].toString()
                : '',
          );
        }
        return DeliveryOrderModel(
            id: delivery['id'].toString(),
            orderId: delivery['sale_id'].toString(),
            date: getDateTimeFromStringFormat(
                delivery['create_date'].toString()),
            createdDate: getDateFromStringFormat(
                delivery['create_date'].toString()),
            isUSedProductOrder: delivery['is_used_product'] != null
                ? delivery['is_used_product']
                : false,
            reviewId: delivery['review_id'] != null ? delivery['review_id']
                .toString() : null,
            deliveryState: delivery['state'],
            deliveryStatuses: deliveryStatuses,
            products: productModels,
            shippingAddressModel: shippingAddressModel,
            pickingAddressModel: pickingAddressModel);
      } else {
        if (body['message'] != null) {
          throw Exception(body['message'].toString());
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<OrderModel>> getDeliveryOrders({int page,
    rowsPerPage,
    String vendorId,
    parentPage,
    String agentType,
    String deliveryType,
    List states,
    DateTime fromDate,
    DateTime toDate}) async {
    try {
      Map<String, dynamic> requestBody = {
        'rows_per_page': rowsPerPage.toString(),
        'page': page.toString(),
        'delivery_type': deliveryType,
        'state': states
      };
      if (fromDate != null && toDate != null) {
        Map<String, dynamic> dateBoy = {
          'from_date': fromDate.millisecondsSinceEpoch,
          'to_date': toDate.millisecondsSinceEpoch,
        };
        requestBody.addAll(dateBoy);
      }
      print(fromDate);
      print(toDate);
      print(requestBody);
      String agentType = (FlavorConfig().flavorValue == 'sales_executives' ||
          FlavorConfig().flavorValue == 'distributor')
          ? 'vendor'
          : FlavorConfig().flavorValue;
          var body = await postDataRequest(
          address:
          'delivery_order/' + agentType + '/$vendorId',
          myBody: requestBody);

      if (body['Delivery_Orders'] != null) {
        List<OrderModel> models = [];

        await Future.forEach(body['Delivery_Orders'], (element) {
          List<ProductModel> productModels = [];

          element['order_line'].forEach((product) {
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
              deliveryOrderId: element['id'].toString(),
              imageUrl: imageUrl,
              qty: product['no_of_item'],
              name: product['product_name'],
              price: product['unit_price'].toString(),

            ));
          });
          models.add(new OrderModel(
              id: element['id'].toString(),
              date: getDateTimeFromStringFormat(element['create_date']),
              deliveryState: element['state'],
              products: productModels,
              total: element['total']));
        });

        return models;
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> requestOrderReturn({List<
      File> files, String reason, String deliveryOrderId, ifsc, bankName, branch, accountNumber}) async {
    try {
      Map<String, String> requestBody = {
        'return_reason': reason.toString(),
        'delivery_type': 'return',
        'state': 'Return Initiated',
        'ifsc': ifsc,
        'bank_name': bankName,
        'branch': branch,
        'account_number': accountNumber
      };

      print(requestBody);
      print('0001');
      var body = await patchMediaDataRequest(
          imageAddress: 'images',
          imageFiles: files,
          address: 'delivery_order/$deliveryOrderId',
          myBody: requestBody);
      print('0002');

      if (body != null && body['message'] == 'Successfully Updated') {
        print('0003');
      } else {
        print('0004');

        if (body != null && body['message'] != null) {
          throw Exception(body['message'].toString());
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addReview(
      { String rating, review, productId, deliveryOrderId}) async {
    try {
      Map<String, String> requestBody = {
        'rating': rating.toString(),
        'comment': review,
        'associated_id': productId,
        'delivery_order_id': deliveryOrderId
      };

      print(requestBody);

      var body = await postDataRequest(address: 'review', myBody: requestBody);

      if (body != null && body['message'] == 'Successfully Created') {

      } else {
        if (body != null && body['message'] != null) {
          throw Exception(body['message'].toString());
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  updateDeliveryOrder({String deliveryOrderId, deliveryState}) async {
    Map<String, String> requestBody = {
      'state': deliveryState,
    };
    // Map<String, String> requestBody = {
    //   'state': 'Shipped',
    //   'delivery_boy_id':'21121800009'
    // };

    try {
      var body = await patchDataRequest(
          address: 'delivery_order/$deliveryOrderId', myBody: requestBody);

      if (body != null && body['message'] == 'Successfully Updated') {} else {
        if (body != null && body['message'] != null) {
          throw Exception(body['message'].toString());
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
