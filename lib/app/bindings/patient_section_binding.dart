import '../../exports.dart';
import '../../features/patient_details/controller/patient_section_controller.dart';

class PatientSectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientSectionController>(() => PatientSectionController());
  }
}
