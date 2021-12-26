

import 'package:oogie/models/delivery_order_Model.dart';
import 'package:oogie/models/key_value_radio_model.dart';


abstract class OrderDetailsState {}
 class InitialState extends OrderDetailsState {}
 class LoadingState extends OrderDetailsState {}
 class ErrorMessageState extends OrderDetailsState {
  Exception e;
  ErrorMessageState({this.e});
 }

class OrderDataState extends OrderDetailsState {
  final DeliveryOrderModel deliveryOrderModel;

  OrderDataState({this.deliveryOrderModel});

  OrderDataState copyWith({
    List<KeyValueRadioModel> messageModels,
  }) {
    return OrderDataState(
      deliveryOrderModel: deliveryOrderModel ?? this.deliveryOrderModel,
    );
  }

  List<Object> get props => [deliveryOrderModel];
}


