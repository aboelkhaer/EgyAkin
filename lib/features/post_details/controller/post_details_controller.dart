import '../../../exports.dart';

class PostDetailsController extends GetxController {
  PostDetailsRepository postsRepository = Get.find<PostDetailsRepository>();
  HomeController homeController = Get.find<HomeController>();
  ScrollController scrollController = ScrollController();

  RxString newComment = ''.obs;

  RxList<BaseCommentModel>? postCommentsList = <BaseCommentModel>[].obs;

  RxBool isCommentsLoading = false.obs;

  getPostComments(String postId) async {
    isCommentsLoading(true);
    List<BaseCommentModel>? containList = await postsRepository.getPostComments(
      postId: postId,
      // isCommentsLoading: isCommentsLoading,
    );

    postCommentsList!.value = containList!;

    isCommentsLoading(false);
    update();
  }

  deletePostComment({required String commentId}) async {
    isCommentsLoading(true);

    await postsRepository.deletePostComment(
      // isCommentsLoading: isCommentsLoading,
      commentId: commentId,
    );

    isCommentsLoading(false);
    update();
  }

  addCommentOnPost({
    required String postId,
  }) async {
    isCommentsLoading(true);

    await postsRepository.addCommentOnPost(
      // isCommentsLoading: isCommentsLoading,
      postId: postId,
      content: newComment.value,
    );
    newComment.value = '';
    update();
    isCommentsLoading(false);
    Future.delayed(const Duration(milliseconds: 300)).then((_) async {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
        );
      });
    });
    update();
  }
}
