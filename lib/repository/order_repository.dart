import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/functions/api_calls.dart';
import 'package:oogie/models/product_model.dart';

class OrderRepository {
 Future<String> createAnOrder({double total, deliveryCharge, String addressId,
      List<ProductModel> productModels}) async {
   var products=[];
  await Future.forEach(productModels,(element)async {
      var product= {'product_id': element.id,"unit_price":element.unitPrice,'no_of_item':element.qty,'total':element.totalPrice};
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
      var body =
          await postDataRequest(address: 'order', myBody: requestBody);
      if (body['id'] != null) {
        return body['id'].toString();
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

 Future<String> editSelectedOrder(String  orderId,invoiceId) async {

   dynamic requestBody = {
     'invoice_id': invoiceId,

   };
   print(requestBody);
   try {
     var body =
     await patchDataRequest(address: 'order/$orderId', myBody: requestBody);
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
     products.addAll({'product_id': element.id,'unit_price':element.unitPrice,'no_of_item':element.qty,'total':element.totalPrice});
   });

   dynamic requestBody = {
     'total': total,
     'products': products,
     'delivery_charge': deliveryCharge,
     'address_id': addressId,
   };
   print(requestBody);
   try {
     var body =
     await postDataRequest(address: 'order', myBody: requestBody);
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
