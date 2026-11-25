import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

class DeleteCommentOnPostInCommunityUsecase
    implements
        BaseUseCase<String, DeleteCommentOnPostInCommunityModelResponse> {
  final ShowSingleFeedRepository repository;

  DeleteCommentOnPostInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, DeleteCommentOnPostInCommunityModelResponse>> execute(
      String commentId) async {
    return await repository.deleteCommentOnPostInCommunity(
        commentId: commentId);
  }
}
