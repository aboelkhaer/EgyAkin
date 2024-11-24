import 'package:dartz/dartz.dart';
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
