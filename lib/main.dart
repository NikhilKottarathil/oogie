import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/screens/authentication/login.dart';
import 'package:oogie/screens/authentication/splash_screen.dart';
import 'package:oogie/screens/explore/explore_page.dart';
import 'package:oogie/screens/shopping/cart.dart';
import 'package:oogie/screens/vendor/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.PrimaryBase,
        statusBarIconBrightness: Brightness.light));
    return MaterialApp(
      title: 'oogie',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.BackgroundColor,
        primaryColor: AppColors.PrimaryBase,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.PrimaryBase,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
          )
        )
      ),
      home: SafeArea(child: SplashScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
