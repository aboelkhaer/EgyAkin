import '../../exports.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationScreen>(() => const NotificationScreen());
    Get.lazyPut<PatientSectionController>(() => PatientSectionController());
    Get.lazyPut<OutcomeController>(() => OutcomeController());
    Get.lazyPut<CommentsController>(() => CommentsController());
  }
}
