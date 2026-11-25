import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

class CreateCommentOnPostInCommunityUsecase
    implements
        BaseUseCase<CreateCommentOnPostInCommunityUsecaseInput,
            CreateCommentOnPostInCommunityModelResponse> {
  final ShowSingleFeedRepository repository;

  CreateCommentOnPostInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, CreateCommentOnPostInCommunityModelResponse>> execute(
      CreateCommentOnPostInCommunityUsecaseInput input) async {
    return await repository.createCommentOnPostInCommunity(
      postId: input.postId,
      comment: input.comment,
      parentId: input.parentId,
    );
  }
}

class CreateCommentOnPostInCommunityUsecaseInput {
  final String postId;
  final String comment;
  final int? parentId;

  CreateCommentOnPostInCommunityUsecaseInput({
    required this.postId,
    required this.comment,
    this.parentId,
  });
}
