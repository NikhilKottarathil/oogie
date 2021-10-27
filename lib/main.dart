import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/special_components/app_exit_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.PrimaryBase,
        statusBarIconBrightness: Brightness.light));
    return WillPopScope(
      onWillPop: (){
        return appExitAlert(context);
      },
      child: MaterialApp(
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


        onGenerateRoute: _appRouter.onGenerateRoute,

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
