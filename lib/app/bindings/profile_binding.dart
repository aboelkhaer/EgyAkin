import '../../exports.dart';

class DoctorProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctroProfileController>(() => DoctroProfileController());
  }
}
