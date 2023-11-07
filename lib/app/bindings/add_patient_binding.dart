import '../../exports.dart';

class AddPatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPatientController>(() => AddPatientController());
  }
}
