import 'package:dio/dio.dart';

import '../../../exports.dart';
import 'comments_controller.dart';

class CommentRepository {
  ApiServices apiServices;
  CommentRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

  Future<List<BaseCommentModel>>? getComments(
      {required String patientId, required RxBool isCommentsLoading}) async {
    if (!Get.isSnackbarOpen) {
      isCommentsLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.getComments(patientId);
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
          isCommentsLoading.value = false;
          if (e is DioException) {
            // final result = e.response!.data as Map<String, dynamic>;
            // customSnackBar(
            //   isError: true,
            //   title: AppStrings.error,
            //   body: result['message'],
            // );

            DioExceptions.fromDioError(
                dioError: e, errorFrom: 'comment_repo/getComments');
          }
        }
      } else {
        isCommentsLoading.value = false;
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

  addComment({
    required RxBool isCommentsLoading,
    required String patientId,
    required String content,
  }) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.addComment(patientId, content);
          if (response.value == true) {
            Future.delayed(const Duration(milliseconds: 100)).then((_) async {
              // apiServices.getComments(patientId);
              try {
                var response = await apiServices.getComments(patientId);
                if (response.value == true) {
                  // isCommentsLoading.value = false;
                  if (response.baseCommentModel != null) {
                    Get.find<CommentsController>().commentsList!.value =
                        response.baseCommentModel!;
                  }
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
                      dioError: e,
                      errorFrom: 'comment_repo/getComments in addComment');
                }
              }
            });
            isCommentsLoading.value = false;
            customSnackBar(
              isError: false,
              title: 'Successfully',
              body: response.message,
            );

            // showCustomDialog(
            //     context: context,
            //     title: 'Successfully',
            //     description:
            //         '${response.message}\nYour updates:\n${map.toString()}',
            //     noColoredBottonOnTap: () {},
            //     coloredBottonText: 'Cancel',
            //     noColoredBottonText: '',
            //     isNoColorShow: false,
            //     coloredBottonOnTap: () => Get.back());
          } else {
            isCommentsLoading.value = false;
            customSnackBar(
              isError: true,
              title: 'Error!',
              body: 'Something went wrong.',
            );
          }
        } catch (e) {
          isCommentsLoading.value = false;
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
        isCommentsLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
      }
    }
  }

  deleteComment({
    required RxBool isCommentsLoading,
    required String commentId,
    required String patientId,
  }) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.deleteComment(commentId);
          if (response.value == true) {
            Get.find<CommentsController>()
                .commentsList!
                .removeWhere((comment) => comment.id.toString() == commentId);

            // Future.delayed(const Duration(milliseconds: 1)).then((_) async {
            //   try {
            //     var response = await apiServices.getComments(patientId);
            //     if (response.value == true) {
            //       if (response.baseCommentModel != null) {
            //         Get.find<CommentsController>().commentsList!.value =
            //             response.baseCommentModel!;
            //         isCommentsLoading(false);
            //       }
            //     }
            //   } catch (e) {
            //     if (e is DioException) {
            //       // final result = e.response!.data as Map<String, dynamic>;
            //       // customSnackBar(
            //       //   isError: true,
            //       //   title: AppStrings.error,
            //       //   body: result['message'],
            //       // );

            //       DioExceptions.fromDioError(
            //           dioError: e,
            //           errorFrom: 'comment_repo/getComments in deleteComment');
            //     }
            //   }
            // });
            isCommentsLoading.value = false;
            customSnackBar(
              isError: false,
              title: 'Successfully',
              body: response.message,
            );

            // showCustomDialog(
            //     context: context,
            //     title: 'Successfully',
            //     description:
            //         '${response.message}\nYour updates:\n${map.toString()}',
            //     noColoredBottonOnTap: () {},
            //     coloredBottonText: 'Cancel',
            //     noColoredBottonText: '',
            //     isNoColorShow: false,
            //     coloredBottonOnTap: () => Get.back());
          } else {
            isCommentsLoading.value = false;
            customSnackBar(
              isError: true,
              title: 'Error!',
              body: 'Something went wrong.',
            );
          }
        } catch (e) {
          isCommentsLoading.value = false;
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
        isCommentsLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
      }
    }
  }
  // deleteComment(String commentId)async{
  //    var response = await apiServices.deleteComment(commentId);

  // }
}
