import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/screens/delivery_partner/delivery_partner_home/delivery_partner_home_events.dart';
import 'package:oogie/screens/delivery_partner/delivery_partner_home/delivery_partner_home_state.dart';


class DeliveryPartnerHomeBloc
    extends Bloc<DeliveryPartnerHomeEvent, DeliveryPartnerHomeState> {
  DeliveryPartnerHomeBloc() : super(DeliveryPartnerHomeState());

  @override
  Stream<DeliveryPartnerHomeState> mapEventToState(
      DeliveryPartnerHomeEvent event) async* {
    // for changing tab
    if (event is ChangeTab) {
      yield state.copyWith(tabIndex: event.index);
    }
  }
}
