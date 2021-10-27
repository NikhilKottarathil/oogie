import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/functions/api_calls.dart';
import 'package:oogie/screens/authentication/auth_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthRepository {
  Future<List> attemptAutoLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') != null) {
      String token = sharedPreferences.getString('token');
      String shopId = sharedPreferences.getString('shopId');
      dynamic myBody = {
        'token': token,
      };
      print(token);
      try {
        var body = await postDataRequest(
            address: 'check/token', myBody: myBody);
        if (body['message'] == 'Token Valid') {
          AppData appData = AppData();
          await appData.setUserDetails();
          return [token, shopId];
        } else {
          throw Exception('No authentication permission');
        }
      }catch(e){
        print(e);
      }
    } else {
      throw Exception('not authenticated');
    }
  }

  Future<String> login({String phoneNumber, password}) async {
    dynamic myBody = {'mobile': phoneNumber, 'password': password};
    print(myBody);
    try {
      var body = await postDataRequest(address: 'user/login', myBody: myBody);
      print(body);
      if (body['token'] != null) {
        SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        sharedPreferences.setString('token', body['token']);
        return body['token'];
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw Exception('Login Failed');
        }
      }
    }catch(e){
      print(e);
      throw AppExceptions().serverException;
    }
  }
  Future<String> otpLogin({String token}) async {

    if (token != null) {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      sharedPreferences.setString('token', token);
    }else{
      throw Exception('Please retry');
    }

  }

  Future<String> getSignUpOTP({phoneNumber}) async {
    try {
      dynamic myBody = {
        'mobile': phoneNumber,
      };
      print(myBody);
      var body =
          await postDataRequest(address: 'register/getOtp', myBody: myBody);
      if (body['otp'] != null) {
        return body['otp'].toString();
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw Exception('Please retry');
        }
      }
    } catch (e) {
      print(e);
      throw Exception('Server is Down');
    }
  }
  Future<AuthCredentials> getLoginOTP({phoneNumber}) async {
    try {
      dynamic myBody = {
        'mobile': phoneNumber,
      };
      print(myBody);
      var body =
          await postDataRequest(address: 'getOtp', myBody: myBody);
      if (body['otp'] != null) {

        return AuthCredentials(phoneNumber:phoneNumber,generatedOTP: body['otp'].toString(),token: body['token'].toString() ) ;
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw Exception('Please retry');
        }
      }
    } catch (e) {
      throw Exception('Server is Down');
    }
  }

  Future<String> signUp({String username, phoneNumber, password}) async {
    dynamic myBody = {
      'name': username,
      'mobile': phoneNumber,
      'password': password
    };
    var body = await postDataRequest(address: 'user/signup', myBody: myBody);
    if (body['token'] != null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', body['token']);
      return body['token'];
    } else {
      if (body['message'] != null) {
        throw Exception(body['message']);
      } else {
        throw Exception('Sign retry');
      }
    }
  }

  Future<void> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await sharedPreferences.clear();
    } catch (e) {
      throw Exception('Some error occurred');
    }
  }

  Future<List> getResetPasswordOTP({String phoneNumber}) async {
    try {
      dynamic myBody = {
        'mobile': phoneNumber,
      };
      print(myBody);
      var body = await postDataRequest(
          address: 'user/reset/password/otp', myBody: myBody);
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

  Future<void> changePassword({String password, token}) async {
    try {
      dynamic myBody = {'password': password, 'token': token};
      print(myBody);
      var body =
          await postDataRequest(address: 'user/reset/password', myBody: myBody);
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


// Future<void> changeProfilePicture({File imageFile})async{
//   print(imageFile);
//   try {
//     Map<String,String> myBody = {
//     };
//     print(myBody);
//     var body = await postImageDataRequest(address: 'user/profile', myBody: myBody,imageFile: imageFile,imageAddress: 'profile_pic');
//     if (body['message'] =='Successfully Updated !!') {
//     } else {
//       if (body['message'] != null) {
//         throw Exception(body['message']);
//       } else {
//         throw Exception('Please retry');
//       }
//     }
//     return null;
//   } catch (e) {
//     print(e);
//     throw Exception('Please retry');
//   }
// }
}
