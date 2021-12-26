

import 'package:oogie/models/delivery_order_Model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/order_model.dart';


abstract class OriginalOrderState {}
 class InitialState extends OriginalOrderState {}
 class LoadingState extends OriginalOrderState {}
 class ErrorMessageState extends OriginalOrderState {
  Exception e;
  ErrorMessageState({this.e});
 }

class OrderDataState extends OriginalOrderState {
  final OrderModel orderModel;

  OrderDataState({this.orderModel});

  OrderDataState copyWith({
    List<KeyValueRadioModel> messageModels,
  }) {
    return OrderDataState(
      orderModel: orderModel ?? this.orderModel,
    );
  }

  List<Object> get props => [orderModel];
}


