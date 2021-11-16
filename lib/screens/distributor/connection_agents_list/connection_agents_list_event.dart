import 'package:oogie/models/user_model.dart';

class ConnectionAgentsListEvent {}

class FetchInitialData extends ConnectionAgentsListEvent {}

class UpdatedList extends ConnectionAgentsListEvent {
  List<UserModel> productModels;

  UpdatedList({this.productModels});
}

class RefreshList extends ConnectionAgentsListEvent {}

class FilterItemSelected extends ConnectionAgentsListEvent {
  int index;

  FilterItemSelected({this.index});
}

class FetchMoreData extends ConnectionAgentsListEvent {}
