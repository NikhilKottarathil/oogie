import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/screens/authentication/verfiy_sign_up/verify_signup_state.dart';

class OTPLoginState {
  int pendingTimeInMills;

  OTPState otpState;
  String token;

  String phoneNumber = '';
  String get phoneNumberValidationText {
    if (phoneNumber.trim().length == 0) {
      return 'Please enter phone number';
    } else if (phoneNumber.trim().length != 10) {
      return 'Enter a 10 digit  phone number';
    } else {
      return null;
    }
  }


  String otp = '';
  String generatedOTP = '';
  String get otpValidationText {
    if (otp.trim().length == 0) {
      return 'Please enter password';
    } else {
      return null;
    }
  }

  final FormSubmissionStatus formStatus;
  OTPLoginState({
    this.phoneNumber = '',
    this.otp = '',
    this.token,
    this.generatedOTP = '',
    this.otpState=OTPState.showPhoneNumber,
    this.pendingTimeInMills=60000,
    this.formStatus = const InitialFormStatus(),
  });

  OTPLoginState copyWith({
    String phoneNumber,
    String otp,
    String generatedOTP,
    OTPState otpState,
    int pendingTimeInMills,
    String token,

    FormSubmissionStatus formStatus,
  }) {
    return OTPLoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      generatedOTP: generatedOTP ?? this.generatedOTP,
      token: token ?? this.token,
      formStatus: formStatus ?? this.formStatus,
      otpState: otpState ?? this.otpState,
      pendingTimeInMills: pendingTimeInMills ?? this.pendingTimeInMills,
    );
  }
}
