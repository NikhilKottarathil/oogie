import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/screens/profile/my_location/my_location_event.dart';
import 'package:oogie/screens/profile/my_location/my_location_state.dart';

class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {
  final ProfileRepository profileRepository;
  String parentPage;

  // final ProfileBloc profileBloc;

  MyLocationBloc({this.profileRepository,this.parentPage})
      : super(MyLocationState(locationModels: [])) {
    getLocations();
  }

  Future<void> getLocations() async {
    var locationModels = await profileRepository.getLocationList();
    add(LocationsUpdated(locationModels: locationModels));
  }

  @override
  Stream<MyLocationState> mapEventToState(MyLocationEvent event) async* {
    if (event is SearchLocationChanged) {
      var locationModels =
          await profileRepository.getFilteredLocation(event.searchString);
      yield state.copyWith(
          locationModels: locationModels, searchString: event.searchString);
    } else if (event is LocationsUpdated) {
      yield state.copyWith(locationModels: event.locationModels);
    } else if (event is MyLocationSelected) {
      yield state.copyWith(
          formStatus: SubmissionSuccess(), selectedLocation: event.myLocation);
    }
  }
}
