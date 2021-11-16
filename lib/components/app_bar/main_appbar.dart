import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/common/chats.dart';
import 'package:oogie/common/notifications.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';

Widget mainAppBar({BuildContext context}) {
  TextEditingController textEditingController = TextEditingController();
  return SliverAppBar(
    collapsedHeight: 60,
    backgroundColor: AppColors.PrimaryBase,
    floating: true,
    pinned: true,
    title: SvgPicture.asset(
      'assets/app_logo.svg',
      height: AppBar().preferredSize.height * .5,
      fit: BoxFit.scaleDown,
    ),
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
        constraints: BoxConstraints(),
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
        constraints: BoxConstraints(),
        splashRadius: 24,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      FlavorConfig().flavorName == 'user'
          ? IconButton(
              icon: SvgPicture.asset(
                'icons/cart_white.svg',
                height: 24,
                width: 24,
                fit: BoxFit.scaleDown,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              padding: EdgeInsets.only(left: 16),
              constraints: BoxConstraints(),
              splashRadius: 24,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
          : Container(),
      SizedBox(
        width: 20,
      )
    ],
    bottom: FlavorConfig().flavorName == 'user'
        ? PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 12, bottom: 12),
              child: Material(
                color: AppColors.White,
                borderRadius: BorderRadius.circular(8),
                child: TextFormField(
                  maxLines: 1,
                  controller: textEditingController,
                  onChanged: (text) {},
                  style: TextStyles.smallRegular,
                  onTap: () {
                    Navigator.pushNamed(context, '/productFilter',
                        arguments: {'parentPage': 'search'});
                  },
                  decoration: new InputDecoration(
                    hintText: 'Search for mobiles and accessories',
                    contentPadding: const EdgeInsets.all(17.0),
                    fillColor: Colors.white,

                    hintStyle: TextStyles.smallRegularSubdued,
                    prefixIcon: SvgPicture.asset(
                      'icons/search.svg',
                      color: AppColors.TextDefault,
                      fit: BoxFit.scaleDown,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.BorderDefault, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),

                    enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide(
                            color: AppColors.BorderDisabled, width: 1.0)),
                    //fillColor: Colors.green
                  ),
                ),
              ),
            ))
        : null,
  );
}
