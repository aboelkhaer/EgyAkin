import 'dart:io';
import 'package:egy_akin/features/create_post_in_community/data/models/create_post_in_community_model_response.dart';

import '../../../../exports.dart';

abstract class CreatePostInCommunityDatasource {
  Future<CreatePostInCommunityModelResponse> createPostWithImageInCommunity({
    required File image,
    required String? postContent,
    required String mediaType,
    required String visibility,
    required String? groupId,
  });
  Future<CreatePostInCommunityModelResponse> createPostWithTextInCommunity({
    required String postContent,
    required String mediaType,
    required String visibility,
    required String? groupId,
  });
}

class CreatePostInCommunityDatasourceImpl
    implements CreatePostInCommunityDatasource {
  final ApiServices _apiServices;

  CreatePostInCommunityDatasourceImpl(this._apiServices);

  @override
  Future<CreatePostInCommunityModelResponse> createPostWithImageInCommunity(
      {required File image,
      required String? postContent,
      required String mediaType,
      required String visibility,
      required String? groupId}) async {
    return await _apiServices.createPostWithImageInCommunity(
      postContent,
      mediaType,
      visibility,
      groupId,
      image,
    );
  }

  @override
  Future<CreatePostInCommunityModelResponse> createPostWithTextInCommunity(
      {required String postContent,
      required String mediaType,
      required String visibility,
      required String? groupId}) async {
    return await _apiServices.createPostWithTextInCommunity(
        postContent, mediaType, visibility, groupId);
  }
}
