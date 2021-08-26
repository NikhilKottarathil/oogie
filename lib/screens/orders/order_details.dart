import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/order_details_adapter.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/components/custom_image_button.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/password_text_field.dart';
import 'package:oogie/screens/authentication/login_with_otp.dart';
import 'package:oogie/screens/authentication/register.dart';
import 'package:oogie/screens/orders/request_return.dart';
import 'package:oogie/special_components/stepper_vertical.dart';

class OrderDetails extends StatefulWidget {
  int step;

  OrderDetails(this.step);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Order Details'),
      body: Container(
        width: width,
        height: height,
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 10),
                          child: Text(
                            'Order ID - 876428347JSBDCKJSDSDYCUI',
                            style: AppStyles.smallRegularSubdued,
                          ),
                        ),
                        dividerDefault,
                        OrderDetailsAdapter(
                            'Canceled',
                            'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
                            'Ordered on:12/22/2024',
                            'Shop4u',
                            '10030'),
                        dividerDefault,
                        SizedBox(
                          child: StepperVertical(index:widget.step),
                          height: 300,
                        ),
                        Visibility(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextButton3(
                              text: 'Download Invoice',
                            ),
                            dividerDefault,
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'Shipping To:',
                                    style: AppStyles.smallRegular,
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'Francisco Román Alarcón\n1060 W Addison St #13\nChicago, IL 60613 \n(123) 456-7890',
                                    style: AppStyles.smallRegularSubdued,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  dividerDefault,
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Subtotal',
                                            style:
                                                AppStyles.smallRegularSubdued,
                                          ),
                                          Text(
                                            rupeesString + '165',
                                            style:
                                                AppStyles.smallRegularSubdued,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Shipping',
                                            style:
                                                AppStyles.smallRegularSubdued,
                                          ),
                                          Text('FREE',
                                              style:
                                                  AppStyles.smallRegularSubdued)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Expected Delivery',
                                            style:
                                                AppStyles.smallRegularSubdued,
                                          ),
                                          Text(
                                            'Apr 20 - 28',
                                            style:
                                                AppStyles.smallRegularSubdued,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Taxes',
                                            style:
                                                AppStyles.smallRegularSubdued,
                                          ),
                                          Text(
                                            rupeesString + '11.55',
                                            style:
                                                AppStyles.smallRegularSubdued,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total',
                                            style: AppStyles.mediumMedium,
                                          ),
                                          Text(
                                            rupeesString + '176.55',
                                            style: AppStyles.mediumMedium,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                        Spacer(),
                        SizedBox(
                          height: 100,
                        )
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
                    text: widget.step == 3 ? 'Return' : 'Cancel',
                    action: () {
                      widget.step == 3? Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RequestReturn())):null;

                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
