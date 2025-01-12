import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/show_single_feed/data/models/create_reply_on_comment_in_community_model_response.dart';
import '../../../../exports.dart';

class CreateReplyOnCommentInCommunityUsecase
    implements
        BaseUseCase<CreateReplyOnCommentInCommunityUsecaseInput,
            CreateReplyOnCommentInCommunityModelResponse> {
  final ShowSingleFeedRepository repository;

  CreateReplyOnCommentInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, CreateReplyOnCommentInCommunityModelResponse>> execute(
      CreateReplyOnCommentInCommunityUsecaseInput input) async {
    return await repository.createReplyOnCommentInCommunity(
      postId: input.postId,
      comment: input.comment,
      parentId: input.parentId,
    );
  }
}

class CreateReplyOnCommentInCommunityUsecaseInput {
  final String postId;
  final String comment;
  final int? parentId;

  CreateReplyOnCommentInCommunityUsecaseInput({
    required this.postId,
    required this.comment,
    this.parentId,
  });
}
