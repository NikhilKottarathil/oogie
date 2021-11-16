class UserModel {
  String id,
      name,
      phoneNumber,
      email,
      alternativePhoneNumber,
      buildingName,
      streetName,
      landmark,
      pinCode,
      state,
      city,
      userType;

  UserModel(
      {this.id,
      this.phoneNumber,
      this.email,
      this.state,
      this.name,
      this.buildingName,
      this.userType,
      this.streetName,
      this.alternativePhoneNumber,
      this.city,
      this.landmark,
      this.pinCode});
}
