abstract class DistributorHomeEvent {}

class FabPressed extends DistributorHomeEvent {}

class NotificationClicked extends DistributorHomeEvent {}

class CreateClicked extends DistributorHomeEvent {}

class OptionMenuClicked extends DistributorHomeEvent {}

class ChangeTab extends DistributorHomeEvent {
  final int index;

  ChangeTab(this.index);
}
