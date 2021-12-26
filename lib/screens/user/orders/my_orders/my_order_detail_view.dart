// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:oogie/adapters/my_order_adapter.dart';
// import 'package:oogie/components/app_bar/default_appbar_white.dart';
// import 'package:oogie/components/default_button.dart';
// import 'package:oogie/constants/strings_and_urls.dart';
// import 'package:oogie/constants/styles.dart';
// import 'package:oogie/models/order_model.dart';
// import 'package:oogie/router/app_router.dart';
// import 'package:oogie/screens/user/orders/my_orders/my_order_orginal_view.dart';
// import 'package:oogie/screens/user/orders/my_orders/my_orders_cubit.dart';
// import 'package:oogie/screens/user/orders/order_return_request/order_return_request_cubit.dart';
// import 'package:oogie/screens/user/orders/order_return_request/order_return_request_view.dart';
// import 'package:oogie/special_components/stepper_vertical.dart';
//
// class MyOrderDeliveryDetailView extends StatelessWidget {
//   OrderModel orderModel;
//   int productIndex, orderIndex;
//
//   MyOrderDeliveryDetailView(
//       {this.orderModel, this.productIndex, this.orderIndex});
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: defaultAppBarWhite(context: context, text: 'Order Details'),
//       body: Container(
//         width: width,
//         height: height,
//         child: LayoutBuilder(builder: (context, constraints) {
//           return Stack(
//             children: [
//               SingleChildScrollView(
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                       minWidth: constraints.maxWidth,
//                       minHeight: constraints.maxHeight),
//                   child: IntrinsicHeight(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                               top: 20, left: 20, right: 20, bottom: 10),
//                           child: Text(
//                             'Order ID - ${orderModel.id}',
//                             style: TextStyles.smallRegularSubdued,
//                           ),
//                         ),
//                         dividerDefault,
//                         Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 20.0, right: 20),
//                             child: MyOrderProductAdapter(
//                               productModel: orderModel.products[productIndex],
//                               isListView: false,
//                             )),
//                         dividerDefault,
//                         SizedBox(
//                           child: StepperVertical(index: 0),
//                           height: 300,
//                         ),
//                         Spacer(),
//                         Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Total',
//                                 style: TextStyles.mediumMedium,
//                               ),
//                               Text(
//                                 rupeesString + '176.55',
//                                 style: TextStyles.mediumMedium,
//                               )
//                             ],
//                           ),
//                         ),
//                         Visibility(
//                             visible: false,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // CustomTextButton3(
//                                 //   text: 'Download Invoice',
//                                 // ),
//                                 // dividerDefault,
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     left: 20,
//                                     right: 20,
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 12,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Subtotal',
//                                             style:
//                                                 TextStyles.smallRegularSubdued,
//                                           ),
//                                           Text(
//                                             rupeesString + '165',
//                                             style:
//                                                 TextStyles.smallRegularSubdued,
//                                           )
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 12,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Shipping',
//                                             style:
//                                                 TextStyles.smallRegularSubdued,
//                                           ),
//                                           Text('FREE',
//                                               style: TextStyles
//                                                   .smallRegularSubdued)
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 12,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Expected Delivery',
//                                             style:
//                                                 TextStyles.smallRegularSubdued,
//                                           ),
//                                           Text(
//                                             'Apr 20 - 28',
//                                             style:
//                                                 TextStyles.smallRegularSubdued,
//                                           )
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 12,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Taxes',
//                                             style:
//                                                 TextStyles.smallRegularSubdued,
//                                           ),
//                                           Text(
//                                             rupeesString + '11.55',
//                                             style:
//                                                 TextStyles.smallRegularSubdued,
//                                           )
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 12,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Total',
//                                             style: TextStyles.mediumMedium,
//                                           ),
//                                           Text(
//                                             rupeesString + '176.55',
//                                             style: TextStyles.mediumMedium,
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             )),
//                         Spacer(),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20.0, right: 20),
//                           child: InkWell(
//                             splashColor: Colors.transparent,
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => MyOrderOriginalView(
//                                             orderModel: orderModel,
//                                           )));
//                             },
//                             child: Card(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Center(
//                                     child: Text(
//                                   'View Original Order',
//                                   style: TextStyles.mediumMediumSubdued,
//                                 )),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         SizedBox(
//                           height: 100,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
//                   child: DefaultButton(
//                     // text: widget.step == 3 ? 'Return' : 'Cancel',
//                     text: 'Return',
//                     action: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => BlocProvider(
//                                   create: (_) => OrderReturnRequestCubit(
//                                       orderRepository: orderRepository,
//                                       parentPage: 'myOrderDetailView',
//                                       productModel: orderModel.products[productIndex],
//                                       orderIndex: orderIndex,
//                                       productIndex: productIndex,
//                                       myOrdersCubit:
//                                           context.read<MyOrdersCubit>()),
//                                   child: OrderReturnRequestView(
//                                     orderModel: orderModel,
//                                     productIndex: productIndex,
//                                     orderIndex: orderIndex,
//                                   ))));
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
