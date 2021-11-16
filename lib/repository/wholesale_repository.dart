import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/functions/api_calls.dart';

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
      workingDays,
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
      landmark,
      buildingName}) async {
    try {
      var requestBody = {
        'name': name,
        'email': email,
        'mobile': mobile,
        'password': password,
        'connection_agent_type': FlavorConfig().flavorValue,
        'connection_agent_id': AppData().userId,
        'location_id': locationId,
        'working_days': locationId,
        'whatsapp_country_code': whatsappCountryCode,
        'mobile_country_code': mobileCountryCode,
        'openig_time': openingTime,
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
    } catch (e) {
      throw e;
    }
  }
}
