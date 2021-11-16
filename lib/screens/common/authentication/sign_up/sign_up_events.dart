abstract class SignUpEvent {}

class SignUpUsernameChanged extends SignUpEvent {
  final String username;

  SignUpUsernameChanged({this.username});
}

class SignUpPhoneNumberChangeChanged extends SignUpEvent {
  final String phoneNumber;

  SignUpPhoneNumberChangeChanged({this.phoneNumber});
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({this.password});
}

class SignUpSubmitted extends SignUpEvent {}

class SignUpSubmittedFailed extends SignUpEvent {
  Exception e;

  SignUpSubmittedFailed({this.e});
}

class SignUpSubmittedSuccessfully extends SignUpEvent {
  String verificationId;
  int resendToken;

  SignUpSubmittedSuccessfully({this.verificationId, this.resendToken});
}
