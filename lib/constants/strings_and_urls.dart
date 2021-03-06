class Urls {
  String personUrl =
      'https://clipartart.com/images/default-profile-picture-clipart.jpg';
  String serverAddress = 'https://api.oogieshopee.com/';
  String apiAddress = 'https://api.oogieshopee.com/api/';
  String categoryImage = 'icons/category.svg';
  String productImage = 'icons/phone.svg';
  String razorPayApiKry = 'rzp_test_gtyFMrQ4yx0fiF';

  String getImageUrl(String imageUrl) {
    return serverAddress + imageUrl;
  }
}

class AppExceptions {
  Exception serverException = Exception(['Server is down']);
  Exception somethingWentWrong =
      Exception(['Something went wrong please try again']);
}
