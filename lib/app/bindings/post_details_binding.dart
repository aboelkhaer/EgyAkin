import '../../features/post_details/controller/post_details_controller.dart';

import '../../exports.dart';

class PostDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailsController>(() => PostDetailsController());
  }
}
