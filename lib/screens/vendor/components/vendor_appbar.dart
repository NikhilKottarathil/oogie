import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/common/chats.dart';
import 'package:oogie/common/notifications.dart';

Widget vendorAppBar({BuildContext context,String text}) {
  TextEditingController textEditingController = TextEditingController();
  return AppBar(
    backgroundColor: AppColors.PrimaryBase,


    title: Text(text,style: AppStyles.mediumMediumWhite,),
    actions: [
      IconButton(
        icon: SvgPicture.asset(
          'icons/notification_white.svg',
          height: 24,
          width: 24,
          fit: BoxFit.scaleDown,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Notifications()));
        },
        padding: EdgeInsets.zero,

        constraints:BoxConstraints(

        ) ,
        splashRadius: 24,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      IconButton(
        icon: SvgPicture.asset(
          'icons/chat_white.svg',
          height: 24,
          width: 24,
          fit: BoxFit.scaleDown,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Chats()));
        },
        padding: EdgeInsets.only(left: 16),

        constraints:BoxConstraints(

        ) ,
        splashRadius: 24,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),

      SizedBox(
        width: 20,
      )
    ],

  );
}
