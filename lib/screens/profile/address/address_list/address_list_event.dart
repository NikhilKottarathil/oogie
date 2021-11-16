import 'package:oogie/models/address_model.dart';

class AddressListEvent {}

class UpdatedList extends AddressListEvent {
  List<AddressModel> addressModels;

  UpdatedList({this.addressModels});
}

class SubmitAddress extends AddressListEvent {}

class NewAddressAdded extends AddressListEvent {}

class DeleteSelectedAddress extends AddressListEvent {
  String id;

  DeleteSelectedAddress({this.id});
}

class ChooseDefaultAddress extends AddressListEvent {
  String id;

  ChooseDefaultAddress({this.id});
}
