import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:egy_akin/features/create_post_in_community/data/models/edit_post_in_community_model_response.dart';
import '../../../../exports.dart';

class EditPostWithImageInCommunityUsecase
    implements
        BaseUseCase<EditPostWithImageInCommunityUsecaseInput,
            EditPostInCommunityModelResponse> {
  final CreatePostInCommunityRepository repository;

  EditPostWithImageInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, EditPostInCommunityModelResponse>> execute(
    EditPostWithImageInCommunityUsecaseInput input,
  ) async {
    return await repository.editPostWithImageInCommunity(
      postContent: input.postContent,
      mediaType: input.mediaType,
      visibility: input.visibility,
      groupId: input.groupId,
      postId: input.postId,
      images: input.images,
      existingMediaPath: input.existingMediaPath,
    );
  }
}

class EditPostWithImageInCommunityUsecaseInput {
  final String postId;
  final String? postContent;
  final List<MultipartFile> images;
  final String mediaType;
  final String visibility;
  final String? groupId;
  final List<String> existingMediaPath;

  EditPostWithImageInCommunityUsecaseInput({
    required this.postContent,
    required this.mediaType,
    required this.visibility,
    required this.groupId,
    required this.postId,
    required this.images,
    required this.existingMediaPath,
  });
}
