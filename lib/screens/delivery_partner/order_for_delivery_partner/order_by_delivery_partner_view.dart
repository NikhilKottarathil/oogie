import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/cart_adapter.dart';
import 'package:oogie/adapters/order_agent_adapter.dart';
import 'package:oogie/adapters/order_report_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_blue.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/date_conversion.dart';
import 'package:oogie/functions/date_picker_from_and_to.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/screens/delivery_partner/order_for_delivery_partner/order_by_delivery_partner_bloc.dart';
import 'package:oogie/screens/delivery_partner/order_for_delivery_partner/order_by_delivery_partner_event.dart';
import 'package:oogie/screens/delivery_partner/order_for_delivery_partner/order_for_delivery_partner_state.dart';

class OrderByDeliveryPartnerView extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: BlocListener<OrderByDeliveryPartnerBloc, OrderByDeliveryPartnerState>(
        listener: (context, state) async {
          Exception e = state.actionErrorMessage;
          if (e != null && e.toString().length != 0) {
            showSnackBar(context, e);
          }
        },
        child: BlocBuilder<OrderByDeliveryPartnerBloc, OrderByDeliveryPartnerState>(
            builder: (context, state) {
          return Container(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                // appBar: AppBar(
                //   backgroundColor: Colors.white,
                //   elevation: 2,
                //   shadowColor: AppColors.SkyLightest.withOpacity(.5),
                //   title:
                // ),
                appBar: TabBar(
                  unselectedLabelColor: AppColors.TextSubdued,
                  labelColor: AppColors.TextDefault,
                  labelStyle: TextStyles.smallRegular,
                  indicatorColor: AppColors.PrimaryBase,
                  indicatorSize: TabBarIndicatorSize.values[1],
                  tabs: [
                    Tab(
                      icon: Text(
                        "Delivery Orders",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Tab(
                        icon: Text(
                      "Return Orders",
                      style: TextStyle(fontSize: 18),
                    )),
                  ],
                ),
                body: TabBarView(
                  children: [
                    Column(
                      children: [
                        Container(
                          // decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     border: Border.all(color: AppColors.BorderDefault),
                          //     borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                      'From\t' +
                                          getDateString(state.orderFromDate
                                              .millisecondsSinceEpoch
                                              .toString()) +
                                          '\t to\t' +
                                          getDateString(state.orderToDate
                                              .millisecondsSinceEpoch
                                              .toString()),
                                      style: TextStyles.smallRegular)),
                              IconButton(
                                  icon: Icon(Icons.calendar_today_outlined),
                                  onPressed: () async {
                                    try {
                                      var data = await datePickerFromAndTo(
                                          context: context,
                                          fromDate: state.orderFromDate,
                                          toDate: state.orderToDate);
                                      context.read<OrderByDeliveryPartnerBloc>().add(
                                          OrderDateSelected(
                                              fromDate: data[0],
                                              toDate: data[1]));
                                    } catch (e) {}
                                  }),
                            ],
                          ),
                        ),
                        dividerDefault,
                        Expanded(
                          child: state.orderModels.length == 0
                              ? Center(
                                  child: Text(
                                  'You have no orders',
                                  style: TextStyles.mediumMediumSubdued,
                                ))
                              : ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.orderModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.pushNamed(context, '/orderDetails',arguments: {'parentPage':'deliveryPartnerOrders','deliveryOrderId':state.orderModels[index].products[0].deliveryOrderId});

                                      },
                                      child: OrderAgentAdapter(
                                        orderModel: state.orderModels[index],
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 20,
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
// decoration: BoxDecoration(
//     color: Colors.white,
//     border: Border.all(color: AppColors.BorderDefault),
//     borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                      'From\t' +
                                          getDateString(state.returnFromDate
                                              .millisecondsSinceEpoch
                                              .toString()) +
                                          '\t to\t' +
                                          getDateString(state.returnToDate
                                              .millisecondsSinceEpoch
                                              .toString()),
                                      style: TextStyles.smallRegular)),
                              IconButton(
                                  icon: Icon(Icons.calendar_today_outlined),
                                  onPressed: () async {
                                    try {
                                      var data = await datePickerFromAndTo(
                                          context: context,
                                          fromDate: state.returnFromDate,
                                          toDate: state.returnToDate);
                                      context.read<OrderByDeliveryPartnerBloc>().add(
                                          OrderDateSelected(
                                              fromDate: data[0],
                                              toDate: data[1]));
                                    } catch (e) {}
                                  }),
                            ],
                          ),
                        ),
                        dividerDefault,
                        Expanded(
                          child: state.returnOrderModels.length == 0
                              ? Center(
                                  child: Text(
                                  'You have no orders',
                                  style: TextStyles.mediumMediumSubdued,
                                ))
                              : ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.returnOrderModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.pushNamed(context, '/orderDetails',arguments: {'parentPage':'deliveryPartnerOrders','deliveryOrderId':state.returnOrderModels[index].products[0].deliveryOrderId});

                                      },
                                      child: OrderAgentAdapter(
                                        orderModel:
                                            state.returnOrderModels[index],
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 20,
                                    );
                                  },
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
