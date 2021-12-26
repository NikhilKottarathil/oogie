import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/models/filter_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/repository/order_repository.dart';
import 'package:oogie/screens/common/order/delivery_orders/delivery_orders_event.dart';
import 'package:oogie/screens/common/order/delivery_orders/delivery_orders_state.dart';

class DeliveryOrdersBloc
    extends Bloc<DeliveryOrdersEvent, DeliveryOrdersState> {
  OrderRepository orderRepository;
  String parentPage;
  int orderPage=1;
  int returnOrderPage=1;



  DeliveryOrdersBloc({@required this.orderRepository, this.parentPage})
      : super(DeliveryOrdersState(
            orderModels: [],
            returnOrderModels: [],
            currentPageIndex: 0,
            orderFromDate: lastMidnight,
            orderToDate: todayMidnight,
            returnFromDate: lastMidnight,
            orderStatusFilter: defaultOrderStatuses,
            returnOrderStatusFilter: defaultReturnOrderStatuses,
            returnToDate: todayMidnight)) {
    state.parentPage = parentPage;

    getData();
  }

  getData() async {
    state.returnOrderModels.clear();
    state.orderModels.clear();

    List<String> returnOrderStatuses =
        state.returnOrderStatusFilter.values.where((element) => element.isSelected).map((e) => e.value).toList();
    List<String> orderStatuses =
        state.orderStatusFilter.values.where((element) => element.isSelected).map((e) => e.value).toList();

    List<OrderModel> orderModels = await orderRepository.getDeliveryOrders(
      page: orderPage,
        rowsPerPage: 10,
        parentPage: 'DeliveryOrders',
        vendorId: AppData().userId,
        agentType: FlavorConfig().flavorValue,
        deliveryType: 'order',
        states: orderStatuses,
        fromDate: state.orderFromDate,
        toDate: state.orderToDate);
    List<OrderModel> returnOrderModels =
        await orderRepository.getDeliveryOrders(
          page: returnOrderPage,
            rowsPerPage: 10,
            parentPage: 'DeliveryOrders',
            vendorId: AppData().userId,
            agentType: FlavorConfig().flavorValue,
            deliveryType: 'return',
            states: returnOrderStatuses,
            fromDate: state.returnFromDate,
            toDate: state.returnToDate);
    add(UpdateOrderModels(models: orderModels));
    add(UpdateReturnOrderModels(models: returnOrderModels));
  }

  @override
  Stream<DeliveryOrdersState> mapEventToState(
      DeliveryOrdersEvent event) async* {
    if (event is FetchInitialData) {
      yield state.copyWith(isLoading: true);
      await getData();
    } else if (event is UpdateOrderModels) {
      yield state.copyWith(orderModels: event.models);
    } else if (event is UpdateReturnOrderModels) {
      yield state.copyWith(returnOrderModels: event.models);
    } else if (event is OrderDateSelected) {
      yield state.copyWith(
          orderFromDate: event.fromDate, orderToDate: event.toDate);
      add(FetchInitialData());
    } else if (event is OrderDateSelected) {
      yield state.copyWith(
          orderFromDate: event.fromDate, orderToDate: event.toDate);
      add(FetchInitialData());
    } else if (event is ReturnOrderDateSelected) {
      yield state.copyWith(
          returnFromDate: event.fromDate, returnToDate: event.toDate);
      add(FetchInitialData());
    } else if (event is FilterApplied) {
      add(FetchInitialData());
    } else if (event is ClearFilter) {print('clear pressed');
      if (event.type == 'order') {
        state.orderStatusFilter.values.forEach((element) {element.isSelected=false;});
       yield state.copyWith(orderStatusFilter: state.orderStatusFilter);
      }else{
         state.returnOrderStatusFilter.values.forEach((element) {element.isSelected=false;});
        yield state.copyWith(returnOrderStatusFilter: state.returnOrderStatusFilter);
      }
    }
  }
}

var now = DateTime.now();
var lastMidnight = DateTime(now.year, now.month, now.day - 6);
var todayMidnight = DateTime(now.year, now.month, now.day + 1);

FilterModel defaultOrderStatuses =
    FilterModel(name: 'Status', id: 'sort', values: [
  KeyValueRadioModel(
    key: 'Placed',
    value: 'Placed',
    isSelected: false,
  ),
  KeyValueRadioModel(
    key: 'Shipped',
    value: 'Shipped',
    isSelected: false,
  ),
  KeyValueRadioModel(
    key: 'Fulfilled',
    value: 'Fulfilled',
    isSelected: false,
  ),
  KeyValueRadioModel(
    key: 'Cancelled',
    value: 'Cancelled',
    isSelected: false,
  ),

]);
 FilterModel defaultReturnOrderStatuses =
    FilterModel(name: 'Status', id: 'sort', values: [
      KeyValueRadioModel(
        key: 'Return Initiated',
        value: 'Return Initiated',
        isSelected: false,
      ),
      KeyValueRadioModel(
        key: 'Return Completed',
        value: 'Return Completed',
        isSelected: false,
      ),
]);
