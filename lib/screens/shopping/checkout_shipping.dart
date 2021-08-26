import 'package:flutter/material.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/special_components/stepper_horizontal.dart';

import 'cart_details_view.dart';
import 'checkout_payment.dart';

class CheckoutShipping extends StatefulWidget {
  @override
  _CheckoutShippingState createState() => _CheckoutShippingState();
}

class _CheckoutShippingState extends State<CheckoutShipping> {

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
                  child: Padding(
                    padding: edgePadding,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                            child: StepperHorizontal(0),),
                        CartDetailsView(),
                        CustomTextField2(labelText: 'Full Name',),
                        CustomTextField2(labelText: 'Street Address',),
                        CustomTextField2(labelText: 'Apt, Suite, Bldg (optional)',),
                        CustomTextField2(labelText: 'Phone Number',),
                        CustomTextField2(labelText: 'Email',),

                        Spacer(),
                       SizedBox(height: 100,)
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
                  text: 'Continue to Payment',
                  action: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutPayment()));
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
