import 'dart:io';

import 'package:egy_akin/features/create_post_in_community/data/models/create_post_in_community_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class CreatePostInCommunityRepository {
  Future<Either<Failure, CreatePostInCommunityModelResponse>>
      createPostWithImageInCommunity({
    required File image,
    required String? postContent,
    required String mediaType,
    required String visibility,
    required String? groupId,
  });
  Future<Either<Failure, CreatePostInCommunityModelResponse>>
      createPostWithTextInCommunity({
    required String postContent,
    required String mediaType,
    required String visibility,
    required String? groupId,
  });
}
