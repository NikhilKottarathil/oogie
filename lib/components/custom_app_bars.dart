import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/common/chats.dart';
import 'package:oogie/common/notifications.dart';
import 'package:oogie/screens/explore/search.dart';
import 'package:oogie/screens/shopping/cart.dart';

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
      style: AppStyles.mediumMedium,
    ),
    backgroundColor: AppColors.White,
    centerTitle: true,
    elevation: 2,
    shadowColor: AppColors.SkyLightest.withOpacity(.5),
  );
}

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

Widget secondaryAppBar(
    {BuildContext context,
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
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(

          icon: SvgPicture.asset(
            'icons/cart_white.svg',
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));

          },
          splashRadius: 24,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
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

Widget mainAppBar({BuildContext context}) {
  TextEditingController textEditingController = TextEditingController();
  return SliverAppBar(
    collapsedHeight: 60,
    backgroundColor: AppColors.PrimaryBase,
    floating: true,
    pinned: true,

    title: SvgPicture.asset('assets/app_logo.svg',      height: AppBar().preferredSize.height * .5,fit: BoxFit.scaleDown,),
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
      IconButton(
        icon: SvgPicture.asset(
          'icons/cart_white.svg',
          height: 24,
          width: 24,
          fit: BoxFit.scaleDown,
        ),

        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
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
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 12),
          child: Material(
            color: AppColors.White,
            borderRadius: BorderRadius.circular(8),
            child: TextFormField(
              maxLines: 1,
              controller: textEditingController,
              onChanged: (text) {},
              style: AppStyles.smallRegular,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search()));
              },
              decoration: new InputDecoration(
                hintText: 'Search for mobiles and accessories',
                contentPadding: const EdgeInsets.all(17.0),
                fillColor: Colors.white,

                hintStyle: AppStyles.smallRegularSubdued,
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
        )),
  );
}


Widget chatAppBar(
    {BuildContext context,

      prefixWidget}) {
  return AppBar(
    leading:  Container(
      margin: EdgeInsets.only(left: 20),

      // color: Colors.green,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {},
          color: AppColors.TextDefault,
          splashRadius: 24,
          splashColor: Colors.transparent,

        ),
      ),
    ],
    title: Text('Sergio Greenfelder',style: AppStyles.mediumMedium,),
    backgroundColor: AppColors.White,
    centerTitle: true,
    shadowColor: AppColors.ShadowColor,
  );
}