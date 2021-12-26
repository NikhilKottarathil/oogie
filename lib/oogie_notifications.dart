import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/main_common.dart';

class OogieNotifications {}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

AndroidNotificationChannel androidNotificationChannel =
    const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<String> getFirebaseMessagingToken() async {
  String firebaseMessagingToken = await FirebaseMessaging.instance.getToken();
  print('fcm : ' + firebaseMessagingToken);
  return firebaseMessagingToken;
}

Future<dynamic> selectNotification(String payload) async {
  print('ss selected Notification');
  print(payload);
  Map<String, dynamic> messageData = json.decode(payload);

  notificationAction(messageData,0);
}

Future<void> setupInteractedMessage(BuildContext context) async {
  // Get any messages which caused the application to open from
  // a terminated state.
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage message) async {
    Map<String, dynamic> messageData = message.data;

    notificationAction(messageData,2);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    Map<String, dynamic> messageData = message.data;

    notificationAction(messageData,1);
  });
}

notificationAction(Map<String, dynamic> messageData,int delay) async {
  print('NOTIFICATION MESSAGE');
  print(messageData);
  if (messageData != null && messageData['type']!=null) {
    String messageType = messageData['type'];
    if(messageType=='delivery_order') {
      String deliveryOrderId = messageData['delivery_order_id'];

  await Future.delayed(Duration(seconds: delay));
  // String deliveryOrderId = ' ';
  if (FlavorConfig().flavorName == 'user') {
    Navigator.pushNamed(MyApp.navigatorKey.currentContext, '/myOrders',
        arguments: {'parentPage': 'notification'});
    Navigator.pushNamed(MyApp.navigatorKey.currentContext, '/orderDetails',
        arguments: {
          'deliveryOrderId': deliveryOrderId,
          'parentPage': 'myOrders'
        });
  }
  if (FlavorConfig().flavorName == 'vendor' ||
      FlavorConfig().flavorName == 'wholesale_dealer') {
    Navigator.pushNamed(MyApp.navigatorKey.currentContext, '/orderDetails',
        arguments: {
          'deliveryOrderId': deliveryOrderId,
          'parentPage': 'vendorOrders'
        });
  }
  if (FlavorConfig().flavorName == 'delivery_partner') {
    Navigator.pushNamed(MyApp.navigatorKey.currentContext, '/orderDetails',
        arguments: {
          'deliveryOrderId': deliveryOrderId,
          'parentPage': 'deliveryPartnerOrders'
        });
  }
  }
  }
}
