

import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/models/product_model.dart';


abstract class MyOrdersState {}
 class InitialState extends MyOrdersState {}
 class LoadingState extends MyOrdersState {}
 class ErrorMessageState extends MyOrdersState {
  Exception e;
  ErrorMessageState({this.e});
 }

class LoadOrderStatuses extends MyOrdersState {
  final List<KeyValueRadioModel> models;

  LoadOrderStatuses({this.models});

  LoadOrderStatuses copyWith({
    List<KeyValueRadioModel> messageModels,
  }) {
    return LoadOrderStatuses(
      models: models ?? this.models,
    );
  }

  List<Object> get props => [models];
}
class LoadAllItems extends MyOrdersState {
  final List<OrderModel> models;

  LoadAllItems({this.models});

  LoadAllItems copyWith({
    List<OrderModel> messageModels,
  }) {
    return LoadAllItems(
      models: models ?? this.models,
    );
  }

  List<Object> get props => [models];
}

// class LoadOnTheWayItems extends MyOrdersState {
//   final List<OrderModel> models;
//
//   LoadOnTheWayItems({this.models});
//
//   LoadOnTheWayItems copyWith({
//     List<OrderModel> messageModels,
//   }) {
//     return LoadOnTheWayItems(
//       models: models ?? this.models,
//     );
//   }
//
//   List<Object> get props => [models];
// }
// class LoadDeliveredItems extends MyOrdersState {
//   final List<OrderModel> models;
//
//   LoadDeliveredItems({this.models});
//
//   LoadDeliveredItems copyWith({
//     List<OrderModel> messageModels,
//   }) {
//     return LoadDeliveredItems(
//       models: models ?? this.models,
//     );
//   }
//
//   List<Object> get props => [models];
// }
// class LoadCanceledItems extends MyOrdersState {
//   final List<OrderModel> models;
//
//   LoadCanceledItems({this.models});
//
//   LoadCanceledItems copyWith({
//     List<OrderModel> messageModels,
//   }) {
//     return LoadCanceledItems(
//       models: models ?? this.models,
//     );
//   }
//
//   List<Object> get props => [models];
// }