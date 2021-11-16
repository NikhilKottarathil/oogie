import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/functions/api_calls.dart';
import 'package:oogie/functions/date_conversion.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/models/product_model.dart';

class OrderRepository {
  Future<String> createAnOrder(
      {double total,
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
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  Future<String> editSelectedOrder(String orderId, invoiceId) async {
    dynamic requestBody = {
      'invoice_id': invoiceId,
    };
    print(requestBody);
    try {
      var body = await patchDataRequest(
          address: 'order/$orderId', myBody: requestBody);
      if (body['id'] != null) {
        return body['Successfully Updated'].toString();
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  Future<String> createAnInvoice(double total, deliveryCharge, String addressId,
      List<ProductModel> productModels) async {
    Map<String, dynamic> products = {};
    productModels.forEach((element) {
      products.addAll({
        'product_id': element.id,
        'unit_price': element.unitPrice,
        'no_of_item': element.qty,
        'total': element.totalPrice
      });
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
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  Future<List<OrderModel>> getDeliveryOrders(
      {int page,
      rowsPerPage,
      String vendorId,
      parentPage,
      String agentType,
      String deliveryType,
      String state,
      DateTime fromDate,
      DateTime toDate}) async {
    try {
      Map<String, dynamic> requestBody = {
        'rows_per_page': rowsPerPage.toString(),
        'page': page.toString(),
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
      var body = await postDataRequest(
          address:
              'delivery_order/' + FlavorConfig().flavorValue + '/$vendorId',
          myBody: requestBody);

      if (body['Delivery_Orders'] != null) {
        List<OrderModel> models = [];

        await Future.forEach(body['Delivery_Orders'], (element) {
          List<ProductModel> productModels=[];

          element['order_line'].forEach((product){
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
              qty: product['no_of_item'],
              name: product['product_name'],
              unitPrice: product['unit_price'].toString(),
            ));productModels.add(new ProductModel(
              id: product['id'].toString(),
              imageUrl: imageUrl,
              qty: product['no_of_item'],
              name: product['product_name'],
              unitPrice: product['unit_price'].toString(),
            ));
          });
          models.add(new OrderModel(
              id: element['id'].toString(),
              date: getDateTimeFromNowStringFormat(element['create_date']),
              state: element['state'],
              products: productModels,
              total: element['total']));

        });

        return models;
      } else {
        throw Exception('Please retry');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
