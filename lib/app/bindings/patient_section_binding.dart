import '../../exports.dart';

class PatientSectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientSectionController>(() => PatientSectionController());
  }
}
