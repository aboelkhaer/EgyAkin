import '../../exports.dart';
import '../../features/all_patients/controller/all_patients_controller.dart';

class AllPatientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllPatientsController>(() => AllPatientsController());
  }
}
