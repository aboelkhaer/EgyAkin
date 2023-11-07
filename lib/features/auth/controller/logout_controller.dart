import '../../../exports.dart';

class LogoutController extends GetxController {
  AuthRepository authRepository = Get.find<AuthRepository>();
  HomeController homeController = Get.find<HomeController>();
  RxBool isSignOutLoading = false.obs;

  logout() async {
    isSignOutLoading.value = true;
    await authRepository.logout(isSignOutLoading: isSignOutLoading);
    isSignOutLoading.value = false;
  }
}
