import 'package:oogie/constants/home_status.dart';

class DistributorHomeState {
  int notificationCount;
  int tabIndex;
  final HomeStatus homeStatus;

  DistributorHomeState({
    this.notificationCount = 0,
    this.tabIndex = 0,
    this.homeStatus = const InitialStatus(index: 0),
  });

  DistributorHomeState copyWith({
    int notificationCount,
    int tabIndex,
    HomeStatus homeStatus,
  }) {
    return DistributorHomeState(
      notificationCount: notificationCount ?? this.notificationCount,
      tabIndex: tabIndex ?? this.tabIndex,
      homeStatus: homeStatus ?? this.homeStatus,
    );
  }
}
