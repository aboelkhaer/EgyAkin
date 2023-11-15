import '../../../exports.dart';

class NotificationController extends GetxController {
  NotificationRepository notificationRepository =
      Get.find<NotificationRepository>();
  HomeController homeController = Get.find<HomeController>();
  PatientSectionController patientSectionController =
      Get.find<PatientSectionController>();

  RxBool isUpdateNotificationsLoading = false.obs;

  updateNotifications() async {
    isUpdateNotificationsLoading(true);

    await notificationRepository.updateNotification(
      isUpdateNotificationsLoading: isUpdateNotificationsLoading,
    );

    isUpdateNotificationsLoading(false);
    update();
  }
}
