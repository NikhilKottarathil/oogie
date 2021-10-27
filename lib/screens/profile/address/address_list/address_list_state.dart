import 'package:oogie/models/address_model.dart';

class AddressListState {
  List<AddressModel> addressModels = [];
  String parentPage;
  String tittle;
  bool isLoading;
  Exception actionErrorMessage;

  AddressListState(
      {this.addressModels,
      this.tittle,
      this.parentPage,
      this.actionErrorMessage,
      this.isLoading = false});

  AddressListState copyWith({
    var addressModels,
    String tittle,
    bool isLoading,
    String parentPage,
    Exception actionErrorMessage,
  }) {
    return AddressListState(
      addressModels: addressModels ?? this.addressModels,
      tittle: tittle ?? this.tittle, isLoading: isLoading ?? this.isLoading,
      parentPage: parentPage ?? this.parentPage,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
    );
  }
}
