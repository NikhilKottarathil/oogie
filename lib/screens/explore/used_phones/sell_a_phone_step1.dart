import 'package:flutter/material.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/explore/used_phones/sell_a_phone_step_2.dart';

class SellAPhoneStep1 extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SellAPhoneStep1> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: defaultAppBarWhite(
        context: context,
        text: 'Enter mobile details',
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: edgePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField2(
                      labelText: 'Brand',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField2(labelText: 'Ad title'),
                    Text(
                      'Enter key features of your item(e.g. brand, model, type, age)',
                      style: TextStyles.smallRegularSubdued,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField2(
                        labelText: 'Describe what you are selling'),
                    Text(
                      'Include condition, features and reason for selling',
                      style: TextStyles.smallRegularSubdued,
                    ),
                    Spacer(),
                    DefaultButton(
                      action: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SellAPhoneStep2()));
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
