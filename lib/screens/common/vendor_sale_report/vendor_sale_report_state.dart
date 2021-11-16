import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/models/order_model.dart';

class VendorSaleReportState {
  List<OrderModel> models = [];
  List<OrderModel> displayModels = [];

  PageScrollStatus pageScrollStatus;
  int page;
  List<String> ids = [];
  bool isLoading;
  String parentPage;
  Exception actionErrorMessage;
  String userType;
  DateTime fromDate, toDate;

  VendorSaleReportState(
      {this.models,
      this.pageScrollStatus = const InitialScrollStatus(),
      this.ids,
      this.page = 1,
      this.parentPage,
      this.actionErrorMessage,
      this.isLoading = false,
      this.userType,
      this.fromDate,
      this.toDate,
      this.displayModels});

  VendorSaleReportState copyWith({
    var models,
    var ids,
    bool isLoading,
    List displayModels,
    String parentPage,
    Exception actionErrorMessage,
    PageScrollStatus pageScrollStatus,
    int page,
    String userType,
    DateTime fromDate,
    toDate,
  }) {
    return VendorSaleReportState(
      models: models ?? this.models,
      displayModels: displayModels ?? this.displayModels,
      ids: ids ?? this.ids,
      pageScrollStatus: pageScrollStatus ?? this.pageScrollStatus,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      parentPage: parentPage ?? this.parentPage,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
      userType: userType ?? this.userType,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }
}
