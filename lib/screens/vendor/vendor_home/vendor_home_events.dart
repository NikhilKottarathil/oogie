abstract class VendorHomeEvent {}

class FabPressed extends VendorHomeEvent {}

class NotificationClicked extends VendorHomeEvent {}

class CreateClicked extends VendorHomeEvent {}

class OptionMenuClicked extends VendorHomeEvent {}

class ChangeTab extends VendorHomeEvent {
  final int index;

  ChangeTab(this.index);
}
