import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/repository/auth_repo.dart';
import 'package:oogie/screens/common/authentication/auth_credentials.dart';
import 'package:oogie/screens/common/authentication/otp_login/otp_login_events.dart';
import 'package:oogie/screens/common/authentication/otp_login/otp_login_state.dart';
import 'package:oogie/screens/common/authentication/verfiy_sign_up/verify_signup_state.dart';

class OTPLoginBloc extends Bloc<OTPLoginEvent, OTPLoginState> {
  final AuthRepository authRepo;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Timer _timer;
  int resendToken;

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
    if (event is PhoneNumberChanged) {
      yield state.copyWith(
          phoneNumber: event.phoneNumber, formStatus: InitialFormStatus());
    } else if (event is OTPChanged) {
      yield state.copyWith(otp: event.otp, formStatus: InitialFormStatus());
    } else if (event is TimerChanged) {
      yield state.copyWith(
          pendingTimeInMills: event.pendingTime,
          otpState: event.otpState,
          formStatus: InitialFormStatus());
    } else if (event is GetOTPSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        firebaseAuth.verifyPhoneNumber(
            timeout: Duration(seconds: 60),
            phoneNumber: '+91' + state.phoneNumber,
            verificationCompleted: (verificationCompleted) async {},
            verificationFailed: (verificationFailed) async {},
            codeSent: (verificationId, resendingToken) async {
              resendToken = resendingToken;
              add(GetOTPSubmittedSuccess(verificationId: verificationId));
            },
            codeAutoRetrievalTimeout: (verificationId) {});
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is GetOTPSubmittedSuccess) {
      state.pendingTimeInMills = 60000;
      startTimer();
      yield state.copyWith(
          otpState: OTPState.showTimer,
          otp: '',
          verificationId: event.verificationId,
          formStatus: InitialFormStatus());
    } else if (event is ResendOTPSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        firebaseAuth.verifyPhoneNumber(
            timeout: Duration(seconds: 60),
            phoneNumber: '+91' + state.phoneNumber,
            verificationCompleted: (verificationCompleted) async {},
            verificationFailed: (verificationFailed) async {},
            forceResendingToken: resendToken,
            codeSent: (verificationId, resendingToken) async {
              resendToken = resendingToken;
              add(GetOTPSubmittedSuccess(verificationId: verificationId));
            },
            codeAutoRetrievalTimeout: (verificationId) {});
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is OTPLoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: state.verificationId, smsCode: state.otp);
        await firebaseAuth.signInWithCredential(credential);
        await firebaseAuth.signOut();
        add(OTPLoginSubmittedSuccess());
      } catch (e) {
        Exception exception = Exception(['OTP does not match']);
        yield state.copyWith(formStatus: SubmissionFailed(exception));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    } else if (event is OTPLoginSubmittedSuccess) {
      try {
        AuthCredentials authCredentials =
            await authRepo.loginByOTP(phoneNumber: state.phoneNumber);

        // await firebaseAuth.signInWithCustomToken(
        //     authCredentials.firebaseToken);
        AppData appData = AppData();
        await authRepo.updateFirebaseDeviceToken();

        await appData.setUserDetails();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
