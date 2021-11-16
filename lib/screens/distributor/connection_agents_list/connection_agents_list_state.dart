import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/user_model.dart';

class ConnectionAgentsListState {
  List<UserModel> models = [];
  List<UserModel> displayModels = [];
  List<KeyValueRadioModel> filterModels = [];
  PageScrollStatus pageScrollStatus;
  int page;
  List<String> ids = [];
  bool isLoading;
  String parentPage;
  Exception actionErrorMessage;
  String userType;

  ConnectionAgentsListState({
    this.models,
    this.pageScrollStatus = const InitialScrollStatus(),
    this.ids,
    this.page = 1,
    this.displayModels,
    this.parentPage,
    this.actionErrorMessage,
    this.isLoading = false,
    this.filterModels,
    this.userType,
  });

  ConnectionAgentsListState copyWith({
    var models,
    var ids,
    bool isLoading,
    List displayModels,
    List filterModels,
    String parentPage,
    Exception actionErrorMessage,
    PageScrollStatus pageScrollStatus,
    int page,
    String userType,
  }) {
    return ConnectionAgentsListState(
      models: models ?? this.models,
      displayModels: displayModels ?? this.displayModels,
      ids: ids ?? this.ids,
      pageScrollStatus: pageScrollStatus ?? this.pageScrollStatus,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      filterModels: filterModels ?? this.filterModels,
      parentPage: parentPage ?? this.parentPage,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
      userType: userType ?? this.userType,
    );
  }
}
