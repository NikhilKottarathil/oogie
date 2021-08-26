import 'package:flutter/material.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
class NotificationAdapter extends StatefulWidget {
  @override
  _NotificationAdapterState createState() => _NotificationAdapterState();
}

class _NotificationAdapterState extends State<NotificationAdapter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        color: AppColors.White,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppShadows.shadowSmall
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Delivered',style: AppStyles.smallMedium,),
          Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. At quis tellus lacinia eu. Donec eu quam ultrices consectetur.',style: AppStyles.smallRegularSubdued,),
        ],
      ),
    );
  }
}
