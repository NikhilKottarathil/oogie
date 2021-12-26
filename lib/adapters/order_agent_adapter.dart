import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/screens/vendor_old/components/order_adapter.dart';

class OrderAgentAdapter extends StatelessWidget {
  OrderModel orderModel;

  OrderAgentAdapter({this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(8),
      //     boxShadow: AppShadows.shadowSmall,
      //     color: AppColors.White),
      elevation: 1,
borderOnForeground: false,
      shadowColor: AppColors.ShadowColor,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order ID : ${orderModel.id}',
                  style: TextStyles.smallMediumSubdued,),
                Text('${orderModel.date}', style: TextStyles.smallRegularSubdued,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${orderModel.deliveryState}', style: TextStyles.smallRegularPrimaryLight,),
                Text('${orderModel.total.toStringAsFixed(2)}',
                  style: TextStyles.mediumMedium,),
              ],
            ),
            ListView.separated(
              itemCount: orderModel.products.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 12),
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60, width: 60,
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
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            style: TextStyles.tinyRegularSubdued,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                               'Unit Price : ' +orderModel.products[index].price,
                                style: TextStyles.tinyRegularSubdued,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Total : '+ (orderModel.products[index].qty *double.parse( orderModel.products[index].price)).toStringAsFixed(2),
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
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },
            ),

          ],
        ),
      ),
    );
  }
}
