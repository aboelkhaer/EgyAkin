import 'package:egyakin/features/contact_us/controller/contact_us_controller.dart';

import '../../exports.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactUsController>(() => ContactUsController());
  }
}
