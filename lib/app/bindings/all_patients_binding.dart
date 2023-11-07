import '../../exports.dart';

class AllPatientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllPatientsController>(() => AllPatientsController());
  }
}
