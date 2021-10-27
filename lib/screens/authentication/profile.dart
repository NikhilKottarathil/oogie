import 'package:flutter/material.dart';
import 'package:oogie/components/app_bar/default_appbar_blue.dart';

import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/constants/styles.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarBlue(context: context, text: 'Profile'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.height * .1,
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
                SizedBox(
                  width: 16,
                ),
                Column(
                  children: [
                    Text(
                      'Wade O Conner',
                      style: TextStyles.mediumRegular,
                    ),
                    Text(
                      '+91 7896674587',
                      style: TextStyles.smallRegularSubdued,
                    ),
                  ],
                )
              ],
            ),
          ),
          dividerDefault,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'General',
              style: TextStyles.smallRegularSubdued,
            ),
          ),
          SizedBox(
            height: 12,
          ),

          CustomTextButton4(text: 'Edit Profile',),
          dividerDefault,
          CustomTextButton4(text: 'Manage Password',),
          dividerDefault,
          CustomTextButton4(text: 'Manage Address',),
          dividerDefault,

          CustomTextButton4(text: 'Manage Payment',),

        ],
      ),
    );
  }
}
