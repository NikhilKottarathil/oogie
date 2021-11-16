// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:oogie/screens/common/authentication/auth_credentials.dart';
//
//
// enum AuthState { login,loginWithOTP, signUp, verifySignUp,forgotPassword }
//
// class AuthCubit extends Cubit<AuthState> {
//
//   AuthCubit() : super(AuthState.login);
//
//   AuthCredentials authCredentials;
//
//   void showLogin() => emit(AuthState.login);
//   void showLoginWithOTP() => emit(AuthState.loginWithOTP);
//   void showResetPassword() => emit(AuthState.forgotPassword);
//
//   void showSignUp() => emit(AuthState.signUp);
//
//   void showVerifySignUp(
//       {String userName, String phoneNumber, String password,String verifyOTP}) {
//     authCredentials = AuthCredentials(
//       userName: userName,
//       phoneNumber: phoneNumber,
//       password: password,
//       verifyOTP: verifyOTP
//     );
//     emit(AuthState.verifySignUp);
//   }
//
//
// }
