import 'package:dartz/dartz.dart';

import 'package:egy_akin/features/create_post_in_community/data/models/create_post_in_community_model_response.dart';
import '../../../../exports.dart';

class CreatePostWithTextInCommunityUsecase
    implements
        BaseUseCase<CreatePostWithTextInCommunityUsecaseInput,
            CreatePostInCommunityModelResponse> {
  final CreatePostInCommunityRepository repository;

  CreatePostWithTextInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, CreatePostInCommunityModelResponse>> execute(
    CreatePostWithTextInCommunityUsecaseInput input,
  ) async {
    return await repository.createPostWithTextInCommunity(
      postContent: input.postContent,
      mediaType: input.mediaType,
      visibility: input.visibility,
      groupId: input.groupId,
      pollModel: input.pollModel,
    );
  }
}

class CreatePostWithTextInCommunityUsecaseInput {
  final String postContent;
  final String? mediaType;
  final String visibility;
  final String? groupId;
  final PollModel? pollModel;

  CreatePostWithTextInCommunityUsecaseInput({
    required this.postContent,
    required this.mediaType,
    required this.visibility,
    required this.groupId,
    required this.pollModel,
  });
}
