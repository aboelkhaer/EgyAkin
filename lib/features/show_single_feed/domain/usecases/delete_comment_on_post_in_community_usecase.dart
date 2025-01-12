import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/show_single_feed/data/models/delete_comment_on_post_in_community_model_response.dart';

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
