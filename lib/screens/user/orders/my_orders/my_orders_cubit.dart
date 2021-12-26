import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/repository/order_repository.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/user/orders/my_orders/my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  OrderRepository orderRepository;
  String parentPage;
  List<KeyValueRadioModel> orderStatuses = defaultOrderStatuses;
  List<OrderModel> allOrderModels = [];
  List<OrderModel> onTheWayOrderModels = [];
  List<OrderModel> deliveredOrderModels = [];
  List<OrderModel> cancelledOrderModels = [];
  int page=1;

  MyOrdersCubit({@required this.orderRepository, this.parentPage})
      : super(InitialState()) {
    getInitialData();
    emit(LoadOrderStatuses(models: orderStatuses));
  }

  getInitialData() async {
    page=1;
    allOrderModels.clear();
    getOrders();
  }

  loadMoreData() {
    emit(LoadingState());
    page=page+1;
    getOrders();

  }

  getOrders() async {
    List<OrderModel> orderModels =
        await orderRepository.getOrdersByUser(page: page, rowsPerPage: 10);
    allOrderModels.addAll(orderModels);
    emit(LoadAllItems(models: allOrderModels));
  }

//   @override
//   Stream<DeliveryOrdersState> mapEventToState(OrderByCreatorEvent event) async* {
//     if (event is FetchInitialData) {
//       yield state.copyWith(isLoading: true);
//       await getData();
//     } else if (event is UpdateOrderModels) {
//       yield state.copyWith(orderModels: event.models);
//     } else if (event is UpdateReturnOrderModels) {
//       yield state.copyWith(returnOrderModels: event.models);
//     } else if (event is MoveProductToWishList) {
//       print('move to wishlist ${event.index} t ${event.cartType}');
//       try {
//         String productId = '';
//         if (event.cartType == 'new') {
//           productId = state.orderModels[event.index].id;
//         } else {
//           productId = state.returnOrderModels[event.index].id;
//         }
//
//         String cartId = '';
//         if (event.cartType == 'new') {
//           cartId = state.orderModels[event.index].id;
//         } else {
//           cartId = state.returnOrderModels[event.index].id;
//         }
//         print('if condition k');
//         // await productRepository.deleteProductFromCart(cartID: cartId);
//         // await productRepository.addProductToWishList(productId: productId);
//
//         await getData();
//       } catch (e) {
//         yield state.copyWith(actionErrorMessage: e);
//       }
//     } else if (event is RemoveProductFromCart) {
//       try {
//         String cartId = '';
//         if (event.cartType == 'new') {
//           cartId = state.orderModels[event.index].id;
//         } else {
//           cartId = state.returnOrderModels[event.index].id;
//         }
//         // await productRepository.deleteProductFromCart(cartID: cartId);
//         await getData();
//       } catch (e) {
//         yield state.copyWith(actionErrorMessage: e);
//       }
//     }
//     else if (event is OrderDateSelected) {
//       yield state.copyWith(orderFromDate: event.fromDate, orderToDate: event.toDate);
//       add(FetchInitialData());
//     }else if (event is OrderDateSelected) {
//       yield state.copyWith(orderFromDate: event.fromDate, orderToDate: event.toDate);
//       add(FetchInitialData());
//     }
//     else if (event is ReturnOrderDateSelected) {
//       yield state.copyWith(returnFromDate: event.fromDate, returnToDate: event.toDate);
//       add(FetchInitialData());
//     }
//
//   }
// }

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
