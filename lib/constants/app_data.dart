import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/models/shop_model.dart';
import 'package:oogie/repository/profile_repository.dart';

class AppDataModel {
  String userName;
  String phoneNumber;
  String password;
  String token;
  String profilePic;
  String userId;
  String locationId;
  String locationName;
  String selectedShopId;
  String selectedShopName;
  bool  isUser;

  AppDataModel(
      {this.userName,
      this.phoneNumber,
      this.password,
      this.userId,
      this.token,
      this.locationId,
      this.profilePic,
      this.locationName,
      this.selectedShopId,
      this.selectedShopName,this.isUser});
}

AppDataModel appDataModel = AppDataModel();

ProfileRepository profileRepository = ProfileRepository();

class AppData {
  String userName;
  String phoneNumber;
  String password;
  String token;
  String userId;
  String profilePic;
  String locationId;
  String locationName;
  String selectedShopId;
  String selectedShopName;
  bool  isUser;

  AppData() {
    userName = appDataModel.userName;
    phoneNumber = appDataModel.phoneNumber;
    profilePic = appDataModel.profilePic;
    userId = appDataModel.userId;
    locationId = appDataModel.locationId;
    locationName = appDataModel.locationName;
    selectedShopId = appDataModel.selectedShopId;
    selectedShopName = appDataModel.selectedShopName;
    isUser = appDataModel.isUser==null?false:appDataModel.isUser;
  }

  Future<void> setUserDetails() async {
    var user = await profileRepository.getUserDetails();
    appDataModel.isUser=true;
    appDataModel.userName = user['name'] != null ? user['name'] : '';
    appDataModel.phoneNumber = user['mobile'] != null ? user['mobile'] : '';
    appDataModel.userId = user['id'] != null ? user['id'].toString() : '';
    appDataModel.locationId = user['location_id'] != null ? user['location_id'].toString() : '';
    appDataModel.selectedShopId = user['vendor_id'] != null ? user['vendor_id'].toString() : '';
    appDataModel.profilePic = user['profile_pic']['url'] != null
        ? 'https://143.244.132.53/' + user['profile_pic']['url']
        : Urls().personUrl;
  }
  Future<void> updateShopDetails(ShopModel shopModel) async {
    appDataModel.selectedShopId =shopModel.id;
    appDataModel.selectedShopName =shopModel.name;
  }

  Future<void> clearAllData() async {
    appDataModel.isUser=false;
    appDataModel.userName ='Guest';
    appDataModel.phoneNumber = '0123456789';
    appDataModel.userId = null;
    appDataModel.locationId = null;
    appDataModel.selectedShopId =null;
    appDataModel.profilePic =null;
  }
}
