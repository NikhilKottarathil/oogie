import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/common/chats.dart';
import 'package:oogie/common/notifications.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/screens/explore/explore/explore_bloc.dart';
import 'package:oogie/screens/explore/explore/explore_state.dart';

Widget mainAppBar({BuildContext context}) {
  TextEditingController textEditingController = TextEditingController();
  return SliverAppBar(
    collapsedHeight: 60,
    backgroundColor: AppColors.PrimaryBase,
    floating: true,
    pinned: true,
    titleSpacing: 0,
    title: FlavorConfig().flavorName == 'user' ? userTitle() : nonUserTitle(),
    automaticallyImplyLeading: true,

    // actions: [
    //
    // ],
    bottom: FlavorConfig().flavorName == 'user'
        ? PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 14, right: 14, top: 12, bottom: 12),
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

Widget userTitle() {
  return BlocProvider(
    create: (context) => exploreBloc,
    child: BlocBuilder<ExploreBloc, ExploreState>(builder: (context, state) {
      return
        FutureBuilder(
            future: profileRepository
                .getSelectedShopAndLocation(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if(Platform.isIOS)
                      SizedBox(width: 14,),
                    Image.asset(
                      'assets/app_icon_blue.png',
                      height: AppBar().preferredSize.height * .5,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(width: 4,),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/myLocation',
                              arguments: {'parentPage': 'explore'});
                        },
                        child: Text(
                          snapshot.data,
                          // 'the  g  ,mbb kdnbk kbn b djkghfdk  jkjbd kjdhgkfd ',
                          style: TextStyles.smallRegularWhite,

                          maxLines: 1,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.White,
                    ),
                    Spacer(),
                    actionWidgets(context),
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if(Platform.isIOS)
                    SizedBox(width: 14,),
                  Image.asset(
                    'assets/app_icon_blue.png',
                    height: AppBar().preferredSize.height * .5,
                    fit: BoxFit.scaleDown,
                  ),
                  SizedBox(width: 4,),

                  Flexible(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/myLocation',
                            arguments: {'parentPage': 'explore'});
                      },
                      child: Text(
                        'Select your location',
                        style: TextStyles.smallRegularWhite,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.White,
                  ),
                  Spacer(),
                  actionWidgets(context),
                ],
              );
            });
    }),
  );
}

Widget nonUserTitle() {
  return Row(
    children: [
      // SvgPicture.asset(
      //   'assets/app_logo.svg',
      //   height: AppBar().preferredSize.height * .5,
      //   fit: BoxFit.scaleDown,
      // ),

      if (FlavorConfig().flavorName == 'user')
        Image.asset(
          'assets/app_icon_blue.png',
          height: AppBar().preferredSize.height * .5,
          fit: BoxFit.scaleDown,
        ),
      if (FlavorConfig().flavorName == 'user')
        SizedBox(
          width: 14,
        ),
      if (FlavorConfig().flavorName == 'vendor')
        Image.asset(
          'assets/vendor_white.png',
          fit: BoxFit.cover,
          height: AppBar().preferredSize.height * .5,
        ),
      if (FlavorConfig().flavorName == 'wholesale_dealer')
        Image.asset(
          'assets/wholesale_white.png',
          fit: BoxFit.cover,
          height: AppBar().preferredSize.height * .5,
        ),
      if (FlavorConfig().flavorName == 'distributor')
        Image.asset(
          'assets/distributor_white.png',
          fit: BoxFit.cover,
          height: AppBar().preferredSize.height * .5,
        ),
      if (FlavorConfig().flavorName == 'sales_executive')
        Image.asset(
          'assets/sales_executive_white.png',
          fit: BoxFit.cover,
          height: AppBar().preferredSize.height * .5,
        ),
      if (FlavorConfig().flavorName == 'delivery_partner')
        Image.asset(
          'assets/delivery_partner_white.png',
          fit: BoxFit.cover,
          height: AppBar().preferredSize.height * .5,
        ),
    ],
  );
}

Widget actionWidgets(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      // IconButton(
      //   icon: SvgPicture.asset(
      //     'icons/notification_white.svg',
      //     height: 24,
      //     width: 24,
      //     fit: BoxFit.scaleDown,
      //   ),
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => Notifications()));
      //   },
      //   padding: EdgeInsets.zero,
      //   constraints: BoxConstraints(),
      //   splashRadius: 24,
      //   splashColor: Colors.transparent,
      //   highlightColor: Colors.transparent,
      // ),
      // IconButton(
      //   icon: SvgPicture.asset(
      //     'icons/chat_white.svg',
      //     height: 24,
      //     width: 24,
      //     fit: BoxFit.scaleDown,
      //   ),
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => Chats()));
      //   },
      //   padding: EdgeInsets.only(left: 16),
      //   constraints: BoxConstraints(),
      //   splashRadius: 24,
      //   splashColor: Colors.transparent,
      //   highlightColor: Colors.transparent,
      // ),
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
      if(Platform.isAndroid)
        SizedBox(
          width: 20,
        ),
      if(Platform.isIOS)
        SizedBox(
          width: 4,
        )
    ],
  );
}