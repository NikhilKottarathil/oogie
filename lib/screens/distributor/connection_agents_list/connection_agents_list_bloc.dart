import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/repository/distributor_repository.dart';
import 'package:oogie/screens/distributor/connection_agents_list/connection_agents_list_event.dart';
import 'package:oogie/screens/distributor/connection_agents_list/connection_agents_list_state.dart';

class ConnectionAgentsListBloc
    extends Bloc<ConnectionAgentsListEvent, ConnectionAgentsListState> {
  DistributorRepository distributorRepository;
  String parentPage;

  ConnectionAgentsListBloc(
      {@required this.distributorRepository, @required this.parentPage})
      : super(ConnectionAgentsListState(
            models: [],
            ids: [],
            filterModels: defaultFilterModels,
            displayModels: [])) {
    state.parentPage = parentPage;
    print('inside list');
    getInitialProducts();
  }

  getInitialProducts() async {
    state.models.clear();
    state.ids.clear();
    state.page = 1;
    var productModels = await distributorRepository.getConnectionAgents(
        state.page, 10, parentPage);
    add(UpdatedList(productModels: productModels));
  }

  getMoreProducts() async {
    state.page = state.page + 1;
    var productModels = await distributorRepository.getConnectionAgents(
        state.page, 10, parentPage);
    add(UpdatedList(productModels: productModels));
  }

  @override
  Stream<ConnectionAgentsListState> mapEventToState(
      ConnectionAgentsListEvent event) async* {
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
    } else if (event is FilterItemSelected) {
      print('FilterItem Selected');
      Future.forEach(state.filterModels, (element) {
        print('inside');
        element.isSelected = false;
      });
      state.filterModels[event.index].isSelected = true;
      String filterType = state.filterModels[event.index].value;
      state.displayModels.clear();

      Future.forEach(state.models, (element) {
        if (filterType == 'all') {
          state.displayModels.add(element);
        } else if (filterType == element.userType) {
          state.displayModels.add(element);
        }
      });
      yield state.copyWith(filterModels: state.filterModels);
    }
  }
}

List<KeyValueRadioModel> defaultFilterModels = [
  KeyValueRadioModel(isSelected: true, value: 'all', key: 'All'),
  KeyValueRadioModel(isSelected: false, value: 'vendor', key: 'Shop Owner'),
  KeyValueRadioModel(
      isSelected: false, value: 'wholesale_dealer', key: 'Wholesale Dealers'),
];
