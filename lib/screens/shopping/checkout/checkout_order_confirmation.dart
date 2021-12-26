import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/shopping/checkout/checkout_bloc.dart';
import 'package:oogie/screens/shopping/checkout/checkout_state.dart';
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
      appBar: defaultAppBarWhite(
          context: context,
          text: 'Checkout',
          prefixAction: () {
            if (context.read<CheckoutBloc>().state.paymentTypeState == PaymentTypeState.online) {
              Navigator.pop(context);
            }
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }),
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                child: BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                  return DefaultButton(
                    action: () {
                      if (state.paymentTypeState == PaymentTypeState.online) {
                        Navigator.pop(context);
                      }
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    text: 'Finish Checkout',
                  );
                }),
              ),
            )
          ],
        );
      }),
    );
  }
}
