import '../../../exports.dart';

class CommentsController extends GetxController {
  CommentRepository commentRepository = Get.find<CommentRepository>();
  HomeController homeController = Get.find<HomeController>();

  RxString newComment = ''.obs;

  RxList<BaseCommentModel>? commentsList = RxList();

  RxBool isCommentsLoading = false.obs;

  getComments(String patientId) async {
    isCommentsLoading(true);
    List<BaseCommentModel>? containList = await commentRepository.getComments(
      patientId: patientId,
      isCommentsLoading: isCommentsLoading,
    );

    commentsList!.value = containList!;

    isCommentsLoading(false);
    update();
  }

  addComment({
    required String patientId,
  }) async {
    isCommentsLoading(true);

    await commentRepository.addComment(
        isCommentsLoading: isCommentsLoading,
        patientId: patientId,
        content: newComment.value);

    isCommentsLoading(false);
    update();
  }

  deleteComment({required String commentId, required String patientId}) async {
    isCommentsLoading(true);

    await commentRepository.deleteComment(
        isCommentsLoading: isCommentsLoading,
        commentId: commentId,
        patientId: patientId);

    isCommentsLoading(false);
    update();
  }
}
