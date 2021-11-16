import 'package:oogie/functions/api_calls.dart';
import 'package:oogie/models/user_model.dart';

class DistributorRepository {
  Future<List<UserModel>> getConnectionAgents(
      int page, rowsPerPage, parentPage) async {
    try {
      // var requestBody = {
      //   'rows_per_page': rowsPerPage.toString(),
      //   'page': page.toString()
      // };
      var body = await getDataRequest(address: 'connection_agents/list');

      if (body['result'] != null) {
        List<UserModel> models = [];
        await Future.forEach(body['result']['wholesale_dealer'], (element) {
          models.add(new UserModel(
            id: element['id'].toString(),
            name: element['name'],
            userType: 'wholesale_dealer',
            email: element['email'],
            phoneNumber: element['mobile'],
          ));
        });
        await Future.forEach(body['result']['vendors'], (element) {
          models.add(new UserModel(
            id: element['id'].toString(),
            name: element['name'],
            email: element['email'],
            userType: 'vendor',
            phoneNumber: element['mobile'],
          ));
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
