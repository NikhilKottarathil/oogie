import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/models/location_model.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_event.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_state.dart';

class SelectShopBloc extends Bloc<SelectShopEvent, SelectShopState> {
  final ProfileRepository profileRepository;
  LocationModel locationModel;

  // final ProfileBloc profileBloc;

  SelectShopBloc({this.profileRepository, this.locationModel})
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
      yield state.copyWith(
          shopModels: shopModels, searchString: event.searchString);
    } else if (event is ShopsUpdated) {
      yield state.copyWith(shopModels: event.shopModels);
    } else if (event is ShopSelected) {
      try {
        AppData appData = AppData();
        if (appData.isUser) {
          await profileRepository.editProfile(
              locationId: locationModel.id, shopId: event.shop.id);

          await appData.setUserDetails();
          await profileRepository.updateSelectedShop(event.shop);
          yield state.copyWith(
              formStatus: SubmissionSuccess(), selectedShop: event.shop);
        } else {
          await profileRepository.updateSelectedShop(event.shop);
          yield state.copyWith(
              formStatus: SubmissionSuccess(), selectedShop: event.shop);
        }


      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
