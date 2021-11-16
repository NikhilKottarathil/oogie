import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/models/address_model.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/screens/profile/address/add_address/add_address_event.dart';
import 'package:oogie/screens/profile/address/add_address/add_address_state.dart';
import 'package:oogie/screens/profile/address/address_list/address_list_bloc.dart';
import 'package:oogie/screens/profile/address/address_list/address_list_event.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final ProfileRepository profileRepository;
  final AddressListBloc addressListBloc;
  final AddressModel addressModel;

  AddAddressBloc(
      {this.profileRepository, this.addressListBloc, this.addressModel})
      : super(AddAddressState()) {
    if (addressModel != null) {
      setAddress();
    }
  }

  setAddress() {
    state.userName = addressModel.name;
    state.phoneNumber = addressModel.phoneNumber;
    state.alternativePhoneNumber = addressModel.alternativePhoneNumber;
    state.pinCode = addressModel.pinCode;
    state.state = addressModel.state;
    state.city = addressModel.city;
    state.address1 = addressModel.address1;
    state.address2 = addressModel.address2;
    state.landmark = addressModel.landmark;
  }

  @override
  Stream<AddAddressState> mapEventToState(AddAddressEvent event) async* {
    if (event is UsernameChanged) {
      yield state.copyWith(userName: event.value);
    } else if (event is PhoneNumberChanged) {
      yield state.copyWith(phoneNumber: event.value);
    } else if (event is AlternativePhoneNumberChanged) {
      yield state.copyWith(alternativePhoneNumber: event.value);
    } else if (event is CityChanged) {
      yield state.copyWith(city: event.value);
    } else if (event is PincodeChanged) {
      print('pincode changed');
      yield state.copyWith(pinCode: event.value);
    } else if (event is StateChanged) {
      yield state.copyWith(state: event.value);
    } else if (event is Address1Changed) {
      yield state.copyWith(address1: event.value);
    } else if (event is Address2Changed) {
      yield state.copyWith(address2: event.value);
    } else if (event is LandmarkChanged) {
      yield state.copyWith(landmark: event.value);
    } else if (event is AddAddressSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await profileRepository.addNewAddress(
          id: addressModel != null ? addressModel.id : null,
          name: state.userName,
          mobile: state.phoneNumber,
          alternativeMobile: state.alternativePhoneNumber,
          zipcode: state.pinCode,
          city: state.city,
          state: state.state,
          country: 'India',
          address1: state.address1,
          address2: state.address2,
          landmark: state.landmark,
        );
        addressListBloc.add(NewAddressAdded());

        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
