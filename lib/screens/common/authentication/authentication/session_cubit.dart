import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/repository/auth_repo.dart';

enum SessionState {
  Authenticated,
  UnAuthenticated,
  UnKnown,
  SelectLocationAndShop
}

class SessionCubit extends Cubit<SessionState> {
  AuthRepository authRepository;

  SessionCubit({this.authRepository}) : super(SessionState.UnKnown) {
    attemptToLogin();
  }

  Future<void> attemptToLogin() async {
    print('try Authenticated');
    try {
      List data = await authRepository.attemptAutoLogin();
      await Future.delayed(Duration(seconds: 2));
      if (data[1] != null && data[1]) {
        emit(SessionState.Authenticated);
      } else {
        emit(SessionState.SelectLocationAndShop);
      }
    } catch (e) {
      emit(SessionState.UnAuthenticated);
      print('UnAuthenticated');
    }
  }
//
// AuthCredentials authCredentials;

//
// void showLogin() => emit(AuthState.login);
// void showLoginWithOTP() => emit(AuthState.loginWithOTP);
// void showResetPassword() => emit(AuthState.forgotPassword);
//
// void showSignUp() => emit(AuthState.signUp);
//
// void showVerifySignUp(
//     {String userName, String phoneNumber, String password,String verifyOTP}) {
//   authCredentials = AuthCredentials(
//       userName: userName,
//       phoneNumber: phoneNumber,
//       password: password,
//       verifyOTP: verifyOTP
//   );
//   emit(AuthState.verifySignUp);
// }

}
