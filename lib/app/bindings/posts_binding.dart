import 'package:egyakin/features/posts/controller/posts_controller.dart';

import '../../exports.dart';

class PostsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostsController>(() => PostsController());
  }
}
