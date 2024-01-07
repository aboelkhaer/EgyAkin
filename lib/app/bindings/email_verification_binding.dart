import 'package:EgyAkin/features/email_verification/controller/email_verification_controller.dart';

import '../../exports.dart';

class EmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailVerificationController>(
        () => EmailVerificationController());
  }
}
