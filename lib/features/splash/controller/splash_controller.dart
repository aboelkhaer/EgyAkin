import 'dart:developer';

import '../../../exports.dart';

class SplashController extends GetxController {
  _startDelay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: AppStrings.splashDelay), _goNext);
    });
  }

  _goNext() async {
    log('init dio');

    // await initDio();

    Get.offNamed(
      AppRoutes.welcome,
    );
  }

  @override
  void onInit() {
    _startDelay();

    super.onInit();
  }

  // initDio() async {
  //   dio = await DioFactory().getDio();
  // }
}
