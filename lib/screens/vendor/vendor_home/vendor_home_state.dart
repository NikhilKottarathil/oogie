import 'package:oogie/constants/home_status.dart';

class VendorHomeState {
  int notificationCount;
  int tabIndex;
  final HomeStatus homeStatus;

  VendorHomeState({
    this.notificationCount = 0,
    this.tabIndex = 0,
    this.homeStatus = const InitialStatus(index: 0),
  });

  VendorHomeState copyWith({
    int notificationCount,
    int tabIndex,
    HomeStatus homeStatus,
  }) {
    return VendorHomeState(
      notificationCount: notificationCount ?? this.notificationCount,
      tabIndex: tabIndex ?? this.tabIndex,
      homeStatus: homeStatus ?? this.homeStatus,
    );
  }
}
