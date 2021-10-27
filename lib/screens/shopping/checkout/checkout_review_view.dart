import 'package:flutter/material.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/special_components/stepper_horizontal.dart';



class CheckoutReviewView extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CheckoutReviewView> {
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
                      Wrap(
                        children: [
                          // CartAdapter(
                          //   productName:
                          //       'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
                          //   brandName: 'Redmi',
                          //   price: rupeesString + '10000',
                          //   imageUrl:
                          //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',
                          // ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 12, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping to:',
                                  style: TextStyles.smallMedium,
                                ),
                                CustomTextButton2(
                                  text: 'Edit',
                                  action: () {},
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Francisco Román Alarcón \n1060 W Addison St \n#13 Chicago, IL 60613 \n(123) 456-7890',
                              style: TextStyles.smallRegular,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Divider(
                              thickness: 1,
                              color: AppColors.DividerBase,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment Method',
                                  style: TextStyles.smallMedium,
                                ),
                                CustomTextButton2(
                                  text: 'Edit',
                                  action: () {},
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Card Payment',
                              style: TextStyles.smallRegular,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Divider(
                              thickness: 1,
                              color: AppColors.DividerBase,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Billing Address',
                                  style: TextStyles.smallMedium,
                                ),
                                CustomTextButton2(
                                  text: 'Edit',
                                  action: () {},
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Same as shipping address',
                              style: TextStyles.smallRegular,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Divider(
                              thickness: 1,
                              color: AppColors.DividerBase,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal',
                                  style: TextStyles.smallRegularSubdued,
                                ),
                                Text(
                                  rupeesString + '165',
                                  style: TextStyles.smallRegularSubdued,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping',
                                  style: TextStyles.smallRegularSubdued,
                                ),
                                Text('FREE',
                                    style: TextStyles.smallRegularSubdued)
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Expected Delivery',
                                  style: TextStyles.smallRegularSubdued,
                                ),
                                Text(
                                  'Apr 20 - 28',
                                  style: TextStyles.smallRegularSubdued,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Taxes',
                                  style: TextStyles.smallRegularSubdued,
                                ),
                                Text(
                                  rupeesString + '11.55',
                                  style: TextStyles.smallRegularSubdued,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyles.mediumMedium,
                                ),
                                Text(
                                  rupeesString + '176.55',
                                  style: TextStyles.mediumMedium,
                                )
                              ],
                            )
                          ],
                        ),
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
