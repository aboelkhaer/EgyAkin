import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/show_single_feed/data/models/add_like_or_unlike_on_comment_in_community_model_response.dart';

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
