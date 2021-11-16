import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/adapters/notification_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_blue.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarBlue(context: context, text: 'Notifications'),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          NotificationAdapter(),
          SizedBox(
            height: 8,
          ),
          NotificationAdapter(),
        ],
      ),
    );
  }
}
