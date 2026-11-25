import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

class AddLikeOrUnlikeOnCommentInCommunityUsecase
    implements
        BaseUseCase<AddLikeOrUnlikeOnCommentInCommunityUsecaseInput,
            AddLikeOrUnlikeOnCommentInCommunityModelResponse> {
  final ShowSingleFeedRepository repository;

  AddLikeOrUnlikeOnCommentInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, AddLikeOrUnlikeOnCommentInCommunityModelResponse>>
      execute(AddLikeOrUnlikeOnCommentInCommunityUsecaseInput input) async {
    return await repository.addLikeOrUnlikeOnCommentInCommunity(
        commentId: input.commentId, status: input.status);
  }
}

class AddLikeOrUnlikeOnCommentInCommunityUsecaseInput {
  final String commentId;
  final String status;

  AddLikeOrUnlikeOnCommentInCommunityUsecaseInput(
      {required this.commentId, required this.status});
}
