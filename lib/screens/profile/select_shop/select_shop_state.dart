
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/models/shop_model.dart';

class SelectShopState {
  List<ShopModel> shopModels;
  ShopModel selectedShop;
  String searchString;


  final FormSubmissionStatus formStatus;

  SelectShopState({
    this.shopModels,
    this.selectedShop,
    this.searchString,
    this.formStatus = const InitialFormStatus(),
  });

  SelectShopState copyWith({
    List<ShopModel> shopModels,
    var selectedShop,
    FormSubmissionStatus formStatus,
    String searchString,

  }) {
    return SelectShopState(
      shopModels: shopModels ?? this.shopModels,
      selectedShop: selectedShop ?? this.selectedShop,
      formStatus: formStatus ?? this.formStatus,
      searchString: searchString ?? this.searchString,
    );
  }
}
