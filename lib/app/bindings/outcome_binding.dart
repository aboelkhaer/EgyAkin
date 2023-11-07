import 'package:egyakin/features/outcome/controller/outcome_controller.dart';

import '../../exports.dart';

class OutcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutcomeController>(() => OutcomeController());
  }
}
