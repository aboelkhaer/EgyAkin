import '../../exports.dart';
import '../../features/doctor_profile/controller/doctor_profile_controller.dart';

class DoctorProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctroProfileController>(() => DoctroProfileController());
  }
}
