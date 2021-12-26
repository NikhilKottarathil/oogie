import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/models/filter_model.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/models/product_model.dart';

class DeliveryOrdersState {
  List<OrderModel> orderModels = [];
  List<OrderModel> returnOrderModels = [];
  PageScrollStatus pageScrollStatus;
  int currentPageIndex;
  bool isLoading;
  String parentPage;
  Exception actionErrorMessage;
  DateTime orderFromDate, orderToDate,returnFromDate,returnToDate;
  FilterModel orderStatusFilter;
  FilterModel returnOrderStatusFilter;


  DeliveryOrdersState(
      {this.orderModels,
      this.returnOrderModels,
      this.pageScrollStatus = const InitialScrollStatus(),
      this.currentPageIndex = 0,
      this.parentPage,
        this.orderStatusFilter,
        this.returnOrderStatusFilter,
      this.actionErrorMessage,
        this.orderFromDate,this.orderToDate,this.isLoading,
        this.returnFromDate,this.returnToDate});

  DeliveryOrdersState copyWith({
    var orderModels,
    var returnOrderModels,
    var productIDs,
    bool isLoading,
    String parentPage,
    Exception actionErrorMessage,
    PageScrollStatus pageScrollStatus,
    int currentPageIndex,
    DateTime orderFromDate, orderToDate,returnFromDate,returnToDate,
    FilterModel orderStatusFilter,
    FilterModel returnOrderStatusFilter,
  }) {
    return DeliveryOrdersState(
      orderModels: orderModels ?? this.orderModels,
      returnOrderModels: returnOrderModels ?? this.returnOrderModels,
      pageScrollStatus: pageScrollStatus ?? this.pageScrollStatus,
      isLoading: isLoading ?? this.isLoading,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      parentPage: parentPage ?? this.parentPage,
      orderFromDate: orderFromDate ?? this.orderFromDate,
      orderToDate: orderToDate ?? this.orderToDate,
      returnFromDate: returnFromDate ?? this.returnFromDate,
      returnToDate: returnToDate ?? this.returnToDate,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
      orderStatusFilter: orderStatusFilter ?? this.orderStatusFilter,
      returnOrderStatusFilter: returnOrderStatusFilter ?? this.returnOrderStatusFilter,
    );
  }
}
