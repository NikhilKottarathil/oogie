import 'package:oogie/models/order_model.dart';

class VendorSaleReportEvent {}

class FetchInitialData extends VendorSaleReportEvent {}

class UpdatedList extends VendorSaleReportEvent {
  List<OrderModel> productModels;

  UpdatedList({this.productModels});
}

class RefreshList extends VendorSaleReportEvent {}

class DateSelected extends VendorSaleReportEvent {
  DateTime fromDate, toDate;

  DateSelected({this.toDate, this.fromDate});
}

class FilterItemSelected extends VendorSaleReportEvent {
  int index;

  FilterItemSelected({this.index});
}

class FetchMoreData extends VendorSaleReportEvent {}
