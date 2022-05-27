import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

postDataRequest({address, myBody}) async {
  print('=======$address====================');

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {"Content-Type": "application/json"};
  headers['x-access-token'] = token;

  if (await checkInternetIsConnected()) {
    String url = Urls().apiAddress + address;
    print(url);
    dynamic response = await http.post(Uri.parse(url),
        headers: headers,
        body: json.encode(myBody),
        encoding: Encoding.getByName("utf-8"));
    var body = json.decode(response.body);

    print(body);

    return body;
  } else {
    var data = {'message': 'noInternet'};
    return data;
  }
}

getDataRequest({address}) async {
  print('=======$address====================');

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {};
  headers['x-access-token'] = token;

  print('x-access-token $token');
  // eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwdWJsaWNfaWQiOiJ2ZW5kb3ItNTRmYjQ5OGMtYWFjMy00MTRhLWIyNWEtYmIyZjcxMzIyNzQxLWVjb21tZXJjZSJ9.Ki8vFXiM7b1sR85cODoKaqR6TNTpbQmLRMxQXJDR71U
  if (await checkInternetIsConnected()) {
    String url = Urls().apiAddress + address;
    dynamic response = await http.Client().get(
      Uri.parse(url),
      headers: headers,
    );
    print(response.body);
    var body = json.decode(response.body);

    return body;
  } else {
    var data = {'message': 'noInternet'};
    return data;
  }
}

patchDataRequest({address, myBody}) async {
  print('=======$address====================');

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {"Content-Type": "application/json"};
  headers['x-access-token'] = token;

  if (await checkInternetIsConnected()) {
    String url = Urls().apiAddress + address;
    dynamic response = await http.Client().patch(Uri.parse(url),
        headers: headers,
        body: json.encode(myBody),
        encoding: Encoding.getByName("utf-8"));
    print(response.body);
    var body = json.decode(response.body);

    return body;
  } else {
    var data = {'message': 'noInternet'};
    return data;
  }
}

deleteDataRequest({address}) async {
  print('=======$address====================');

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {};
  headers['x-access-token'] = token;

  if (await checkInternetIsConnected()) {
    String url = Urls().apiAddress + address;
    dynamic response = await http.Client().delete(
      Uri.parse(url),
      headers: headers,
    );
    print(response.body);
    var body = json.decode(response.body);

    return body;
  } else {
    var data = {'message': 'noInternet'};
    return data;
  }
}

postSingleImageDataRequest(
    {String address, imageAddress, var myBody, File imageFile}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {};
  headers['x-access-token'] = token;
  print('in pbobst inage');
  try {
    if (await checkInternetIsConnected()) {
      print('net connectuin');

      var request =
          http.MultipartRequest('POST', Uri.parse(Urls().apiAddress + address));
      request.headers.addAll(headers);
      request.fields.addAll(myBody);
      if (imageFile != null) {
        request.files.add(http.MultipartFile(imageAddress,
            imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
            filename: imageFile.path.split("/").last));
      }
      http.Response response =
          await http.Response.fromStream(await request.send());
      var body = json.decode(response.body);
      return body;
    } else {
      var data = {'message': 'noInternet'};
      return data;
    }
  } catch (e) {
    print(e);
  }
}

postListImageDataRequest(
    {String address, imageAddress, var myBody, List imageFiles}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {};
  headers['x-access-token'] = token;
  print('in pbobst inage');
  print(myBody);
  try {
    if (await checkInternetIsConnected()) {
      print('net connectuin');

      var request =
          http.MultipartRequest('POST', Uri.parse(Urls().apiAddress + address));
      request.headers.addAll(headers);
      request.fields.addAll(myBody);
      // imageFiles.forEach((imageFile) {
      //   request.files.add(http.MultipartFile(imageAddress,
      //       imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
      //       filename: imageFile.path.split("/").last));
      // });
      List<http.MultipartFile> newList = [];
      for (int i = 0; i < imageFiles.length; i++) {
        http.MultipartFile multipartFile = http.MultipartFile(imageAddress,
            imageFiles[i].readAsBytes().asStream(), imageFiles[i].lengthSync(),
            filename: imageFiles[i].path.split("/").last);
        newList.add(multipartFile);
      }
      request.files.addAll(newList);

      print('listing ok');
      try {
        http.Response response =
            await http.Response.fromStream(await request.send());
        var body = json.decode(response.body);

        return body;
      } catch (e) {
        print('fgdf');
        print(e);
      }
    } else {
      var data = {'message': 'noInternet'};
      return data;
    }
  } catch (e) {
    print(e);
  }
}


patchMediaDataRequest(
    {String address, imageAddress, var myBody, List imageFiles}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {};
  headers['x-access-token'] = token;
  print('in pbobst inage');
  print(myBody);
  try {
    if (await checkInternetIsConnected()) {
      print('net connectuin');

      var request =
      http.MultipartRequest('PATCH', Uri.parse(Urls().apiAddress + address));
      request.headers.addAll(headers);
      request.fields.addAll(myBody);
      // imageFiles.forEach((imageFile) {
      //   request.files.add(http.MultipartFile(imageAddress,
      //       imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
      //       filename: imageFile.path.split("/").last));
      // });
      List<http.MultipartFile> newList = [];
      for (int i = 0; i < imageFiles.length; i++) {
        http.MultipartFile multipartFile = http.MultipartFile(imageAddress,
            imageFiles[i].readAsBytes().asStream(), imageFiles[i].lengthSync(),
            filename: imageFiles[i].path.split("/").last);
        newList.add(multipartFile);
      }
      request.files.addAll(newList);

      print('listing ok');
      try {
        http.Response response =
        await http.Response.fromStream(await request.send());
        var body = json.decode(response.body);

        return body;
      } catch (e) {
        print('fgdf');
        print(e);
      }
    } else {
      var data = {'message': 'noInternet'};
      return data;
    }
  } catch (e) {
    print(e);
  }
}
checkInternetIsConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}
