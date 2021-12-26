abstract class DeliveryPartnerHomeEvent {}

class FabPressed extends DeliveryPartnerHomeEvent {}

class NotificationClicked extends DeliveryPartnerHomeEvent {}

class CreateClicked extends DeliveryPartnerHomeEvent {}

class OptionMenuClicked extends DeliveryPartnerHomeEvent {}

class ChangeTab extends DeliveryPartnerHomeEvent {
  final int index;

  ChangeTab(this.index);
}
