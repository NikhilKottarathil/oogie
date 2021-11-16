import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/repository/order_repository.dart';
import 'package:oogie/repository/product_repository.dart';

import 'package:oogie/screens/vendor/order_by_creator/order_by_creator_event.dart';
import 'package:oogie/screens/vendor/order_by_creator/order_by_creator_state.dart';

class OrderByCreatorBloc extends Bloc<OrderByCreatorEvent, OrderByCreatorState> {
  OrderRepository orderRepository;
  String parentPage;

  OrderByCreatorBloc({@required this.orderRepository, this.parentPage})
      : super(OrderByCreatorState(
            orderModels: [], returnOrderModels: [], currentPageIndex: 0,orderFromDate: lastMidnight,orderToDate: todayMidnight,returnFromDate: lastMidnight,returnToDate: todayMidnight)) {
    state.parentPage = parentPage;

    getData();
  }

  getData() async {
    state.returnOrderModels.clear();
    state.orderModels.clear();


    List<OrderModel> orderModels = await orderRepository.getDeliveryOrders(parentPage: 'orderByCreator',vendorId: AppData().userId,agentType: FlavorConfig().flavorValue,deliveryType:'order',state:'',fromDate: state.orderFromDate,toDate: state.orderToDate);
    List<OrderModel> returnOrderModels = await orderRepository.getDeliveryOrders(parentPage: 'orderByCreator',vendorId: AppData().userId,agentType: FlavorConfig().flavorValue,deliveryType:'return',state:'',fromDate: state.returnFromDate,toDate: state.returnToDate);
    add(UpdateOrderModels(models: orderModels));
    add(UpdateOrderModels(models: returnOrderModels));
  }

  @override
  Stream<OrderByCreatorState> mapEventToState(OrderByCreatorEvent event) async* {
    if (event is FetchInitialData) {
      yield state.copyWith(isLoading: true);
      await getData();
    } else if (event is UpdateOrderModels) {
      yield state.copyWith(orderModels: event.models);
    } else if (event is UpdateReturnOrderModels) {
      yield state.copyWith(returnOrderModels: event.models);
    } else if (event is MoveProductToWishList) {
      print('move to wishlist ${event.index} t ${event.cartType}');
      try {
        String productId = '';
        if (event.cartType == 'new') {
          productId = state.orderModels[event.index].id;
        } else {
          productId = state.returnOrderModels[event.index].id;
        }

        String cartId = '';
        if (event.cartType == 'new') {
          cartId = state.orderModels[event.index].id;
        } else {
          cartId = state.returnOrderModels[event.index].id;
        }
        print('if condition k');
        // await productRepository.deleteProductFromCart(cartID: cartId);
        // await productRepository.addProductToWishList(productId: productId);

        await getData();
      } catch (e) {
        yield state.copyWith(actionErrorMessage: e);
      }
    } else if (event is RemoveProductFromCart) {
      try {
        String cartId = '';
        if (event.cartType == 'new') {
          cartId = state.orderModels[event.index].id;
        } else {
          cartId = state.returnOrderModels[event.index].id;
        }
        // await productRepository.deleteProductFromCart(cartID: cartId);
        await getData();
      } catch (e) {
        yield state.copyWith(actionErrorMessage: e);
      }
    }
    else if (event is OrderDateSelected) {
      yield state.copyWith(orderFromDate: event.fromDate, orderToDate: event.toDate);
      add(FetchInitialData());
    }else if (event is OrderDateSelected) {
      yield state.copyWith(orderFromDate: event.fromDate, orderToDate: event.toDate);
      add(FetchInitialData());
    }
    else if (event is ReturnOrderDateSelected) {
      yield state.copyWith(returnFromDate: event.fromDate, returnToDate: event.toDate);
      add(FetchInitialData());
    }

  }
}
var now = DateTime.now();
var lastMidnight = DateTime(now.year, now.month, now.day);
var todayMidnight = DateTime(now.year, now.month, now.day + 1);
