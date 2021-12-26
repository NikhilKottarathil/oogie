import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/screens/common/order_details/order_details_cubit.dart';
import 'package:oogie/screens/common/order_details/order_details_view.dart';
import 'package:oogie/screens/user/orders/my_orders/my_order_detail_view.dart';
import 'package:oogie/screens/user/orders/my_orders/my_orders_cubit.dart';

class MyOrderAdapter extends StatelessWidget {
  OrderModel orderModel;
  int orderIndex;

  MyOrderAdapter({this.orderModel,this.orderIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order ID : ${orderModel.id}',
              style: TextStyles.smallRegularSubdued,),
            Text('${orderModel.date}', style: TextStyles.smallRegularSubdued,),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       '${orderModel.state}', style: TextStyles.smallRegularPrimaryLight,),
        //     Text('${orderModel.total.toStringAsFixed(2)}',
        //       style: TextStyles.mediumMedium,),
        //   ],
        // ),
        ListView.separated(
          itemCount: orderModel.products.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 8),
          itemBuilder: (context, index) {
            return InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pushNamed(context, '/orderDetails',arguments: {'parentPage':'myOrders','deliveryOrderId':orderModel.products[index].deliveryOrderId});
                },
                child: Card(elevation:10,shadowColor:AppColors.ShadowColor,margin:EdgeInsets.zero,child: MyOrderProductAdapter(productModel: orderModel.products[index],isListView: true,)),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 8);
          },
        ),

      ],
    );
  }
}

class MyOrderProductAdapter extends StatelessWidget {
  ProductModel productModel;
  bool isListView;
  MyOrderProductAdapter({Key key,this.productModel,this.isListView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 64, width: 64,
            child: ClipRRect(

                borderRadius: BorderRadius.circular(3.0),
                child: productModel.imageUrl != null
                    ? Image.network(productModel.imageUrl,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  productModel.name == null
                      ? 'unknown'
                      : productModel.name,
                  style: TextStyles.smallMediumSubdued,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                   !isListView? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'QTY : ' + productModel.qty
                              .toString(),
                          style: TextStyles.tinyRegularSubdued,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8,),
                        Text(
                          'Unit Price : ' + productModel
                              .price,
                          style: TextStyles.tinyRegularSubdued,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ):Column(
                      children: [
                        SizedBox(height: 16,),
                        Text(productModel.deliveryState,style: TextStyles.smallMediumPrimaryLight),
                      ],
                    ),
                    Text(
                      'Total : ' + (productModel.qty *
                          double.parse(productModel.price))
                          .toStringAsFixed(2),
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
      ),
    );
  }
}

