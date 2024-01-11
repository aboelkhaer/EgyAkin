import '../../exports.dart';

class SectionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SectionDetailsController>(() => SectionDetailsController());
  }
}
