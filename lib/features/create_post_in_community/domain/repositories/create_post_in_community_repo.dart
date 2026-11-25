
import 'package:dio/dio.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class CreatePostInCommunityRepository {
  Future<Either<Failure, CreatePostInCommunityModelResponse>>
      createPostWithImageInCommunity({
    required List<MultipartFile> images,
    required String? postContent,
    required String mediaType,
    required String visibility,
    required String? groupId,
  });

  Future<Either<Failure, CreatePostInCommunityModelResponse>>
      createPostWithTextInCommunity({
    required String postContent,
    required String? mediaType,
    required String visibility,
    required String? groupId,
    required PollModel? pollModel,
  });
  Future<Either<Failure, EditPostInCommunityModelResponse>>
      editPostWithImageInCommunity({
    required List<MultipartFile> images,
    required String? postContent,
    required String mediaType,
    required String visibility,
    required String? groupId,
    required String postId,
    required List<String> existingMediaPath,
  });
  Future<Either<Failure, EditPostInCommunityModelResponse>>
      editPostWithTextInCommunity({
    required String postContent,
    required String? mediaType,
    required String visibility,
    required String? groupId,
    required String postId,
    required PollModel? pollModel,
  });
}
