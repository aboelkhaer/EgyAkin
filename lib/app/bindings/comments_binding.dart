import '../../exports.dart';

class CommentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentsController>(() => CommentsController());
  }
}
