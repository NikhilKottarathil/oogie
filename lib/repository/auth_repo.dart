import 'package:firebase_auth/firebase_auth.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/functions/api_calls.dart';
import 'package:oogie/screens/common/authentication/auth_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<List> attemptAutoLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') != null) {
      String token = sharedPreferences.getString('token');
      dynamic myBody = {
        'token': token,
      };
      print(token);
      print('shopId');
      try {
        var body =
            await postDataRequest(address: 'check/token', myBody: myBody);
        if (body['message'] == 'Token Valid') {
          AppData appData = AppData();
          bool isShopSelected = await appData.setUserDetails();
          return [token, isShopSelected];
        } else {
          throw Exception('No authentication permission');
        }
      } catch (e) {
        throw Exception('No authentication permission');
      }
    } else {
      throw Exception('not authenticated');
    }
  }

  Future<AuthCredentials> login({String phoneNumber, password}) async {
    dynamic myBody = {'mobile': phoneNumber, 'password': password};
    print(myBody);
    try {
      var body = await postDataRequest(
          address: FlavorConfig().flavorValue + '/login', myBody: myBody);
      if (body['token'] != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString('token', body['token'].toString());
        await sharedPreferences.setString(
            'firebase_token', body['firebase_token'].toString());
        return AuthCredentials(
            phoneNumber: phoneNumber,
            generatedOTP: body['otp'].toString(),
            firebaseToken: body['firebase_token'].toString(),
            token: body['token'].toString());
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

  Future<void> firebaseCustomLogin({String token}) async {}

  Future<AuthCredentials> loginByOTP({phoneNumber}) async {
    try {
      dynamic myBody = {
        'mobile': phoneNumber,
      };
      print(myBody);
      var body = await postDataRequest(address: 'getOtp', myBody: myBody);
      if (body['token'] != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString('token', body['token'].toString());
        await sharedPreferences.setString(
            'firebase_token', body['firebase_token'].toString());
        return AuthCredentials(
            phoneNumber: phoneNumber,
            generatedOTP: body['otp'].toString(),
            firebaseToken: body['firebase_token'].toString(),
            token: body['token'].toString());
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  //normal

  // Future<String> getSignUpOTP({phoneNumber}) async {
  //   try {
  //     dynamic myBody = {
  //       'mobile': phoneNumber,
  //     };
  //     print(myBody);
  //     var body =
  //         await postDataRequest(address: 'register/getOtp', myBody: myBody);
  //     if (body['otp'] != null) {
  //       return body['otp'].toString();
  //     } else {
  //       if (body['message'] != null) {
  //         throw Exception(body['message']);
  //       } else {
  //         throw Exception('Please retry');
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw Exception('Server is Down');
  //   }
  // }

  Future<AuthCredentials> signUp(
      {String username, phoneNumber, password}) async {
    dynamic myBody = {
      'name': username,
      'mobile': phoneNumber,
      'password': password
    };
    try {
      var body = await postDataRequest(
          address: FlavorConfig().flavorValue + '/signup', myBody: myBody);
      if (body['token'] != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString('token', body['token']);
        await sharedPreferences.setString(
            'firebase_token', body['firebase_token']);
        return AuthCredentials(
            phoneNumber: phoneNumber,
            firebaseToken: body['firebase_token'].toString(),
            token: body['token'].toString());
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      print(e);
      throw AppExceptions().serverException;
    }
  }

  Future<void> logOut() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.clear();
    AppData().clearAllData();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.signOut();
  }

  Future<List> getResetPasswordOTP({String phoneNumber}) async {
    try {
      dynamic myBody = {
        'mobile': phoneNumber,
      };
      print(myBody);
      var body = await postDataRequest(
          address: FlavorConfig().flavorValue + '/reset/password/otp',
          myBody: myBody);
      if (body['otp'] != null) {
        return [body['otp'].toString(), body['token'].toString()];
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      print(e);
      throw AppExceptions().serverException;
    }
  }

  Future<void> changePassword({String password, token, mobile}) async {
    try {
      dynamic myBody = {'password': password, 'token': token,'mobile':mobile};
      print(myBody);
      var body = await postDataRequest(
          address: FlavorConfig().flavorValue + '/reset/password',
          myBody: myBody);
      if (body['message'] == 'Password Successfully Changed !!') {
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw Exception('Please retry');
        }
      }
    } catch (e) {
      throw Exception('Please retry');
    }
  }
}
