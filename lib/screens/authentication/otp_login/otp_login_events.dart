import 'package:oogie/screens/authentication/verfiy_sign_up/verify_signup_state.dart';

abstract class OTPLoginEvent {}

class PhoneNumberChanged extends OTPLoginEvent {
  final String phoneNumber;

  PhoneNumberChanged({this.phoneNumber});
}
class GetOTPSubmitted extends OTPLoginEvent {}

class OTPChanged extends OTPLoginEvent {
  final String otp;

  OTPChanged({this.otp});
}
class ResendOTPSubmitted extends OTPLoginEvent {}

class TimerChanged extends OTPLoginEvent {
  int pendingTime;
  OTPState otpState;
  TimerChanged({this.pendingTime,this.otpState});
}

class OTPLoginSubmitted extends OTPLoginEvent {}