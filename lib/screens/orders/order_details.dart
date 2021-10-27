import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/adapters/order_details_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
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
                            style: TextStyles.smallRegularSubdued,
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
                                    style: TextStyles.smallRegular,
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    'Francisco Román Alarcón\n1060 W Addison St #13\nChicago, IL 60613 \n(123) 456-7890',
                                    style: TextStyles.smallRegularSubdued,
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
                                                TextStyles.smallRegularSubdued,
                                          ),
                                          Text(
                                            rupeesString + '165',
                                            style:
                                                TextStyles.smallRegularSubdued,
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
                                                TextStyles.smallRegularSubdued,
                                          ),
                                          Text('FREE',
                                              style:
                                                  TextStyles.smallRegularSubdued)
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
                                                TextStyles.smallRegularSubdued,
                                          ),
                                          Text(
                                            'Apr 20 - 28',
                                            style:
                                                TextStyles.smallRegularSubdued,
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
                                                TextStyles.smallRegularSubdued,
                                          ),
                                          Text(
                                            rupeesString + '11.55',
                                            style:
                                                TextStyles.smallRegularSubdued,
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
                                            style: TextStyles.mediumMedium,
                                          ),
                                          Text(
                                            rupeesString + '176.55',
                                            style: TextStyles.mediumMedium,
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
