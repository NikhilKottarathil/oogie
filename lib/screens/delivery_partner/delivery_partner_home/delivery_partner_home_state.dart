import 'package:oogie/constants/home_status.dart';

class DeliveryPartnerHomeState {
  int notificationCount;
  int tabIndex;
  final HomeStatus homeStatus;

  DeliveryPartnerHomeState({
    this.notificationCount = 0,
    this.tabIndex = 0,
    this.homeStatus = const InitialStatus(index: 0),
  });

  DeliveryPartnerHomeState copyWith({
    int notificationCount,
    int tabIndex,
    HomeStatus homeStatus,
  }) {
    return DeliveryPartnerHomeState(
      notificationCount: notificationCount ?? this.notificationCount,
      tabIndex: tabIndex ?? this.tabIndex,
      homeStatus: homeStatus ?? this.homeStatus,
    );
  }
}
