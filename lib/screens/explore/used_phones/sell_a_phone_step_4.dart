import 'package:flutter/material.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/explore/used_phones/sell_a_phone_step_5.dart';


class SellAPhoneStep4 extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SellAPhoneStep4> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Location',),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: edgePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField2(hintText: 'Search city, area, neighbourhood',labelText: '',prefixIcon: 'icons/search.svg',),

                    Spacer(),
                    DefaultButton(
                      action: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SellAPhoneStep5()));
                      },
                      text: 'Continue',
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
