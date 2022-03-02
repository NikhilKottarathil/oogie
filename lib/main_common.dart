import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/oogie_notifications.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/special_components/app_exit_alert.dart';

var flavorConfigProvider;

Future<void> mainCommon(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // notification
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);

  runApp(MyApp(
    flavorConfig: config,
  ));
}

class MyApp extends StatefulWidget {
  FlavorConfig flavorConfig;
  static final navigatorKey = new GlobalKey<NavigatorState>();


  MyApp({this.flavorConfig});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('message');
      print(message.data);
      print(message.data);
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                androidNotificationChannel.id,
                androidNotificationChannel.name,
                androidNotificationChannel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
              ),
            ),
            payload: json.encode(message.data));
      }
    });

    setupInteractedMessage(context);

    getFirebaseMessagingToken();
  }

  final AppRouter _appRouter = AppRouter();

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.PrimaryBase,
        statusBarIconBrightness: Brightness.light));
    return WillPopScope(
      onWillPop: () {
        return appExitAlert(context);
      },
      child: MaterialApp(
        navigatorKey: MyApp.navigatorKey,

        title: widget.flavorConfig.appTitle,
        onGenerateRoute:  _appRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
    // return FutureBuilder(
    //   future: Firebase.initializeApp(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       return const MaterialApp(
    //
    //         debugShowCheckedModeBanner: false,
    //         home: Scaffold(
    //           backgroundColor: Colors.grey,
    //           body: Center(child: Text("Error")),
    //         ),
    //       );
    //     }
    //     if (snapshot.connectionState == ConnectionState.done) {
    //
    //     }
    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       home: Scaffold(
    //         body: CustomProgressIndicator(),
    //       ),
    //     );
    //   },
    // );
  }

}
