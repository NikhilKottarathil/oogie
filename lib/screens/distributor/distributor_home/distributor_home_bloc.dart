import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/screens/distributor/distributor_home/distributor_home_events.dart';
import 'package:oogie/screens/distributor/distributor_home/distributor_home_state.dart';

class DistributorHomeBloc
    extends Bloc<DistributorHomeEvent, DistributorHomeState> {
  DistributorHomeBloc() : super(DistributorHomeState());

  @override
  Stream<DistributorHomeState> mapEventToState(
      DistributorHomeEvent event) async* {
    // for changing tab
    if (event is ChangeTab) {
      yield state.copyWith(tabIndex: event.index);
    }
  }
}
