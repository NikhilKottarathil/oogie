import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/models/location_model.dart';
import 'package:oogie/models/shop_model.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_event.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_state.dart';

class SelectShopBloc extends Bloc<SelectShopEvent, SelectShopState> {
  final ProfileRepository profileRepository;
  LocationModel locationModel;
  String parentPage;

    bool isUsedPhonesSelected=false;

  // final ProfileBloc profileBloc;

  SelectShopBloc({this.profileRepository, this.locationModel,this.parentPage})
      : super(SelectShopState(shopModels: [])) {
    getLocations();
  }

  Future<void> getLocations() async {
    var shopModels = await profileRepository.getShopList(locationModel.id);
    add(ShopsUpdated(shopModels: shopModels));
  }

  @override
  Stream<SelectShopState> mapEventToState(SelectShopEvent event) async* {
    if (event is SearchShopChanged) {
      var shopModels =
          await profileRepository.getFilteredShops(event.searchString);
      add(ShopsUpdated(shopModels: shopModels));
      yield state.copyWith(searchString: event.searchString);
    } else if (event is ShopsUpdated) {
      event.shopModels.insert(0, ShopModel( name: 'All Shops in ${locationModel.name}',id: '00000000'));
      yield state.copyWith(shopModels: event.shopModels);
    } else if (event is ShopSelected) {

      try {
        isUsedPhonesSelected=event.isUsedPhonesSelected;
        AppData appData = AppData();
        if (appData.isUser) {
          await profileRepository.editUserProfile(
              locationId: locationModel.id, shopId:event.shop.id);

          await appData.setUserDetails();
          yield state.copyWith(
              formStatus: SubmissionSuccess(), selectedShop: event.shop);
        } else {
          appData.updateShopDetails(shopModel: event.shop,locationModel: locationModel);
          yield state.copyWith(
              formStatus: SubmissionSuccess(), selectedShop: event.shop);
        }
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
