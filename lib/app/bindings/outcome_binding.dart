import '../../exports.dart';

class OutcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutcomeController>(() => OutcomeController());
  }
}
