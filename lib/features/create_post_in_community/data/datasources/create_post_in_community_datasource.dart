import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:egy_akin/features/create_post_in_community/data/models/create_post_in_community_model_response.dart';
import 'package:egy_akin/features/create_post_in_community/data/models/edit_post_in_community_model_response.dart';

import '../../../../exports.dart';

abstract class CreatePostInCommunityDatasource {
  Future<CreatePostInCommunityModelResponse> createPostWithImageInCommunity({
    required List<MultipartFile> images,
    required String? postContent,
    required String mediaType,
    required String visibility,
    required String? groupId,
  });
  Future<CreatePostInCommunityModelResponse> createPostWithTextInCommunity({
    required String postContent,
    required String? mediaType,
    required String visibility,
    required String? groupId,
    required PollModel? pollModel,
  });
  Future<EditPostInCommunityModelResponse> editPostWithImageInCommunity({
    required List<MultipartFile> images,
    required String? postContent,
    required String mediaType,
    required String visibility,
    required String? groupId,
    required String postId,
    required List<String> existingMediaPath,
  });
  Future<EditPostInCommunityModelResponse> editPostWithTextInCommunity({
    required String postContent,
    required String? mediaType,
    required String visibility,
    required String? groupId,
    required String postId,
    required PollModel? pollModel,
  });
}

class CreatePostInCommunityDatasourceImpl
    implements CreatePostInCommunityDatasource {
  final ApiServices _apiServices;

  CreatePostInCommunityDatasourceImpl(this._apiServices);

  @override
  Future<CreatePostInCommunityModelResponse> createPostWithImageInCommunity(
      {required List<MultipartFile> images,
      required String? postContent,
      required String mediaType,
      required String visibility,
      required String? groupId}) async {
    return await _apiServices.createPostWithImageInCommunity(
      postContent,
      mediaType,
      visibility,
      groupId,
      images,
    );
  }

  @override
  Future<CreatePostInCommunityModelResponse> createPostWithTextInCommunity({
    required String postContent,
    required String? mediaType,
    required String visibility,
    required String? groupId,
    required PollModel? pollModel,
  }) async {
    return await _apiServices.createPostWithTextInCommunity(
      postContent,
      null,
      visibility,
      groupId,
      pollModel?.toJson(),
    );
  }

  @override
  Future<EditPostInCommunityModelResponse> editPostWithTextInCommunity({
    required String postContent,
    required String? mediaType,
    required String visibility,
    required String? groupId,
    required String postId,
    required PollModel? pollModel,
  }) async {
    log(mediaType.toString());
    return await _apiServices.editPostWithTextInCommunity(
      postId,
      postContent,
      mediaType,
      visibility,
      groupId,
      pollModel?.toJson(),
    );
  }

  @override
  Future<EditPostInCommunityModelResponse> editPostWithImageInCommunity(
      {required List<MultipartFile> images,
      required String? postContent,
      required String mediaType,
      required String visibility,
      required String? groupId,
      required String postId,
      required List<String> existingMediaPath}) async {
    return await _apiServices.editPostWithImageInCommunity(
      postId,
      postContent,
      mediaType,
      visibility,
      groupId,
      images,
      existingMediaPath,
    );
  }
}
