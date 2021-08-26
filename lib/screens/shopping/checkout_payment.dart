import 'package:flutter/material.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/screens/shopping/checkout_review.dart';
import 'package:oogie/special_components/stepper_horizontal.dart';

import 'cart_details_view.dart';

class CheckoutPayment extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CheckoutPayment> {
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
                    minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: edgePadding,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                          child: StepperHorizontal(1),
                        ),
                        CartDetailsView(),
                        CustomTextField2(labelText: 'Credit/Debit Card Number',hintText: '0000 0000 0000 0000',),

                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField2(
                                labelText: 'Expiration Date',
                                hintText: 'mm/yy',
                              ),
                            ),
                            SizedBox(width: 24,),
                            Expanded(
                              child: CustomTextField2(
                                labelText: 'CCV Number',
                                hintText: '0000',
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                       SizedBox(height: 100,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: DefaultButton(
                  text: 'Continue to Review',
                  action: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutReview()));
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
