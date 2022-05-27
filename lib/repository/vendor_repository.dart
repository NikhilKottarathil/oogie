import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/functions/api_calls.dart';
import 'package:oogie/models/key_value_radio_model.dart';

class VendorRepository {
  Future createVendor(
      {String name,
      email,
      mobile,
      password,
      connectionAgentType,
      connectionAgentId,
      locationId,
      whatsappCountryCode,
      mobileCountryCode,
      openingTime,
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
      closingTime,
      landmark,
      buildingName,
      List<KeyValueRadioModel> workingDays,
      bool isNew,
      String id}) async {
    try {
      List<String> workingDay = [];
      workingDays.forEach((e) {
        if(e.isSelected){workingDay.add(e.value);}
      });
      var requestBody = {
        'name': name,
        'email': email,
        'password': password,
        'location_id': locationId,
        'working_days': workingDay,
        'whatsapp_country_code': whatsappCountryCode,
        'mobile_country_code': mobileCountryCode,
        'openig_time': openingTime,
        'closing_time': openingTime,
        'designation': designation,
        'floor_door_number': floorDoorNumber,
        'contact_person_name': contactPersonName,
        'caption': caption,
        'about_description': aboutDescription,
        'district': district,
        'country': country,
        'province': province,
        'zip_code': zipCode,
        'street_name': streetName,
        'landmark': landmark,
        'building_name': buildingName
      };
      if (isNew) {
        requestBody.addAll({
          'connection_agent_type': FlavorConfig().flavorValue,
          'connection_agent_id': AppData().userId,
          'mobile': mobile,

        });
        var body = await postDataRequest(
            address: 'vendor/signup', myBody: requestBody);
        if (body['message'] == 'Successfully registered.') {
        } else {
          if (body['message'] != null) {
            throw Exception(body['message']);
          } else {
            throw AppExceptions().somethingWentWrong;
          }
        }
      } else {
        var body =
            await patchDataRequest(address: 'vendor/$id', myBody: requestBody);
        if (body['message'] == 'Successfully Updated') {
        } else {
          if (body['message'] != null) {
            throw Exception(body['message']);
          } else {
            throw AppExceptions().somethingWentWrong;
          }
        }
      }
    } catch (e) {
      throw e;
    }
  }

  getDetailsOfSelectedVendor(String id) async {
    // /wholesale_dealer/id
    try {
      var body = await getDataRequest(address: 'vendor/$id');
      if (body['Vendor'] != null) {
        return body['Vendor'];
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
