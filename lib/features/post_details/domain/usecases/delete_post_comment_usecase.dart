import 'package:dartz/dartz.dart';
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
