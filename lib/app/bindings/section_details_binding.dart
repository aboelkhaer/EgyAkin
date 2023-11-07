import 'package:egyakin/features/section_details/controller/section_details_controller.dart';

import '../../exports.dart';

class SectionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SectionDetailsController>(() => SectionDetailsController());
  }
}
