abstract class UsedPhoneHomeEvent {}

class FabPressed extends UsedPhoneHomeEvent {}

class NotificationClicked extends UsedPhoneHomeEvent {}

class CreateClicked extends UsedPhoneHomeEvent {}

class OptionMenuClicked extends UsedPhoneHomeEvent {}

class ChangeTab extends UsedPhoneHomeEvent {
  final int index;

  ChangeTab(this.index);
}
