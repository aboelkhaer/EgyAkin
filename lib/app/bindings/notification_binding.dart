import '../../features/notification/view/notification_screen.dart';

import '../../exports.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationScreen>(() => const NotificationScreen());
  }
}
