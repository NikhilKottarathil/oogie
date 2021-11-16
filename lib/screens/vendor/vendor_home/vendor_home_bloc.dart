import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/screens/vendor/vendor_home/vendor_home_events.dart';
import 'package:oogie/screens/vendor/vendor_home/vendor_home_state.dart';

class VendorHomeBloc extends Bloc<VendorHomeEvent, VendorHomeState> {
  VendorHomeBloc() : super(VendorHomeState());

  @override
  Stream<VendorHomeState> mapEventToState(VendorHomeEvent event) async* {
    // for changing tab
    if (event is ChangeTab) {
      yield state.copyWith(tabIndex: event.index);
    }
  }
}
