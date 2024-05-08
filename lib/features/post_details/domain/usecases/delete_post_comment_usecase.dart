import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/post_details/data/models/delete_post_comment_model_response.dart';
import '../../../../exports.dart';

class DeletePostCommentUsecase
    implements BaseUseCase<String, DeletePostCommentModelResponse> {
  final PostDetailsRepository repository;

  DeletePostCommentUsecase(this.repository);

  @override
  Future<Either<Failure, DeletePostCommentModelResponse>> excute(
      String commentId) async {
    return await repository.deletePostComment(commentId);
  }
}
