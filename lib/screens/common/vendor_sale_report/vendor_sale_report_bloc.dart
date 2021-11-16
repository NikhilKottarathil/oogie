import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/user_model.dart';
import 'package:oogie/repository/distributor_repository.dart';
import 'package:oogie/repository/order_repository.dart';
import 'package:oogie/repository/vendor_repository.dart';
import 'package:oogie/repository/wholesale_repository.dart';
import 'package:oogie/screens/common/vendor_sale_report/vendor_sale_report_event.dart';
import 'package:oogie/screens/common/vendor_sale_report/vendor_sale_report_state.dart';

class VendorSaleReportBloc
    extends Bloc<VendorSaleReportEvent, VendorSaleReportState> {
  DistributorRepository distributorRepository;
  final OrderRepository orderRepository;
  String parentPage;
  UserModel userModel;

  VendorSaleReportBloc(
      {@required this.distributorRepository,
      this.orderRepository,
      this.userModel,
      @required this.parentPage})
      : super(VendorSaleReportState(
            models: [],
            ids: [],
            displayModels: [],
            fromDate: lastMidnight,
            toDate: todayMidnight)) {
    state.parentPage = parentPage;
    print('inside list');
    print('vendor_id' + userModel.id);

    getInitialProducts();
  }

  getInitialProducts() async {
    state.models.clear();
    state.ids.clear();
    state.page = 1;
      var productModels = await orderRepository.getDeliveryOrders(
          page: state.page,
          rowsPerPage: 20,
          parentPage: parentPage,
          fromDate: state.fromDate,
          agentType: userModel.userType,
          toDate: state.toDate,
          vendorId: userModel.id);
      add(UpdatedList(productModels: productModels));
  }

  getMoreProducts() async {
    state.page = state.page + 1;
      var productModels = await orderRepository.getDeliveryOrders(
          page: state.page,
          rowsPerPage: 20,
          parentPage: parentPage,
          fromDate: state.fromDate,
          agentType: userModel.userType,
          toDate: state.toDate,
          vendorId: userModel.id);
      add(UpdatedList(productModels: productModels));

  }

  @override
  Stream<VendorSaleReportState> mapEventToState(
      VendorSaleReportEvent event) async* {
    if (event is FetchInitialData) {
      print('fetch initailaDAta');
      yield state.copyWith(isLoading: true);
      await getInitialProducts();
    } else if (event is FetchMoreData) {
      yield state.copyWith(isLoading: true);
      await getMoreProducts();
    } else if (event is UpdatedList) {
      state.models.clear();
      state.displayModels.clear();
      state.models.addAll(event.productModels);
      state.displayModels.addAll(event.productModels);
      yield state.copyWith(isLoading: false);
    } else if (event is DateSelected) {
      yield state.copyWith(fromDate: event.fromDate, toDate: event.toDate);
      add(FetchInitialData());
    }
  }
}

List<KeyValueRadioModel> defaultFilterModels = [
  KeyValueRadioModel(isSelected: true, value: 'all', key: 'All'),
  KeyValueRadioModel(isSelected: false, value: 'vendor', key: 'Vendors'),
  KeyValueRadioModel(
      isSelected: false, value: 'wholesale_dealer', key: 'Wholesale Dealers'),
];

var now = DateTime.now();
var lastMidnight = DateTime(now.year, now.month, now.day-7);
var todayMidnight = DateTime(now.year, now.month, now.day + 1);
