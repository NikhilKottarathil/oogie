import 'dart:convert';
import 'dart:io';

import 'package:fuzzy/fuzzy.dart';
import 'package:http/http.dart' as http;
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/functions/api_calls.dart';
import 'package:oogie/models/address_model.dart';
import 'package:oogie/models/location_model.dart';
import 'package:oogie/models/shop_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<LocationModel> locationModels = [];
final List<ShopModel> shopModels = [];

class ProfileRepository {
  Future<Map<String, dynamic>> getUserDetails() async {
    try {
      var body = await getDataRequest(
          address: FlavorConfig().flavorValue + '/profile');
      print('\n=======\nvendor body $body\n========= \n');
      if (body[FlavorConfig().flavorKey] != null) {
        return body[FlavorConfig().flavorKey];
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> editUserProfile(
      {String userName, phoneNumber, shopId, locationId}) async {
    try {
      Map<String, dynamic> myBody = {};
      if (userName != null && userName.toString().trim().length != 0) {
        dynamic bioBody = {'name': userName};
        myBody.addAll(bioBody);
      }
      if (phoneNumber != null && phoneNumber.toString().trim().length != 0) {
        dynamic bioBody = {'mobile': phoneNumber};
        myBody.addAll(bioBody);
      }
      if (shopId != null && shopId.toString().trim().length != 0) {
        dynamic bioBody = {'vendor_id': shopId};
        myBody.addAll(bioBody);
      }
      if (locationId != null && locationId.toString().trim().length != 0) {
        dynamic bioBody = {'location_id': locationId};
        myBody.addAll(bioBody);
      }
      print(myBody);
      var body = await patchDataRequest(
          address: FlavorConfig().flavorValue + '/profile', myBody: myBody);
      if (body['message'] == 'Successfully Updated') {
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> changeProfilePicture({File imageFile}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    Map<String, String> headers = {};
    headers['x-access-token'] = token;
    String url = Urls().apiAddress + FlavorConfig().flavorValue + "/profile";

    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.headers.addAll(headers);
    if (imageFile != null) {
      request.files.add(http.MultipartFile('profile_pic',
          imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
          filename: imageFile.path.split("/").last));
    }
    http.Response response =
        await http.Response.fromStream(await request.send());
    print("Result: ${response.statusCode}");
    print("Result: ${response.body}");
    var body = json.decode(response.body);
  }

  // Select Location //
  // get All Location
  Future<List<LocationModel>> getLocationList() async {
    try {
      var body = await getDataRequest(address: 'location/list');
      if (body['Location'] != null) {
        locationModels.clear();
        body['Location'].forEach((element) {
          locationModels.add(LocationModel(
              id: element['id'].toString(),
              name: element['name'],
              isSelected: false));
        });
        return locationModels;
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  //getFilteredLocations
  Future<List<LocationModel>> getFilteredLocation(String value) async {
    try {
      List locations = [];
      final List<LocationModel> filteredLocationModels = [];
      locationModels.forEach((element) {
        locations.add(element.name);
      });
      final fuse = Fuzzy(locations);

      final result = fuse.search(value);
      print(result);

      result.forEach((r) {
        print('\nScore: ${r.score}\nTitle: ${r.item}');
        filteredLocationModels.add(locationModels[locations.indexOf(r.item)]);
      });
      return filteredLocationModels;
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  // Select Shop //
  // Get All Shops
  Future<List<ShopModel>> getShopList(String locationId) async {
    try {
      var body =
          await getDataRequest(address: 'vendors/by_location/$locationId');
      if (body['Vendor'] != null) {
        shopModels.clear();
        body['Vendor'].forEach((element) {
          String imageUrl;
          print('============\n');
          print('Shop by location $element');
          print('============\n');

          if (element['profile_pic'] != null) {
            if (element['profile_pic']['url'] != null) {
              imageUrl = Urls().serverAddress + element['profile_pic']['url'];
            }
          }
          shopModels.add(ShopModel(
              id: element['id'].toString(),
              name: element['name'],
              imageUrl: imageUrl,
              workingDays: element['working_days'].toString(),
              caption: element['caption'].toString(),
              phoneNumber:
                  element['mobile_country_code'] + ' ' + element['mobile'],
              description: element['about_description'],
              email: element['email'],
              workingTime:
                  element['openig_time'] + '-' + element['closing_time'],
              address: element['floor_door_number'] + ', ' +
                  element['building_name'] +', '+ element['landmark'] +', '+
                  element['place'] +', '+
                  element['street_name'] +', '+
                  element['street_name'] +', '+
                  element['province']+', '+element['zip_code']));
        });
        return shopModels;
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<String> getSelectedShopAndLocation() async {
    try {
      if (appDataModel.selectedLocationId != null) {
        var locationBody = await getDataRequest(
            address: 'location/${appDataModel.selectedLocationId}');
        print(locationBody);
        if (locationBody['Location'] != null) {
          if (appDataModel.selectedShopId != null) {
            var shopBody = await getDataRequest(
                address: 'vendor/${appDataModel.selectedShopId}');
            print(shopBody);
            if (shopBody['Vendor'] != null) {
              return shopBody['Vendor']['name'] +
                  ' ' +
                  locationBody['Location']['name'];
              ;
            } else {
              return locationBody['Location']['name'];
            }
          } else {
            return locationBody['Location']['name'];
          }
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      } else {
        throw Exception(['This only for user']);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<String> getNameFromShopId(String shopId) async {
    try {
      var body = await getDataRequest(address: 'vendor/$shopId');
      print(body);
      if (body['Vendor'] != null) {
        return body['Vendor']['name'];
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  //GEt Filtered Shops
  Future<List<ShopModel>> getFilteredShops(String value) async {
    try {
      List shops = [];
      final List<ShopModel> filteredShopModels = [];
      shopModels.forEach((element) {
        shops.add(element.name);
      });
      final fuse = Fuzzy(shops);

      final result = fuse.search(value);
      print(result);

      result.forEach((r) {
        print('\nScore: ${r.score}\nTitle: ${r.item}');
        filteredShopModels.add(shopModels[shops.indexOf(r.item)]);
      });
      return filteredShopModels;
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  Future<void> addNewAddress(
      {String id,
      name,
      address1,
      address2,
      city,
      state,
      country,
      zipcode,
      landmark,
      mobile,
      alternativeMobile}) async {
    dynamic requestBody = {
      'name': name,
      'address1': address1,
      'address2': address2,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
      'landmark': landmark,
      'mobile': mobile,
      'alternative_mobile': alternativeMobile
    };
    try {
      var body;
      if (id != null) {
        body = await patchDataRequest(
            address: 'user_address/$id', myBody: requestBody);
        if (body['message'] == 'Successfully Updated') {
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      } else {
        body =
            await postDataRequest(address: 'user_address', myBody: requestBody);
        if (body['message'] == 'Successfully Created') {
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  Future<void> deleteAddress(String id) async {
    try {
      var body = await deleteDataRequest(address: 'user_address/$id');
      if (body['message'] == 'Successfully Deleted') {
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  Future<void> makeSelectedAddressDefault(String id) async {
    try {
      var body =
          await patchDataRequest(address: 'user_address/set_default/$id');
      if (body['message'] == 'Successfully Updated') {
      } else {
        throw AppExceptions().somethingWentWrong;
      }
    } catch (e) {
      throw AppExceptions().serverException;
    }
  }

  Future<List<AddressModel>> getAddresses() async {
    final List<AddressModel> addressModels = [];
    try {
      var body = await getDataRequest(address: 'user_address/list');
      if (body['Address'] != null) {
        body['Address'].forEach((element) {
          addressModels.add(AddressModel(
            id: element['id'].toString(),
            name: element['name'].toString(),
            phoneNumber: element['mobile'].toString(),
            alternativePhoneNumber: element['alternative_mobile'].toString(),
            pinCode: element['zipcode'].toString(),
            state: element['state'].toString(),
            city: element['city'].toString(),
            address1: element['address1'].toString(),
            address2: element['address2'].toString(),
            landmark: element['landmark'] != null
                ? element['landmark'].toString()
                : '',
            isDefault: element['is_default'],
          ));
        });
        if (addressModels.length == 1) {
          addressModels[0].isDefault = true;
          makeSelectedAddressDefault(addressModels[0].id);
        }
        return addressModels;
      } else {
        if (body['message'] != null) {
          throw Exception(body['message']);
        } else {
          throw AppExceptions().somethingWentWrong;
        }
      }
    } catch (e) {
      throw e;
    }
  }
}
