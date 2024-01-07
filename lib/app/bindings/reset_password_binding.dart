import '../../exports.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
