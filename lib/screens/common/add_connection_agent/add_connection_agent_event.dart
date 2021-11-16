import 'package:oogie/models/location_model.dart';

abstract class AddConnectionAgentEvent {}

class AgentTypeChanged extends AddConnectionAgentEvent {
  final String value;

  AgentTypeChanged({this.value});
}

class PageChanged extends AddConnectionAgentEvent {
  final int index;

  PageChanged({this.index});
}

class NameChanged extends AddConnectionAgentEvent {
  final String value;

  NameChanged({this.value});
}

class EmailChanged extends AddConnectionAgentEvent {
  final String value;

  EmailChanged({this.value});
}

class MobileChanged extends AddConnectionAgentEvent {
  final String value;

  MobileChanged({this.value});
}

class PasswordChanged extends AddConnectionAgentEvent {
  final String value;

  PasswordChanged({this.value});
}

class LocationSelected extends AddConnectionAgentEvent {
  final int index;

  LocationSelected({this.index});
}

class WorkingDaysChanged extends AddConnectionAgentEvent {
  final String value;

  WorkingDaysChanged({this.value});
}

class OpeningTimeChanged extends AddConnectionAgentEvent {
  final String value;

  OpeningTimeChanged({this.value});
}

class DesignationChanged extends AddConnectionAgentEvent {
  final String value;

  DesignationChanged({this.value});
}

class FloorDoorNumberChanged extends AddConnectionAgentEvent {
  final String value;

  FloorDoorNumberChanged({this.value});
}

class ContactPersonNameChanged extends AddConnectionAgentEvent {
  final String value;

  ContactPersonNameChanged({this.value});
}

class CaptionChanged extends AddConnectionAgentEvent {
  final String value;

  CaptionChanged({this.value});
}

class AboutDescriptionChanged extends AddConnectionAgentEvent {
  final String value;

  AboutDescriptionChanged({this.value});
}

class DistrictChanged extends AddConnectionAgentEvent {
  final String value;

  DistrictChanged({this.value});
}

class ProvinceChanged extends AddConnectionAgentEvent {
  final String value;

  ProvinceChanged({this.value});
}

class ZipCodeChanged extends AddConnectionAgentEvent {
  final String value;

  ZipCodeChanged({this.value});
}

class StreetNameChanged extends AddConnectionAgentEvent {
  final String value;

  StreetNameChanged({this.value});
}

class LandMarkChanged extends AddConnectionAgentEvent {
  final String value;

  LandMarkChanged({this.value});
}

class BuildingNameChanged extends AddConnectionAgentEvent {
  final String value;

  BuildingNameChanged({this.value});
}

class AddConnectionAgentSubmitted extends AddConnectionAgentEvent {}

class SearchLocationChanged extends AddConnectionAgentEvent {
  final String searchString;

  SearchLocationChanged({this.searchString});
}

class LocationsUpdated extends AddConnectionAgentEvent {
  final List<LocationModel> locationModels;

  LocationsUpdated({this.locationModels});
}
