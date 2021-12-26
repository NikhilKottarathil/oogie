import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/screens/user/used_phones/used_phone_home/used_phone_home_events.dart';
import 'package:oogie/screens/user/used_phones/used_phone_home/used_phone_home_state.dart';


class UsedPhoneHomeBloc extends Bloc<UsedPhoneHomeEvent, UsedPhoneHomeState> {
  UsedPhoneHomeBloc() : super(UsedPhoneHomeState());

  @override
  Stream<UsedPhoneHomeState> mapEventToState(UsedPhoneHomeEvent event) async* {
    // for changing tab
    if (event is ChangeTab) {
      yield state.copyWith(tabIndex: event.index);
    }
  }
}
