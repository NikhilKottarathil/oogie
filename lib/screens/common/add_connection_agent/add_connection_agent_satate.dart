import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/models/location_model.dart';

class AddConnectionAgentState {
  String name,
      email,
      mobile,
      password,
      workingDays,
      openingTime,
      whatsappCountryCode,
      mobileCountryCode,
      designation,
      floorDoorNumber,
      contactPersonName,
      caption,
      aboutDescription,
      district,
      country,
      province,
      zipCode,
      streetName,
      landmark,
      buildingName,
      searchString,
      agentType;
  int index;
  List<LocationModel> locationModels;

  String get emailValidationText {
    if (email == null || email.trim().length == 0) {
      return 'Please email';
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  String get mobileValidationText {
    if (mobile == null || mobile.trim().length == 0) {
      print('1');
      return 'Please enter phone number';
    } else if (mobile.trim().length != 10) {
      print('2');

      return 'Enter a valid  phone number';
    } else {
      print('3');

      return null;
    }
  }

  String get passwordValidationText {
    if (password == null || password.trim().length == 0) {
      return 'Please enter password';
    } else if (password.trim().length < 6) {
      return 'Your password must contain at least 6 characters';
    } else {
      return null;
    }
  }

  String get pinCodeValidationText {
    if (zipCode == null || zipCode.trim().length == 0) {
      return 'Please enter Pincode';
    } else if (zipCode.trim().length != 6) {
      return 'Enter a valid  Pincode';
    } else {
      return null;
    }
  }

  final FormSubmissionStatus formStatus;

  AddConnectionAgentState(
      {this.formStatus = const InitialFormStatus(),
      this.email,
      this.mobile,
      this.zipCode,
      this.streetName,
      this.buildingName,
      this.aboutDescription,
      this.caption,
      this.contactPersonName,
      this.country,
      this.designation,
      this.district,
      this.floorDoorNumber,
      this.landmark,
      this.locationModels,
      this.mobileCountryCode,
      this.name,
      this.openingTime,
      this.password,
      this.province,
      this.searchString,
      this.whatsappCountryCode,
      this.workingDays,
      this.agentType,
      this.index});

  AddConnectionAgentState copyWith({
    String name,
    email,
    mobile,
    password,
    workingDays,
    openingTime,
    whatsappCountryCode,
    mobileCountryCode,
    designation,
    floorDoorNumber,
    contactPersonName,
    caption,
    aboutDescription,
    district,
    country,
    province,
    zipCode,
    streetName,
    landmark,
    buildingName,
    agentType,
    searchString,
    var locationModels,
    FormSubmissionStatus formStatus,
    int index,
  }) {
    return AddConnectionAgentState(
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      workingDays: workingDays ?? this.workingDays,
      openingTime: openingTime ?? this.openingTime,
      whatsappCountryCode: whatsappCountryCode ?? this.whatsappCountryCode,
      mobileCountryCode: mobileCountryCode ?? this.mobileCountryCode,
      designation: designation ?? this.designation,
      floorDoorNumber: floorDoorNumber ?? this.floorDoorNumber,
      contactPersonName: contactPersonName ?? this.contactPersonName,
      caption: caption ?? this.caption,
      aboutDescription: aboutDescription ?? this.aboutDescription,
      district: district ?? this.district,
      country: country ?? this.country,
      province: province ?? this.province,
      zipCode: zipCode ?? this.zipCode,
      streetName: streetName ?? this.streetName,
      searchString: searchString ?? this.searchString,
      locationModels: locationModels ?? this.locationModels,
      landmark: landmark ?? this.landmark,
      agentType: agentType ?? this.agentType,
      index: index ?? this.index,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
