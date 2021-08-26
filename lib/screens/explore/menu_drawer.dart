import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/cart_adapter.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/icon_text_button.dart';
import 'package:oogie/favorites.dart';
import 'package:oogie/screens/authentication/profile.dart';
import 'package:oogie/screens/orders/order_list.dart';
import 'package:oogie/special_components/stepper_horizontal.dart';

class MenuDrawer extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: Drawer(
        elevation: 10,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: AppColors.PrimaryBase,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/yellow_bar.svg',
                          height: 32,
                          width: 32,
                        ),
                        Spacer(),
                        Column(

                          children: [
                            SizedBox(height: 40,),
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },

                              child: Icon(
                                Icons.close,
                                color: AppColors.White,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20,),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [

                          Container(
                            height: 80,
                            width: 80,
                            // color: Colors.green,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRuJdRZgCdojDsemBQqxOAg9UAGIYem6inQg&usqp=CAU"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Hello, Wade O'Conner",
                            style: AppStyles.mediumRegularWhite,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              IconTextButton(
                  iconUrl: 'icons/order.svg',
                  text: 'Orders',
                  action: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => OrderList()));
                  }),
              IconTextButton(
                  iconUrl: 'icons/favourite.svg',
                  text: 'Favorites',
                  action: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Favorites()));
                  }),
              IconTextButton(
                  iconUrl: 'icons/user.svg',
                  text: 'Profile',
                  action: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Profile()));
                  }),
              IconTextButton(
                  iconUrl: 'icons/settings.svg', text: 'Settings', action: () {}),
              Spacer(),
              IconTextButton(
                  iconUrl: 'icons/logout.svg', text: 'Logout', action: () {}),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
