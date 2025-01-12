import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/create_post_in_community/data/models/edit_post_in_community_model_response.dart';
import '../../../../exports.dart';

class EditPostWithTextInCommunityUsecase
    implements
        BaseUseCase<EditPostWithTextInCommunityUsecaseInput,
            EditPostInCommunityModelResponse> {
  final CreatePostInCommunityRepository repository;

  EditPostWithTextInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, EditPostInCommunityModelResponse>> execute(
    EditPostWithTextInCommunityUsecaseInput input,
  ) async {
    return await repository.editPostWithTextInCommunity(
      postContent: input.postContent,
      mediaType: input.mediaType,
      visibility: input.visibility,
      groupId: input.groupId,
      postId: input.postId,
    );
  }
}

class EditPostWithTextInCommunityUsecaseInput {
  final String postId;
  final String postContent;
  final String mediaType;
  final String visibility;
  final String? groupId;

  EditPostWithTextInCommunityUsecaseInput({
    required this.postContent,
    required this.mediaType,
    required this.visibility,
    required this.groupId,
    required this.postId,
  });
}
