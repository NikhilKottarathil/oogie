import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/my_order_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/screens/common/original_order/orginal_order_cubit.dart';
import 'package:oogie/screens/common/original_order/orginal_order_state.dart';
import 'package:oogie/special_components/stepper_vertical.dart';

class OriginalOrderView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Order Details'),
      body: BlocBuilder<OriginalOrderCubit,OriginalOrderState>(
        builder: (context,state) {
          return state is OrderDataState ? Container(
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
                                'Order ID - ${state.orderModel.id}',
                                style: TextStyles.mediumMediumSubdued,
                              ),
                            ),
                            dividerDefault,

                            //
                            // dividerDefault,
                            // SizedBox(
                            //   child: StepperVertical(index: 0),
                            //   height: 300,
                            // ),
                            // Spacer(),
                            // Padding(
                            //   padding: const EdgeInsets.all(20.0),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //     MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         'Total',
                            //         style: TextStyles.mediumMedium,
                            //       ),
                            //       Text(
                            //         rupeesString + '176.55',
                            //         style: TextStyles.mediumMedium,
                            //       )
                            //     ],
                            //   ),
                            // ),

                            Visibility(
                                visible: true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // CustomTextButton3(
                                    //   text: 'Download Invoice',
                                    // ),
                                    // dividerDefault,
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: Column(
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
                                                  style: TextStyles
                                                      .smallRegularSubdued)
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

                ],
              );
            }),
          ):Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
}
