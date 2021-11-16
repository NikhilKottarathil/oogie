import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/main_common.dart';

void main() {
  // Inject our own configurations
  // Oogie User

  FlavorConfig().setFlavor(
      flavorName: 'delivery_partner',
      flavorValue: 'delivery_executives',
      flavorKey: 'Delivery Executives');
  mainCommon(
    FlavorConfig()
      ..appTitle = "Oogie Delivery Partner"
      // ..apiEndpoint = {
      //   // Endpoints.items: "random.api.dev/items",
      //   // Endpoints.details: "random.api.dev/item"
      // }
      // ..imageLocation = "assets/images/coffee_bean.jpg"
      ..theme = ThemeData(
          scaffoldBackgroundColor: AppColors.BackgroundColor,
          primaryColor: AppColors.PrimaryBase,
          appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.PrimaryBase,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ))),
  );
}
