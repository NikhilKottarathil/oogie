import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/models/location_model.dart';
import 'package:oogie/models/shop_model.dart';
import 'package:oogie/repository/profile_repository.dart';

class AppDataModel {
  String userName;
  String phoneNumber;
  String password;
  String token;
  String profilePic;
  String userId;
  String selectedLocationId;
  String selectedLocationName;
  String selectedShopId;
  String selectedShopName;
  bool isUser;

  AppDataModel(
      {this.userName,
      this.phoneNumber,
      this.password,
      this.userId,
      this.token,
      this.profilePic,
      this.selectedLocationId,
      this.selectedLocationName,
      this.selectedShopId,
      this.selectedShopName,
      this.isUser});
}

AppDataModel appDataModel = AppDataModel();

ProfileRepository profileRepositoryTemp = ProfileRepository();

class AppData {
  String userName;
  String phoneNumber;
  String password;
  String token;
  String userId;
  String profilePic;
  String selectedLocationId;
  String selectedLocationName;
  String selectedShopId;
  String selectedShopName;
  bool isUser;

  AppData() {
    userName = appDataModel.userName;
    phoneNumber = appDataModel.phoneNumber;
    profilePic = appDataModel.profilePic;
    userId = appDataModel.userId;
    selectedLocationId = appDataModel.selectedLocationId;
    selectedLocationId = appDataModel.selectedLocationName;
    selectedShopId = appDataModel.selectedShopId;
    selectedShopName = appDataModel.selectedShopName;
    isUser = appDataModel.isUser == null ? false : appDataModel.isUser;
  }

  Future<bool> setUserDetails() async {
    var user = await profileRepositoryTemp.getUserDetails();
    appDataModel.isUser = true;
    appDataModel.userName = user['name'] != null ? user['name'] : '';
    appDataModel.phoneNumber = user['mobile'] != null ? user['mobile'] : '';
    appDataModel.userId = user['id'] != null ? user['id'].toString() : '';
    appDataModel.selectedLocationId =
        user['location_id'] != null ? user['location_id'].toString() : '';
    appDataModel.selectedShopId =
        user['vendor_id'] != null ? user['vendor_id'].toString() : '';
    appDataModel.profilePic = user['profile_pic']['url'] != null
        ? 'https://143.244.132.53/' + user['profile_pic']['url']
        : Urls().personUrl;
    return FlavorConfig().flavorName == 'user'
        ? user['vendor_id'] != null
        : true;
  }

  Future<void> updateShopDetails(
      {ShopModel shopModel, LocationModel locationModel}) async {
    print('shop id updated');
    appDataModel.selectedShopId = shopModel.id;
    appDataModel.selectedShopName = shopModel.name;
    appDataModel.selectedLocationId = locationModel.id;
    appDataModel.selectedLocationName = locationModel.name;
  }

  Future<void> clearAllData() async {
    appDataModel.isUser = false;
    appDataModel.userName = 'Guest';
    appDataModel.phoneNumber = '0123456789';
    appDataModel.userId = null;
    appDataModel.selectedLocationId = null;
    appDataModel.selectedLocationName = null;
    appDataModel.selectedShopId = null;
    appDataModel.selectedShopName = null;
    appDataModel.profilePic = null;
  }
}
