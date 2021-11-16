import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/order_details_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/ui_widgets/custom_text_button_3.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/screens/orders/request_return.dart';
import 'package:oogie/special_components/stepper_vertical.dart';

class OrderDetailsByCreatorView extends StatelessWidget {
  OrderModel orderModel;

  OrderDetailsByCreatorView({this.orderModel});

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
                            'Order ID - ${orderModel.id}',
                            style: TextStyles.smallRegularSubdued,
                          ),
                        ),
                        dividerDefault,
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,0,20,0),
                          child: Wrap(
                            children: List.generate(orderModel.products.length, (index){
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 90, width: 90,
                                    child: ClipRRect(

                                        borderRadius: BorderRadius.circular(3.0),
                                        child: orderModel.products[index].imageUrl != null
                                            ? Image.network(orderModel.products[index].imageUrl,
                                            fit: BoxFit.scaleDown)
                                            : SvgPicture.asset(Urls().productImage,
                                            fit: BoxFit.scaleDown)),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Text(
                                          orderModel.products[index].name == null
                                              ? 'unknown'
                                              : orderModel.products[index].name,
                                          style: TextStyles.smallMediumSubdued,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'QTY : '+orderModel.products[index].qty.toString(),
                                          style: TextStyles.smallRegularSubdued,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Unit Price' +orderModel.products[index].unitPrice,
                                              style: TextStyles.smallRegularSubdued,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Total : '+ (orderModel.products[index].qty *double.parse( orderModel.products[index].unitPrice)).toStringAsFixed(2),
                                              style: TextStyles.smallMediumSubdued,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );

                            }),
                          ),
                        ),
                        // Expanded(
                        //   child: ListView.separated(
                        //     itemCount: orderModel.products.length,
                        //     shrinkWrap: true,
                        //     padding: EdgeInsets.only(top: 12),
                        //     itemBuilder: (context, index) {
                        //     },
                        //     separatorBuilder: (BuildContext context, int index) {
                        //       return SizedBox(height: 8);
                        //     },
                        //   ),
                        // ),
                        dividerDefault,
                        SizedBox(
                          child: StepperVertical(index: 0),
                          height: 300,
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
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
                          ),
                        ),
                        Visibility(
                          visible: false,
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: DefaultButton(
                    // text: widget.step == 3 ? 'Return' : 'Cancel',
                    text: 'Exit',
                    action: () {
                      // widget.step == 3
                      //     ? Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => RequestReturn()))
                      //     : null;
                      Navigator.of(context).pop();
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
