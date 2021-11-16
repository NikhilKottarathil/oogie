import 'package:oogie/models/location_model.dart';

abstract class MyLocationEvent {}

class SearchLocationChanged extends MyLocationEvent {
  final String searchString;

  SearchLocationChanged({this.searchString});
}

class LocationsUpdated extends MyLocationEvent {
  final List<LocationModel> locationModels;

  LocationsUpdated({this.locationModels});
}

class MyLocationSelected extends MyLocationEvent {
  final myLocation;

  MyLocationSelected({this.myLocation});
}
