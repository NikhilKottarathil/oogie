import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/common/order/delivery_orders/delivery_orders_bloc.dart';
import 'package:oogie/screens/common/order/delivery_orders/delivery_orders_event.dart';
import 'package:oogie/screens/common/order/delivery_orders/delivery_orders_state.dart';
import 'package:oogie/screens/common/products/product_filter/filter_list_adapter.dart';

showDeliveryStatusFilter({BuildContext buildContext, String type}) async {
  await showModalBottomSheet(
      context: buildContext,
      enableDrag: false,
      useRootNavigator: true,
      builder: (builder) {
        return BlocProvider.value(
            value: buildContext.read<DeliveryOrdersBloc>(),
            child: BlocBuilder<DeliveryOrdersBloc, DeliveryOrdersState>(
                builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultAppBarWhite(
                    context: context,
                    text: 'Filter',
                    prefixWidget: Icon(
                      Icons.close,
                      color: AppColors.OutlinedIcon,
                    ),
                    prefixAction: () {
                      Navigator.of(context).pop();
                    },
                    suffixWidget: Padding(
                      padding: EdgeInsets.only(
                        right: 20,
                      ),
                      child: Center(
                        child: CustomTextButton2(
                            text: 'Clear All',
                            action: () {
                              print('clear pressed');
                              context
                                  .read<DeliveryOrdersBloc>()
                                  .add(ClearFilter(type: type));
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0,20,20,0),
                    child: FilterListAdapter(
                      filterModel: type == 'order'
                          ? state.orderStatusFilter
                          : state.returnOrderStatusFilter,
                      isMultiSelection: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DefaultButton(
                      text: 'Apply',
                      action: () {
                        context.read<DeliveryOrdersBloc>().add(FilterApplied());
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              );
            }));
      });
}
