import 'dart:developer';

import '../../../exports.dart';

class SplashController extends GetxController {
  _startDelay() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // Timer(const Duration(seconds: AppStrings.splashDelay), _goNext);

    // timer = Timer.periodic(const Duration(seconds: AppStrings.splashDelay),
    //     (Timer t) {
    //   _goNext();

    // });

    // });
  }

  var networkInfo = Get.find<NetworkInfoImpl>();

  // getToken() async {
  //   if (token == null) {
  //     return token = '';
  //   } else {
  //     return token = await getStorageLib.getString(AppLocalStrings.keyToken);
  //   }
  // }

  Future tesst() async {
    var net = await networkInfo.isConnected;
    log(net.toString());
  }

  @override
  void onInit() {
    // _startDelay();

    super.onInit();
  }

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
  }
  // initDio() async {
  //   dio = await DioFactory().getDio();
  // }
}
