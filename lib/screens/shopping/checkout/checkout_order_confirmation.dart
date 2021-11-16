import 'package:flutter/material.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/special_components/stepper_horizontal.dart';

class CheckoutConfirmationView extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CheckoutConfirmationView> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Checkout'),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 120,
                        child: StepperHorizontal(2),
                      ),
                      Spacer(),
                      Text(
                        'Your Order Placed Successfully',
                        style: TextStyles.mediumMediumSubdued,
                      ),
                      Spacer(),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: DefaultButton(
                  action: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  text: 'Finish Checkout',
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
