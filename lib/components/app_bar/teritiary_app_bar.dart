import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/common/products/product_filter/search_app_bar.dart';

Widget teritiaryAppBar(
    {BuildContext buildContext,
    String title,
    Function prefixAction,
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
          Navigator.of(buildContext).pop();
        }
      },
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Icon(
            Icons.search_rounded,
            color: AppColors.White,
          ),
          onPressed: () {
            showSearchAppBar(buildContext: buildContext);
          },
          splashRadius: 24,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: SvgPicture.asset(
            'icons/cart_white.svg',
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
          ),
          onPressed: () {
            Navigator.pushNamed(buildContext, '/cart');
          },
          splashRadius: 24,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
    ],
    title: Text(
      title,
      style: TextStyles.mediumMediumWhite,
    ),
    backgroundColor: AppColors.PrimaryBase,
    shadowColor: AppColors.ShadowColor,
  );
}
