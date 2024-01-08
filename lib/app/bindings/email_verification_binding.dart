import '../../exports.dart';
import '../../features/email_verification/controller/email_verification_controller.dart';

class EmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailVerificationController>(
        () => EmailVerificationController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<DoctroProfileController>(() => DoctroProfileController());
  }
}
