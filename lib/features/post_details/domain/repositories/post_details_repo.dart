import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/post_details/data/models/delete_post_comment_model_response.dart';
import '../../../../exports.dart';

abstract class PostDetailsRepository {
  Future<Either<Failure, PostCommentsModelResponse>> getPostComments(
      String postId);
  Future<Either<Failure, DeletePostCommentModelResponse>> deletePostComment(
      String commentId);
  Future<Either<Failure, AddCommentOnPostModelResponse>> addCommentOnPost(
    String postId,
    String content,
  );
}
