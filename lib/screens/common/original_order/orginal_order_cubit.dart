import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:oogie/models/order_model.dart';
import 'package:oogie/repository/order_repository.dart';
import 'package:oogie/screens/common/original_order/orginal_order_state.dart';


class OriginalOrderCubit extends Cubit<OriginalOrderState> {
  OrderRepository orderRepository;
  String orderId;
  String parentPage;



  OriginalOrderCubit(
      {@required this.orderRepository, this.parentPage, this.orderId})
      : super(InitialState()) {
    getInitialData();
  }

  getInitialData() async {
    var orderModel = await orderRepository
        .getDetailsOfSelectedOrder(orderId: orderId);

    emit(OrderDataState(orderModel: orderModel));
  }


}

