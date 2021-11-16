import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

Widget defaultAppBarBlue(
    {BuildContext context,
    String text,
    Function prefixAction,
    suffixAction,
    Widget suffixWidget,
    prefixWidget}) {
  return AppBar(
    leading: InkWell(
      child: prefixWidget == null
          ? Icon(
              Icons.arrow_back,
              color: AppColors.SkyLightest,
            )
          : prefixWidget,
      onTap: () {
        if (prefixAction != null) {
          prefixAction();
        } else if (prefixWidget == null && prefixAction == null) {
          Navigator.of(context).pop();
        }
      },
    ),
    actions: [
      suffixWidget != null
          ? InkWell(
              child: suffixWidget,
              onTap: () {
                if (suffixAction != null) {
                  suffixAction();
                }
              },
            )
          : Container(),
    ],
    title: Text(
      text,
      style: TextStyle(
          fontSize: 18,
          color: AppColors.SkyLightest,
          height: 1,
          fontFamily: 'DMSans',
          fontWeight: FontWeight.w500),
    ),
    backgroundColor: AppColors.PrimaryBase,
    centerTitle: true,
    shadowColor: AppColors.ShadowColor,
  );
}
