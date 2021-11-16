import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

Widget defaultAppBarWhite(
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
              color: AppColors.TextDefault,
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
      style: TextStyles.mediumMedium,
    ),
    backgroundColor: AppColors.White,
    centerTitle: true,
    elevation: 2,
    shadowColor: AppColors.SkyLightest.withOpacity(.5),
  );
}
