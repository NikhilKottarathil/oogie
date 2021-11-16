class AuthCredentials {
  final String userName;
  final String phoneNumber;
  final String password;

  String token;
  String generatedOTP;
  String verificationId;
  String firebaseToken;
  int resendToken;

  AuthCredentials(
      {this.userName,
      this.resendToken,
      this.firebaseToken,
      this.phoneNumber,
      this.password,
      this.token,
      this.generatedOTP,
      this.verificationId});
}
