import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:egy_akin/features/create_post_in_community/data/models/create_post_in_community_model_response.dart';
import 'package:egy_akin/features/create_post_in_community/domain/repositories/create_post_in_community_repo.dart';
import '../../../../exports.dart';

class CreatePostWithImageInCommunityUsecase
    implements
        BaseUseCase<CreatePostWithImageInCommunityUsecaseInput,
            CreatePostInCommunityModelResponse> {
  final CreatePostInCommunityRepository repository;

  CreatePostWithImageInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, CreatePostInCommunityModelResponse>> execute(
    CreatePostWithImageInCommunityUsecaseInput input,
  ) async {
    return await repository.createPostWithImageInCommunity(
      image: input.image,
      postContent: input.postContent,
      mediaType: input.mediaType,
      visibility: input.visibility,
      groupId: input.groupId,
    );
  }
}

class CreatePostWithImageInCommunityUsecaseInput {
  final String? postContent;
  final File image;
  final String mediaType;
  final String visibility;
  final String? groupId;

  CreatePostWithImageInCommunityUsecaseInput(
      {required this.postContent,
      required this.image,
      required this.mediaType,
      required this.visibility,
      required this.groupId});
}
