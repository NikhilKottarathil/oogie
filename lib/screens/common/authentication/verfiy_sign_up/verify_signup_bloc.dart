import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/repository/auth_repo.dart';
import 'package:oogie/screens/common/authentication/auth_credentials.dart';
import 'package:oogie/screens/common/authentication/verfiy_sign_up/verify_signup_events.dart';
import 'package:oogie/screens/common/authentication/verfiy_sign_up/verify_signup_state.dart';

class VerifySignUpBloc extends Bloc<VerifySignUpEvent, VerifySignUpState> {
  final AuthRepository authRepo;

  // final
  Timer _timer;
  AuthCredentials authCredentials;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  VerifySignUpBloc({this.authRepo, this.authCredentials})
      : super(VerifySignUpState()) {
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(milliseconds: 1000);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (state.pendingTimeInMills <= 1000) {
          add(TimerChanged(pendingTime: 0, otpState: OTPState.showResendOTP));
        } else {
          // state.pendingTimeInMills = state.pendingTimeInMills - 1000;
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
  Stream<VerifySignUpState> mapEventToState(VerifySignUpEvent event) async* {
    if (event is VerifySignUpOtpChanged) {
      yield state.copyWith(otp: event.otp);
    } else if (event is TimerChanged) {
      yield state.copyWith(
          pendingTimeInMills: event.pendingTime, otpState: event.otpState);
    } else if (event is ResendOTPSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        firebaseAuth.verifyPhoneNumber(
            timeout: Duration(seconds: 60),
            phoneNumber: '+91' + authCredentials.phoneNumber,
            verificationCompleted: (verificationCompleted) async {},
            forceResendingToken: authCredentials.resendToken,
            verificationFailed: (verificationFailed) async {},
            codeSent: (verificationId, resendingToken) async {
              authCredentials.verificationId = verificationId;
              authCredentials.resendToken = resendingToken;
              add(ResendOTPSubmittedSuccess());
            },
            codeAutoRetrievalTimeout: (verificationId) {});
      } on FirebaseAuthException catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is ResendOTPSubmittedSuccess) {
      state.pendingTimeInMills = 60000;
      startTimer();
      yield state.copyWith(
          formStatus: InitialFormStatus(),
          otpState: OTPState.showTimer,
          otp: '');
    } else if (event is VerifySignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: authCredentials.verificationId, smsCode: state.otp);

        await firebaseAuth.signInWithCredential(credential);
        await firebaseAuth.signOut();
        add(VerifySignUpSubmittedSuccessfully());
      } catch (e) {
        Exception exception = Exception(['OTP does not match or TimeOut']);
        yield state.copyWith(formStatus: SubmissionFailed(exception));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    } else if (event is VerifySignUpSubmittedSuccessfully) {
      try {
        AuthCredentials signupCredentials = await authRepo.signUp(
            username: authCredentials.userName,
            password: authCredentials.password,
            phoneNumber: authCredentials.phoneNumber);

        firebaseAuth.signInWithCustomToken(signupCredentials.firebaseToken);

        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
