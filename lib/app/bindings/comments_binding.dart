import 'package:egyakin/features/comments/controller/comments_controller.dart';

import '../../exports.dart';

class CommentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentsController>(() => CommentsController());
  }
}
