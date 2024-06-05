import 'package:egy_akin/features/post_details/data/models/delete_post_comment_model_response.dart';

import '../../../../exports.dart';

abstract class PostDetailsDataSource {
  Future<PostCommentsModelResponse> getPostComments(String postId);
  Future<DeletePostCommentModelResponse> deletePostComment(String commentId);
  Future<AddCommentOnPostModelResponse> addCommentOnPost(
      String postId, String content);
}

class PostDetailsDataSourceImpl implements PostDetailsDataSource {
  final ApiServices _apiServices;

  PostDetailsDataSourceImpl(this._apiServices);

  @override
  Future<PostCommentsModelResponse> getPostComments(String postId) async {
    return await _apiServices.getPostComments(postId);
  }

  @override
  Future<DeletePostCommentModelResponse> deletePostComment(
      String commentId) async {
    return await _apiServices.deletePostComment(commentId);
  }

  @override
  Future<AddCommentOnPostModelResponse> addCommentOnPost(
      String postId, String content) async {
    return await _apiServices.addCommentOnPost(postId, content);
  }
}
