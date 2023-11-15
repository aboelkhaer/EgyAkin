import 'package:dio/dio.dart';

import '../../../exports.dart';
import 'post_details_controller.dart';

class PostDetailsRepository {
  ApiServices apiServices;
  PostDetailsRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

  Future<List<BaseCommentModel>>? getPostComments({
    required String postId,
    // required RxBool isCommentsLoading,
  }) async {
    if (!Get.isSnackbarOpen) {
      // isCommentsLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.getHomePostComments(postId);
          if (response.value == true) {
            //  isCommentsLoading.value = false;

            if (response.baseCommentModel != null) {
              return response.baseCommentModel!;
            }
            return [];
          } else {
            // isCommentsLoading.value = false;
            return [];
          }
        } catch (e) {
          // isCommentsLoading.value = false;
          if (e is DioException) {
            // final result = e.response!.data as Map<String, dynamic>;
            // customSnackBar(
            //   isError: true,
            //   title: AppStrings.error,
            //   body: result['message'],
            // );

            DioExceptions.fromDioError(
                dioError: e, errorFrom: 'post_details_repo/getPostComments');
          }
        }
      } else {
        // isCommentsLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
      }
      return [];
    } else {
      return [];
    }
  }

  deletePostComment({
    // required RxBool isCommentsLoading,
    required String commentId,
  }) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.deletePostComment(commentId);
          if (response.value == true) {
            Get.find<PostDetailsController>()
                .postCommentsList!
                .removeWhere((comment) => comment.id.toString() == commentId);

            // isCommentsLoading.value = false;
            customSnackBar(
              isError: false,
              title: 'Successfully',
              body: response.message,
            );
          } else {
            // isCommentsLoading.value = false;
            customSnackBar(
              isError: true,
              title: 'Error!',
              body: 'Something went wrong.',
            );
          }
        } catch (e) {
          // isCommentsLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result['message'],
            );

            DioExceptions.fromDioError(
                dioError: e, errorFrom: 'comment_repo/deleteComment');
          }
        }
      } else {
        // isCommentsLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
      }
    }
  }

  addCommentOnPost({
    // required RxBool isCommentsLoading,
    required String postId,
    required String content,
    // required Future<dynamic> getCommentsFunction,
  }) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.addCommentOnPost(postId, content);
          if (response.value == true) {
            Future.delayed(const Duration(milliseconds: 300)).then((_) async {
              try {
                var response = await apiServices.getHomePostComments(postId);
                if (response.value == true) {
                  if (response.baseCommentModel != null) {
                    Get.find<PostDetailsController>().postCommentsList!.value =
                        response.baseCommentModel!;
                  }
                }
              } catch (e) {
                if (e is DioException) {
                  DioExceptions.fromDioError(
                      dioError: e,
                      errorFrom:
                          'post_details_repo/getCommentsOnPost in addCommentOnPost');
                }
              }
              // getCommentsFunction;
            });
            // isCommentsLoading.value = false;
          } else {
            // isCommentsLoading.value = false;
            customSnackBar(
              isError: true,
              title: 'Error!',
              body: 'Something went wrong.',
            );
          }
        } catch (e) {
          // isCommentsLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result['message'],
            );

            DioExceptions.fromDioError(
                dioError: e, errorFrom: 'comment_repo/addComment');
          }
        }
      } else {
        // isCommentsLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
      }
    }
  }
}
