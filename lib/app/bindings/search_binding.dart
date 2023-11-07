import '../../exports.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchHomeController>(() => SearchHomeController());
  }
}
