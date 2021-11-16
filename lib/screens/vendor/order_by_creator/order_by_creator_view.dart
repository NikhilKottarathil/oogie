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
import 'package:oogie/screens/vendor/order_by_creator/order_by_creator_bloc.dart';
import 'package:oogie/screens/vendor/order_by_creator/order_by_creator_state.dart';
import 'package:oogie/screens/vendor/order_by_creator/order_by_creator_event.dart';
import 'package:oogie/screens/vendor/order_by_creator/order_details_by_creator_view.dart';

class OrderByCreatorView extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: BlocListener<OrderByCreatorBloc, OrderByCreatorState>(
        listener: (context, state) async {
          Exception e = state.actionErrorMessage;
          if (e != null && e.toString().length != 0) {
            showSnackBar(context, e);
          }
        },
        child: BlocBuilder<OrderByCreatorBloc, OrderByCreatorState>(
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
                                      context.read<OrderByCreatorBloc>().add(
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDetailsByCreatorView(
                                                      orderModel: state
                                                          .orderModels[index],
                                                    )));
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
                                      context.read<OrderByCreatorBloc>().add(
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDetailsByCreatorView(
                                                      orderModel: state
                                                              .returnOrderModels[
                                                          index],
                                                    )));
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

removeFromCart(
    {BuildContext buildContext,
    ProductModel productModel,
    int index,
    String cartType}) async {
  await showModalBottomSheet(
      context: buildContext,
      enableDrag: false,
      useRootNavigator: true,
      isScrollControlled: false,
      // constraints: BoxConstraints(
      //   maxHeight: MediaQuery.of(buildContext).size.height - 30,
      // ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (builder) {
        return BlocProvider.value(
          value: buildContext.read<OrderByCreatorBloc>(),
          child: BlocBuilder<OrderByCreatorBloc, OrderByCreatorState>(
              builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: productModel.imageUrl != null
                                  ? Image.network(productModel.imageUrl,
                                      fit: BoxFit.scaleDown)
                                  : SvgPicture.asset(Urls().productImage,
                                      fit: BoxFit.scaleDown)),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Remove from cart ?',
                            style: TextStyles.largeRegular,
                          ),
                          Text(
                            productModel.displayName,
                            style: TextStyles.smallRegularSubdued,
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColors.TextDefault,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              width: 1.0,
                              color: AppColors.BorderDefault,
                              style: BorderStyle.solid,
                            ),
                          ),
                          onPressed: () {
                            buildContext.read<OrderByCreatorBloc>().add(
                                RemoveProductFromCart(
                                    cartType: cartType, index: index));
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                              padding: EdgeInsets.all(14),
                              child: Text(' Delete ',
                                  style: TextStyles.smallMedium))),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.PrimaryBase),
                          child: Padding(
                              padding: EdgeInsets.all(14),
                              child: Text(
                                'Move to Wishlist',
                                style: TextStyles.smallMediumWhite,
                              )),
                          onPressed: () {
                            buildContext.read<OrderByCreatorBloc>().add(
                                MoveProductToWishList(
                                    cartType: cartType, index: index));
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
        );
      });
}
