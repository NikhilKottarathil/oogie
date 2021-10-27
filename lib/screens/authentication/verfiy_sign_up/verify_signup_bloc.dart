import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/screens/authentication/auth_credentials.dart';
import 'package:oogie/screens/authentication/verfiy_sign_up/verify_signup_events.dart';
import 'package:oogie/screens/authentication/verfiy_sign_up/verify_signup_state.dart';

import '../../../repository/auth_repo.dart';

class VerifySignUpBloc extends Bloc<VerifySignUpEvent, VerifySignUpState> {
  final AuthRepository authRepo;
  // final
  Timer _timer;
  AuthCredentials authCredentials;

  VerifySignUpBloc({this.authRepo,this.authCredentials})
      : super(VerifySignUpState()) {
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(milliseconds: 1000);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (state.pendingTimeInMills <= 1000) {
          add(TimerChanged(pendingTime: 0,otpState: OTPState.showResendOTP));
        } else {
          // state.pendingTimeInMills = state.pendingTimeInMills - 1000;
          add(TimerChanged(pendingTime: state.pendingTimeInMills - 1000,otpState: OTPState.showTimer));

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
  Stream<VerifySignUpState> mapEventToState(VerifySignUpEvent event) async* {
    if (event is VerifySignUpOtpChanged) {
      yield state.copyWith(otp: event.otp);
    }else  if (event is TimerChanged) {
      yield state.copyWith(pendingTimeInMills: event.pendingTime,otpState: event.otpState);
    } else if (event is ResendOTPSubmitted) {
      final generatedOTP = await authRepo.getSignUpOTP(phoneNumber:authCredentials.phoneNumber);
      authCredentials.generatedOTP=generatedOTP;
      state.pendingTimeInMills=60000;
      startTimer();
      yield state.copyWith(formStatus: SubmissionSuccess(),otpState: OTPState.showTimer,otp: '');
    }else if (event is VerifySignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      if (state.otp == authCredentials.generatedOTP) {
        try {
          final token = await authRepo.signUp(
              username: authCredentials.userName,
              password: authCredentials.password,
              phoneNumber: authCredentials.phoneNumber);
          yield state.copyWith(formStatus: SubmissionSuccess());
          AppData appData = AppData();
          await appData.setUserDetails();
          final credentials = authCredentials;
          credentials.token = token;
          print(credentials);
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
