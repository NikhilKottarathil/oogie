import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/radio_buttons.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/main_common.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/user_model.dart';
import 'package:oogie/repository/vendor_repository.dart';
import 'package:oogie/repository/wholesale_repository.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_event.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_satate.dart';
import 'package:oogie/screens/distributor/connection_agents_list/connection_agents_list_bloc.dart';
import 'package:oogie/screens/distributor/connection_agents_list/connection_agents_list_event.dart';

class AddConnectionAgentBloc
    extends Bloc<AddConnectionAgentEvent, AddConnectionAgentState> {
  final VendorRepository vendorRepository;
  final WholeSaleRepository wholeSaleRepository;
  final ConnectionAgentsListBloc connectionAgentsListBloc;
  UserModel userModel;
  bool isNew = true;

  AddConnectionAgentBloc(
      {this.vendorRepository,
      this.wholeSaleRepository,
      this.connectionAgentsListBloc,
      this.userModel})
      : super(AddConnectionAgentState(
            agentType: 'vendor',
            index: 0,
            workingDays: [
              KeyValueRadioModel(isSelected:false,key :'Sunday',value: 'Sunday'),
              KeyValueRadioModel(isSelected:false,key :'Monday',value: 'Monday'),
              KeyValueRadioModel(isSelected:false,key :'Tuesday',value: 'Tuesday'),
              KeyValueRadioModel(isSelected:false,key :'Wednesday',value: 'Wednesday'),
              KeyValueRadioModel(isSelected:false,key :'Thursday',value: 'Thursday'),
              KeyValueRadioModel(isSelected:false,key :'Friday',value: 'Friday'),
              KeyValueRadioModel(isSelected:false,key :'Saturday',value: 'Saturday'),

            ])) {
    getLocations();

  }

  Future<void> getLocations() async {
    var locationModels = await profileRepository.getLocationList();
    add(LocationsUpdated(locationModels: locationModels));
    if (userModel != null) {
      setUserOldData();
    }
  }

  setUserOldData() async {
    var data;
    isNew = false;
    if (userModel.userType == 'vendor') {
      data = await vendorRepository.getDetailsOfSelectedVendor(userModel.id);
    } else {
      data = await wholeSaleRepository
          .getDetailsOfSelectedWholeSaleDealer(userModel.id);
    }
    if (data != null) {
      List workingDayString=[];
      state.name = data['name'];
      state.email = data['email'];
      state.mobile = data['mobile'];
      state.password = data['password'];
      String locationId = data['location']!=null?data['location']['id'].toString():null;
      workingDayString = data['working_days'];
      state.whatsappCountryCode = data['whatsapp_country_code'];
      state.mobileCountryCode = data['mobile_country_code'];
      state.openingTime = data['openig_time'];
      state.closingTime = data['closing_time'];
      state.designation = data['designation'];
      state.floorDoorNumber = data['floor_door_number'];
      state.contactPersonName = data['contact_person_name'];
      state.caption = data['caption'];
      state.aboutDescription = data['about_description'];
      state.district = data['district'];
      state.country = data['country'];
      state.province = data['province'];
      state.zipCode = data['zip_code'];
      state.streetName = data['street_name'];
      state.landmark = data['landmark'];
      state.buildingName = data['building_name'];
      if (locationId != null) {
        if (state.locationModels
            .map((e) => e.id)
            .toList()
            .contains(locationId)) {
          state.locationModels
              .singleWhere((element) => element.id == locationId)
              .isSelected = true;
        }
      }
      workingDayString.forEach((e) {
        state.workingDays.singleWhere((element) => element.value == e.toString()).isSelected=true;
      });

      add(PageChanged(index: 1));
     await Future.delayed(Duration(milliseconds: 500));
      add(PageChanged(index: 0));
     //  MyApp.navigatorKey.currentState.setState(() {
     //
     //  });
    }
  }

  @override
  Stream<AddConnectionAgentState> mapEventToState(
      AddConnectionAgentEvent event) async* {
    if (event is AgentTypeChanged) {
      yield state.copyWith(agentType: event.value);
    }
    if (event is PageChanged) {
      yield state.copyWith(index: event.index);
    }
    if (event is NameChanged) {
      yield state.copyWith(name: event.value);
    } else if (event is EmailChanged) {
      yield state.copyWith(email: event.value);
    } else if (event is MobileChanged) {
      yield state.copyWith(mobile: event.value);
    } else if (event is PasswordChanged) {
      yield state.copyWith(password: event.value);
    } else if (event is ZipCodeChanged) {
      print('pincode changed');
      yield state.copyWith(zipCode: event.value);
    } else if (event is WorkingDaysSelected) {
      state.workingDays.singleWhere((element) => element.value==event.value).isSelected= !state.workingDays.singleWhere((element) => element.value==event.value).isSelected;
      yield state.copyWith(workingDays:state.workingDays );
    } else if (event is OpeningTimeChanged) {
      yield state.copyWith(openingTime: event.value);
    } else if (event is ClosingTimeChanged) {
      yield state.copyWith(openingTime: event.value);
    } else if (event is FloorDoorNumberChanged) {
      yield state.copyWith(floorDoorNumber: event.value);
    } else if (event is ContactPersonNameChanged) {
      yield state.copyWith(contactPersonName: event.value);
    } else if (event is CaptionChanged) {
      yield state.copyWith(caption: event.value);
    } else if (event is AboutDescriptionChanged) {
      yield state.copyWith(aboutDescription: event.value);
    } else if (event is DistrictChanged) {
      yield state.copyWith(district: event.value);
    } else if (event is ProvinceChanged) {
      yield state.copyWith(province: event.value);
    } else if (event is StreetNameChanged) {
      yield state.copyWith(streetName: event.value);
    } else if (event is LandMarkChanged) {
      yield state.copyWith(landmark: event.value);
    } else if (event is BuildingNameChanged) {
      yield state.copyWith(buildingName: event.value);
    } else if (event is SearchLocationChanged) {
      var locationModels =
          await profileRepository.getFilteredLocation(event.searchString);
      yield state.copyWith(
          locationModels: locationModels, searchString: event.searchString);
    } else if (event is LocationsUpdated) {
      yield state.copyWith(locationModels: event.locationModels);
    } else if (event is LocationSelected) {
      state.locationModels.forEach((element) {
        element.isSelected = false;
      });
      state.locationModels[event.index].isSelected = true;
      yield state.copyWith();
    } else if (event is AddConnectionAgentSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      if (state.agentType == 'vendor') {
        try {
          await vendorRepository.createVendor(
              name: state.name,
              email: state.email,
              mobile: state.mobile,
              password: state.password,
              connectionAgentType: FlavorConfig().flavorValue,
              connectionAgentId: AppData().userId,
              locationId: state.locationModels
                  .singleWhere((element) => element.isSelected)
                  .id,
              workingDays: state.workingDays,
              whatsappCountryCode: '+91',
              mobileCountryCode: '+91',
              openingTime: state.openingTime,
              closingTime: state.closingTime,
              designation: state.designation,
              floorDoorNumber: state.floorDoorNumber,
              contactPersonName: state.contactPersonName,
              caption: state.caption,
              aboutDescription: state.aboutDescription,
              district: state.district,
              country: 'India',
              province: state.province,
              zipCode: state.zipCode,
              streetName: state.streetName,
              landmark: state.landmark,
              buildingName: state.buildingName,id: userModel!=null?userModel.id:null,isNew: userModel==null);
          if (connectionAgentsListBloc != null) {
            connectionAgentsListBloc.add(FetchInitialData());
          }

          yield state.copyWith(formStatus: SubmissionSuccess());
        } catch (e) {
          yield state.copyWith(formStatus: SubmissionFailed(e));
          yield state.copyWith(formStatus: InitialFormStatus());
        }
      } else {
        try {
          await wholeSaleRepository.createWholeSaleDealer(
              name: state.name,
              email: state.email,
              mobile: state.mobile,
              password: state.password,
              connectionAgentType: FlavorConfig().flavorValue,
              connectionAgentId: AppData().userId,
              locationId: state.locationModels
                  .singleWhere((element) => element.isSelected)
                  .id,
              workingDays: state.workingDays,
              whatsappCountryCode: '+91',
              mobileCountryCode: '+91',
              openingTime: state.openingTime,
              closingTime: state.closingTime,
              designation: state.designation,
              floorDoorNumber: state.floorDoorNumber,
              contactPersonName: state.contactPersonName,
              caption: state.caption,
              aboutDescription: state.aboutDescription,
              district: state.district,
              country: 'India',
              province: state.province,
              zipCode: state.zipCode,
              streetName: state.streetName,
              landmark: state.landmark,
              buildingName: state.buildingName,id: userModel!=null?userModel.id:null,isNew: userModel==null);
          if (connectionAgentsListBloc != null) {
            connectionAgentsListBloc.add(FetchInitialData());
          }

          yield state.copyWith(formStatus: SubmissionSuccess());
          print('success');
        } catch (e) {
          print('failed');

          yield state.copyWith(formStatus: SubmissionFailed(e));
          yield state.copyWith(formStatus: InitialFormStatus());
        }
      }
    }
  }
}
