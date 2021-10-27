import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/repository/auth_repo.dart';
import 'package:oogie/screens/authentication/otp_login/otp_login_events.dart';
import 'package:oogie/screens/authentication/otp_login/otp_login_state.dart';
import 'package:oogie/screens/authentication/verfiy_sign_up/verify_signup_state.dart';

class OTPLoginBloc extends Bloc<OTPLoginEvent, OTPLoginState> {
  final AuthRepository authRepo;

  Timer _timer;

  OTPLoginBloc({this.authRepo}) : super(OTPLoginState());

  void startTimer() {
    const oneSec = const Duration(milliseconds: 1000);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (state.pendingTimeInMills <= 1000) {
          add(TimerChanged(pendingTime: 0, otpState: OTPState.showResendOTP));
        } else {
          add(TimerChanged(
              pendingTime: state.pendingTimeInMills - 1000,
              otpState: OTPState.showTimer));
        }
      },
    );
  }

  @override
  Future<void> close() {
    // TODO: implement close
    _timer.cancel();
    return super.close();
  }

  @override
  Stream<OTPLoginState> mapEventToState(OTPLoginEvent event) async* {
    // Phone Number updated
    if (event is PhoneNumberChanged) {
      yield state.copyWith(phoneNumber: event.phoneNumber);

      // Password updated
    } else if (event is OTPChanged) {
      yield state.copyWith(otp: event.otp);

      // Form submitted
    } else if (event is TimerChanged) {
      yield state.copyWith(
          pendingTimeInMills: event.pendingTime, otpState: event.otpState);
    } else if (event is GetOTPSubmitted) {
      final authCredentials =
          await authRepo.getLoginOTP(phoneNumber: state.phoneNumber);
      state.pendingTimeInMills = 60000;
      startTimer();
      yield state.copyWith(
          otpState: OTPState.showTimer,
          otp: '',
          generatedOTP: authCredentials.generatedOTP,
          token: authCredentials.token);
    } else if (event is ResendOTPSubmitted) {
      final authCredentials =
          await authRepo.getLoginOTP(phoneNumber: state.phoneNumber);
      state.pendingTimeInMills = 60000;
      startTimer();
      yield state.copyWith(
          otpState: OTPState.showTimer,
          otp: '',
          generatedOTP: authCredentials.generatedOTP,
          token: authCredentials.token);
    } else if (event is OTPLoginSubmitted) {
      if (state.otp == state.generatedOTP) {
        try {
          authRepo.otpLogin(token: state.token);
          AppData appData = AppData();
          await appData.setUserDetails();
          yield state.copyWith(formStatus: SubmissionSuccess());
        } catch (e) {
          yield state.copyWith(formStatus: SubmissionFailed(e));
        }
      } else {
        Exception exception = Exception(['OTP does not match']);
        yield state.copyWith(formStatus: SubmissionFailed(exception));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
