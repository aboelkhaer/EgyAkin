import '../../exports.dart';

class PostDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailsController>(() => PostDetailsController());
  }
}
