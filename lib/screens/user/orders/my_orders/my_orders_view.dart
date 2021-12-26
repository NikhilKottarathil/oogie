import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/my_order_adapter.dart';
import 'package:oogie/adapters/order_agent_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/constants/page_scroll_status.dart';

import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/screens/common/products/product_filter/filter_list_adapter.dart';
import 'package:oogie/screens/user/orders/my_orders/my_order_detail_view.dart';
import 'package:oogie/screens/user/orders/my_orders/my_orders_cubit.dart';
import 'package:oogie/screens/user/orders/my_orders/my_orders_state.dart';
import 'package:oogie/screens/vendor_old/components/order_adapter.dart';

class MyOrdersView extends StatelessWidget {
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext buildContext) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        buildContext.read<MyOrdersCubit>().loadMoreData();
      }
    });
    return Scaffold(
      // backgroundColor: AppColors.SkyLighter,
      appBar: defaultAppBarWhite(text: 'My Orders', context: buildContext),
      body: BlocListener<MyOrdersCubit, MyOrdersState>(
        listener: (context, state) async {
          if (state is ErrorMessageState) {
            showSnackBar(context, state.e);

          }
        },

        child: Column(
          children: [
            // BlocBuilder<MyOrdersCubit, MyOrdersState>(
            //     buildWhen: (prevState, state) {
            //   return state is LoadOrderStatuses;
            // }, builder: (context, state) {
            //   return state is LoadOrderStatuses
            //       ? Padding(
            //           padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            //           child: Wrap(
            //             children: List.generate(state.models.length,
            //                 (index) => KeyValueRadioItem(state.models[index])),
            //           ),
            //         )
            //       : Container();
            // }),
            Expanded(
              child: BlocBuilder<MyOrdersCubit, MyOrdersState>(
                  buildWhen: (prevState, state) {
                return state is LoadAllItems || state is InitialState;
              }, builder: (context, state) {
                return state is LoadAllItems
                    ? state.models.length == 0
                        ? Center(
                            child: Text(
                              'You have no orders',
                              style: TextStyles.mediumMediumSubdued,
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            itemCount: state.models.length,
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return BlocProvider.value(
                                value: context.read<MyOrdersCubit>(),
                                child: MyOrderAdapter(

                                  orderModel: state.models[index],orderIndex: index,
                                ),
                              );
                            }, separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(height: 25,);
                },)
                    : Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
              }),
            ),
            BlocBuilder<MyOrdersCubit, MyOrdersState>(
                builder: (context, state) {
              return state is LoadingState
                  ? CircularProgressIndicator()
                  : Container();
            })
          ],
        ),
      ),
    );
  }
}
