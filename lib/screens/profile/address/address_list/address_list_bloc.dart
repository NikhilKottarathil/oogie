import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/screens/profile/address/address_list/address_list_event.dart';
import 'package:oogie/screens/profile/address/address_list/address_list_state.dart';
import 'package:oogie/screens/shopping/checkout/checkout_bloc.dart';
import 'package:oogie/screens/shopping/checkout/checkout_event.dart';

class AddressListBloc extends Bloc<AddressListEvent, AddressListState> {
  ProfileRepository profileRepository;
  String parentPage;
  CheckoutBloc checkoutBloc;

  AddressListBloc(
      {@required this.profileRepository,
      @required this.parentPage,
      this.checkoutBloc})
      : super(AddressListState(addressModels: [])) {
    state.parentPage = parentPage;
    getAddresses();
  }

  getAddresses() async {
    state.addressModels.clear();

    var addressModels = await profileRepository.getAddresses();
    add(UpdatedList(addressModels: addressModels));
  }

  changeDefaultAddress() {}

  @override
  Stream<AddressListState> mapEventToState(AddressListEvent event) async* {
    if (event is UpdatedList) {
      print('updated address');
      yield state.copyWith(
          addressModels: event.addressModels, isLoading: false);
    } else if (event is NewAddressAdded) {
      getAddresses();
    } else if (event is ChooseDefaultAddress) {
      await profileRepository.makeSelectedAddressDefault(event.id);
      getAddresses();
      if (checkoutBloc != null) {
        print('addreess chnag call');
        print(checkoutBloc.state.total);
        checkoutBloc.add(GetDefaultAddress());
      }
    }
  }
}
