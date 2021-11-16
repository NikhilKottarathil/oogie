import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/special_components/app_exit_alert.dart';

var flavorConfigProvider;

Future<void> mainCommon(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    flavorConfig: config,
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  FlavorConfig flavorConfig;

  MyApp({this.flavorConfig});

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.PrimaryBase,
        statusBarIconBrightness: Brightness.light));
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.grey,
              body: Center(child: Text("Error")),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return WillPopScope(
            onWillPop: () {
              return appExitAlert(context);
            },
            child: MaterialApp(
              title: flavorConfig.appTitle,
              onGenerateRoute: _appRouter.onGenerateRoute,
              debugShowCheckedModeBanner: false,
            ),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: CustomProgressIndicator(),
          ),
        );
      },
    );
  }
}
