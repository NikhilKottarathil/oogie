
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/models/location_model.dart';

class MyLocationState {
  List<LocationModel> locationModels;
  LocationModel selectedLocation;
  String searchString;


  final FormSubmissionStatus formStatus;

  MyLocationState({
    this.locationModels,
    this.selectedLocation,
    this.searchString,
    this.formStatus = const InitialFormStatus(),
  });

  MyLocationState copyWith({
    List<LocationModel> locationModels,
    var selectedLocation,
    FormSubmissionStatus formStatus,
    String searchString,

  }) {
    return MyLocationState(
      locationModels: locationModels ?? this.locationModels,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      formStatus: formStatus ?? this.formStatus,
      searchString: searchString ?? this.searchString,
    );
  }
}
