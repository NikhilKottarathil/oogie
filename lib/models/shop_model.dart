class ShopModel {
  String name,
      id,
      imageUrl,
      description,
      address,
      phoneNumber,
      email,
      workingTime,
      workingDays,
      caption;

  ShopModel(
      {this.imageUrl,
      this.name,
      this.id,
      this.description,
      this.address,
      this.phoneNumber,
      this.workingDays,
      this.email,
      this.caption,
      this.workingTime});
}
