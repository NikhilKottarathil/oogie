abstract class AddAddressEvent {}

class UsernameChanged extends AddAddressEvent {
  final String value;

  UsernameChanged({this.value});
}

class AlternativePhoneNumberChanged extends AddAddressEvent {
  final String value;

  AlternativePhoneNumberChanged({this.value});
}

class PhoneNumberChanged extends AddAddressEvent {
  final String value;

  PhoneNumberChanged({this.value});
}

class PincodeChanged extends AddAddressEvent {
  final String value;

  PincodeChanged({this.value});
}

class CityChanged extends AddAddressEvent {
  final String value;

  CityChanged({this.value});
}

class StateChanged extends AddAddressEvent {
  final String value;

  StateChanged({this.value});
}

class Address1Changed extends AddAddressEvent {
  final String value;

  Address1Changed({this.value});
}

class Address2Changed extends AddAddressEvent {
  final String value;

  Address2Changed({this.value});
}

class LandmarkChanged extends AddAddressEvent {
  final String value;

  LandmarkChanged({this.value});
}

class AddAddressSubmitted extends AddAddressEvent {}
