import '../../exports.dart';

class CurrentPatientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurrentPatientsController>(() => CurrentPatientsController());
  }
}
