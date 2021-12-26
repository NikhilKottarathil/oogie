import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/models/delivery_order_Model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/repository/order_repository.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/common/order/delivery_orders/delivery_orders_bloc.dart';
import 'package:oogie/screens/common/order_details/order_details_state.dart';
import 'package:oogie/screens/user/orders/my_orders/my_orders_cubit.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderRepository orderRepository;
  String deliveryOrderId;
  String parentPage;

  MyOrdersCubit myOrdersCubit;
  DeliveryOrdersBloc deliveryOrdersBloc;
  DeliveryOrderModel deliveryOrderModel;
  bool buttonVisibility = false;
  String buttonText = 'Save';

  OrderDetailsCubit(
      {@required this.orderRepository,this.deliveryOrdersBloc, this.parentPage, this.deliveryOrderId})
      : super(InitialState()) {
    getInitialData();
  }

  getInitialData() async {
    deliveryOrderModel = await orderRepository
        .getDetailsOfSelectedDeliveryOrder(deliveryOrderId: deliveryOrderId);
    print('parentPage');
    print(parentPage);
    print(deliveryOrderModel.deliveryState);
    print(deliveryOrderModel.isUSedProductOrder);
    buttonVisibility = (parentPage == 'deliveryPartnerOrders' &&
            (deliveryOrderModel.deliveryState == 'Shipped' ||
                deliveryOrderModel.deliveryState == 'Return Initiated')) ||
        (parentPage == 'myOrders' &&
            (deliveryOrderModel.deliveryState == 'Placed' ||
                deliveryOrderModel.deliveryState == 'Shipped'|| (deliveryOrderModel.deliveryState == 'Fulfilled' && !deliveryOrderModel.isUSedProductOrder)));

    buttonText = parentPage == 'myOrders'
        ? deliveryOrderModel.deliveryState == 'Placed' ||
                deliveryOrderModel.deliveryState == 'Shipped'
            ? 'Cancel Order'
            : 'Return'
        : deliveryOrderModel.deliveryState == 'Shipped'
            ? 'Delivery Completed'
            : 'PickUp Completed';
    emit(InitialState());

   await Future.delayed(Duration(milliseconds: 500));
    emit(OrderDataState(deliveryOrderModel: deliveryOrderModel));
  }


  buttonPressed()async{
    String nextDeliveryState;
    if(buttonText=='Cancel Order'){
      nextDeliveryState='Cancelled';
    }
    else if(deliveryOrderModel.deliveryState=='Placed'){
      nextDeliveryState='Shipped';
    }else if(deliveryOrderModel.deliveryState=='Shipped'){
      nextDeliveryState='Fulfilled';
    }else if(deliveryOrderModel.deliveryState=='Return Initiated'){
      nextDeliveryState='Return Completed';
    }
    //

    try{
      await orderRepository.updateDeliveryOrder(deliveryOrderId: deliveryOrderId,deliveryState: nextDeliveryState);
      getInitialData();
    }catch(e){
      emit(ErrorMessageState(e:e));
    }
  }

}

var now = DateTime.now();
var lastMidnight = DateTime(now.year, now.month, now.day);
var todayMidnight = DateTime(now.year, now.month, now.day + 1);

List<KeyValueRadioModel> defaultOrderStatuses = [
  KeyValueRadioModel(key: 'All', value: 'all', isSelected: true),
  KeyValueRadioModel(key: 'On the way', value: 'on_the_way', isSelected: false),
  KeyValueRadioModel(key: 'Delivered', value: 'delivered', isSelected: false),
  KeyValueRadioModel(key: 'Cancelled', value: 'cancelled', isSelected: false),
];
