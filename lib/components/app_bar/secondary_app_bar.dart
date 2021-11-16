import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';

Widget secondaryAppBar(
    {BuildContext context, Function prefixAction, prefixWidget}) {
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
     FlavorConfig().flavorValue=='user'? Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: SvgPicture.asset(
            'icons/cart_white.svg',
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
          splashRadius: 24,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ):Container(),
    ],
    title: SvgPicture.asset(
      'assets/app_logo.svg',
      height: AppBar().preferredSize.height * .5,
      fit: BoxFit.scaleDown,
    ),
    backgroundColor: AppColors.PrimaryBase,
    centerTitle: true,
    shadowColor: AppColors.ShadowColor,
  );
}
