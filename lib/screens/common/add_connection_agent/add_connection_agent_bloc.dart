import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/flavour_config.dart';
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

  AddConnectionAgentBloc(
      {this.vendorRepository,
      this.wholeSaleRepository,
      this.connectionAgentsListBloc,
      this.userModel})
      : super(AddConnectionAgentState(agentType: 'vendor', index: 0)) {
    getLocations();
    if (userModel != null) {
      setUserOldData();
    }
  }

  Future<void> getLocations() async {
    var locationModels = await profileRepository.getLocationList();
    add(LocationsUpdated(locationModels: locationModels));
  }

  setUserOldData() {

    // state.userName = addressModel.name;

    // state.address2 = addressModel.address2;
    // state.landmark = addressModel.landmark;
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
    } else if (event is WorkingDaysChanged) {
      yield state.copyWith(workingDays: event.value);
    } else if (event is OpeningTimeChanged) {
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
              buildingName: state.buildingName);
          connectionAgentsListBloc.add(FetchInitialData());

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
              buildingName: state.buildingName);
          connectionAgentsListBloc.add(FetchInitialData());

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
