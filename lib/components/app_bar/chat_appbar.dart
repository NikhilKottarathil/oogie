import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

Widget chatAppBar({BuildContext context, prefixWidget}) {
  return AppBar(
    leading: Container(
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
    title: Text(
      'Sergio Greenfelder',
      style: TextStyles.mediumMedium,
    ),
    backgroundColor: AppColors.White,
    centerTitle: true,
    shadowColor: AppColors.ShadowColor,
  );
}
