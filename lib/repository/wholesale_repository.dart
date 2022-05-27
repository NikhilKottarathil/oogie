import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/functions/api_calls.dart';
import 'package:oogie/models/key_value_radio_model.dart';

import '../flavour_config.dart';

class WholeSaleRepository {
  Future createWholeSaleDealer(
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
        closingTime,
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
      buildingName,List<KeyValueRadioModel>workingDays,bool isNew,
        String id}) async {
    try {
      List<String> workingDay=[];
      workingDays.forEach((e) {
        if(e.isSelected){workingDay.add(e.value);}
      });

      var requestBody = {
        'name': name,
        'email': email,
        'mobile': mobile,
        'password': password,
        'connection_agent_type': FlavorConfig().flavorValue,
        'connection_agent_id': AppData().userId,
        'location_id': locationId,
        'working_days':workingDay ,
        'whatsapp_country_code': whatsappCountryCode,
        'mobile_country_code': mobileCountryCode,
        'openig_time': openingTime,
        'closing_time': closingTime,
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
        });
        var body = await postDataRequest(
            address: 'wholesale_dealer/signup', myBody: requestBody);
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
        await patchDataRequest(address: 'vendors/$id', myBody: requestBody);
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

  getDetailsOfSelectedWholeSaleDealer(String id) async {
    // /wholesale_dealer/id
    try {
      var body = await getDataRequest(address: 'wholesale_dealer/$id');
      if (body['Wholesale Dealer'] != null) {
        return body['Wholesale Dealer'];
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
