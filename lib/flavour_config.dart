import 'package:flutter/material.dart';

enum Endpoints { items, details }

String appFlavorName;
String appFlavourValue;
String appFlavourKey;

class FlavorConfig {
  String appTitle;
  Map<Endpoints, String> apiEndpoint;
  String imageLocation;
  ThemeData theme;
  String flavorName;
  String flavorValue;
  String flavorKey;

  setFlavor({String flavorName, flavorValue, flavorKey}) {
    appFlavorName = flavorName;
    appFlavourValue = flavorValue;
    appFlavourKey = flavorKey;
  }

  FlavorConfig() {
    this.flavorName = appFlavorName;
    this.flavorValue = appFlavourValue;
    this.flavorKey = appFlavourKey;
  }
}
