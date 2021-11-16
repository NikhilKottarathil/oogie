import 'package:oogie/constants/form_submitting_status.dart';

class AddAddressState {
  String userName;

  String get userNameValidationText {
    if (userName.trim().length == 0) {
      return 'Please enter name';
    } else if (userName.trim().length < 4) {
      return 'Username is too short!  at least 4 characters';
    } else {
      return null;
    }
  }

  String phoneNumber;

  String get phoneNumberValidationText {
    if (phoneNumber.trim().length == 0) {
      return 'Please enter phone number';
    } else if (phoneNumber.trim().length != 10) {
      return 'Enter a valid  phone number';
    } else {
      return null;
    }
  }

  String alternativePhoneNumber;

  String get alternativePhoneNumberValidationText {
    if (alternativePhoneNumber.trim().length == 0) {
      return 'Please enter phone number';
    } else if (alternativePhoneNumber.trim().length != 10) {
      return 'Enter a valid  phone number';
    } else {
      return null;
    }
  }

  String pinCode;

  String get pinCodeValidationText {
    if (pinCode.trim().length == 0) {
      return 'Please enter Pincode';
    } else if (pinCode.trim().length != 6) {
      return 'Enter a valid  Pincode';
    } else {
      return null;
    }
  }

  String state;

  String get stateValidationText {
    if (state.trim().length == 0) {
      return 'Please enter State';
    } else {
      return null;
    }
  }

  String city;

  String get cityValidationText {
    if (city.trim().length == 0) {
      return 'Please enter City';
    } else {
      return null;
    }
  }

  String address1;

  String get address1ValidationText {
    if (address1.trim().length == 0) {
      return 'Please enter House No or Building Address';
    } else {
      return null;
    }
  }

  String address2;

  String get address2ValidationText {
    if (address2.trim().length == 0) {
      return 'Please enter Road Name or Area';
    } else {
      return null;
    }
  }

  String landmark;

  final FormSubmissionStatus formStatus;

  AddAddressState({
    this.userName = '',
    this.phoneNumber = '',
    this.landmark = '',
    this.address1 = '',
    this.state = '',
    this.city = '',
    this.pinCode = '',
    this.alternativePhoneNumber = '',
    this.address2 = '',
    this.formStatus = const InitialFormStatus(),
  });

  AddAddressState copyWith({
    String userName,
    phoneNumber,
    landmark,
    address1,
    address2,
    city,
    state,
    pinCode,
    alternativePhoneNumber,
    FormSubmissionStatus formStatus,
  }) {
    return AddAddressState(
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address2: address2 ?? this.address2,
      alternativePhoneNumber:
          alternativePhoneNumber ?? this.alternativePhoneNumber,
      pinCode: pinCode ?? this.pinCode,
      city: city ?? this.city,
      state: state ?? this.state,
      address1: address1 ?? this.address1,
      landmark: landmark ?? this.landmark,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
