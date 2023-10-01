import '../../../exports.dart';

class LogoutController extends GetxController {
  AuthRepository authRepository = Get.find<AuthRepository>();
  RxBool isSignOutLoading = false.obs;

  logout() async {
    isSignOutLoading.value = true;
    await authRepository.logout(isSignOutLoading: isSignOutLoading);
    isSignOutLoading.value = false;
  }
}
