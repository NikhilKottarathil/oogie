import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/components/snack_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

checkLocationEnabled() async {
  if (await Permission.locationWhenInUse.isGranted) {
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}


postDataRequest({var context, address, myBody}) async {
  print('=======$address====================');

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {};
  headers['x-access-token'] = token;

  if (await checkInternetIsConnected()) {
    String url = "https://api.evspace.in/api/$address";
    dynamic response = await http.Client().post(
      Uri.parse(url),
      headers: headers,
      body: myBody,
    );
    print(response.body);
    var body = json.decode(response.body);

    return body;
  } else {
    showSnackBar(context, 'No Internet Connection', null, null);
    var data = {'message': 'noInternet'};
    return data;
  }
}

getDataRequest({var context, address}) async {
  print('=======$address====================');

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {};
  headers['x-access-token'] = token;

  if (await checkInternetIsConnected()) {

    String url = "https://api.evspace.in/api/$address";
    dynamic response = await http.Client().get(
      Uri.parse(url),
      headers: headers,
    );
    print(response.body);
    var body = json.decode(response.body);

    return body;
  } else {
    showSnackBar(context, 'No Internet Connection', null, null);
    var data = {'message': 'noInternet'};

    return data;
  }
}

getDataRequestInBackGround({address}) async {
  print('=======$address====================');

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {};
  headers['x-access-token'] = token;

  if (await checkInternetIsConnected()) {

    String url = "https://api.evspace.in/api/$address";


    dynamic response = await http.Client().get(
      Uri.parse(url),
      headers: headers,
    );
    print(response.body);
    var body = json.decode(response.body);

    return body;
  }
}

patchDataRequest({var context, address, myBody}) async {
  print('=======$address====================');

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {};
  headers['x-access-token'] = token;

  if (await checkInternetIsConnected()) {

    String url = "https://api.evspace.in/api/$address";
    dynamic response = await http.Client().patch(
      Uri.parse(url),
      headers: headers,
      body: myBody,
    );
    print(response.body);
    var body = json.decode(response.body);

    return body;
  } else {
    showSnackBar(context, 'No Internet Connection', null, null);
    var data = {'message': 'noInternet'};
    return data;
  }
}

deleteDataRequest({var context, address}) async {
  print('=======$address====================');

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  Map<String, String> headers = {};
  headers['x-access-token'] = token;

  if (await checkInternetIsConnected()) {
    String url = "https://api.evspace.in/api/$address";
    dynamic response = await http.Client().delete(
      Uri.parse(url),
      headers: headers,
    );
    print(response.body);
    var body = json.decode(response.body);

    return body;
  } else {
    showSnackBar(context, 'No Internet Connection', null, null);
    var data = {'message': 'noInternet'};
    return data;
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


//
// getFutureData(BuildContext context, var future) async {
//   var data;
//   await Future.delayed(Duration(microseconds: 1), () async {
//     await showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Center(
//         child: FutureBuilder(
//           future: future,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               data = snapshot.data;
//               Navigator.pop(context);
//             }
//             // return ColorLoader(duration: Duration(seconds: 1),colors: [Colors.green,Colors.red,Colors.blue,Colors.yellow],);
//             return FlipLoader(shape: 'circle',iconColor: Colors.green,loaderBackground: Colors.white,);
//             // return ColorLoader5();
//             // return Center(
//             //     child: Container(
//             //   width: 100.0,
//             //   height: 100.0,
//             //   decoration: ShapeDecoration(
//             //     color: Colors.white,
//             //     shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.all(
//             //         Radius.circular(10.0),
//             //       ),
//             //     ),
//             //   ),
//             //   child: Center(
//             //     child: CircularProgressIndicator(
//             //       valueColor: AlwaysStoppedAnimation<Color>(
//             //           AppColors.PrimaryColorLight),
//             //     ),
//             //   ),
//             // ));
//           },
//         ),
//       ),
//     );
//   });
//
//   return data;
// }

