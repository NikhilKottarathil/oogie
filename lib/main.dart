// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:oogie/constants/styles.dart';
// import 'package:oogie/router/app_router.dart';
// import 'package:oogie/special_components/app_exit_alert.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   final AppRouter _appRouter = AppRouter();
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//         statusBarColor: AppColors.PrimaryBase,
//         statusBarIconBrightness: Brightness.light));
//     return WillPopScope(
//       onWillPop: () {
//         return appExitAlert(context);
//       },
//       child: MaterialApp(
//         title: 'oogie',
//         theme: ThemeData(
//             scaffoldBackgroundColor: AppColors.BackgroundColor,
//             primaryColor: AppColors.PrimaryBase,
//             appBarTheme: AppBarTheme(
//                 backwardsCompatibility: false,
//                 systemOverlayStyle: SystemUiOverlayStyle(
//                   statusBarColor: AppColors.PrimaryBase,
//                   statusBarIconBrightness: Brightness.light,
//                   statusBarBrightness: Brightness.light,
//                 ))),
//         onGenerateRoute: _appRouter.onGenerateRoute,
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }

// flutter build apk --flavor user -t lib/main_user.dart
// flutter build apk --flavor vendor -t lib/main_vendor.dart
// flutter build apk --flavor wholesale_dealer -t lib/main_wholesale_dealer.dart
// flutter build apk --flavor distributor -t lib/main_distributor.dart
// flutter build apk --flavor sales_executive -t lib/main_sales_executive.dart
// flutter build apk --flavor delivery_partner -t lib/main_delivery_partner.dart

// flutter build appbundle --flavor user -t lib/main_user.dart
// flutter build appbundle --flavor vendor -t lib/main_vendor.dart
// flutter build appbundle --flavor wholesale_dealer -t lib/main_wholesale_dealer.dart
// flutter build appbundle --flavor distributor -t lib/main_distributor.dart
// flutter build appbundle --flavor sales_executive -t lib/main_sales_executive.dart
// flutter build appbundle --flavor delivery_partner -t lib/main_delivery_partner.dart
