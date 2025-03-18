import 'dart:io';
import 'package:egy_akin/features/create_group_in_community/data/models/create_group_in_community_model_response.dart';
import 'package:egy_akin/features/create_group_in_community/data/models/update_group_in_community_model_response.dart';

import '../../../../exports.dart';

abstract class CreateGroupInCommunityDatasource {
  Future<CreateGroupInCommunityModelResponse> createGroupInCommunity(
    File? headerImage,
    File? groupImage,
    String name,
    String? description,
    String privacy,
  );
  Future<UpdateGroupInCommunityModelResponse> updateGroupTextsInCommunity(
    String groupId,
    String name,
    String? description,
    String privacy,
  );
  Future<UpdateGroupInCommunityModelResponse> updateGroupHeaderImageInCommunity(
    String groupId,
    File? headerImage,
    String name,
    String? description,
    String privacy,
  );
  Future<UpdateGroupInCommunityModelResponse> updateGroupImageInCommunity(
    String groupId,
    File? groupImage,
    String name,
    String? description,
    String privacy,
  );
}

class CreateGroupInCommunityDatasourceImpl
    implements CreateGroupInCommunityDatasource {
  final ApiServices _apiServices;

  CreateGroupInCommunityDatasourceImpl(this._apiServices);

  @override
  Future<CreateGroupInCommunityModelResponse> createGroupInCommunity(
      File? headerImage,
      File? groupImage,
      String name,
      String? description,
      String privacy) async {
    return await _apiServices.createGroupInCommunity(
      name,
      headerImage!,
      groupImage!,
      description!,
      privacy,
    );
  }

  @override
  Future<UpdateGroupInCommunityModelResponse> updateGroupHeaderImageInCommunity(
      String groupId,
      File? headerImage,
      String name,
      String? description,
      String privacy) async {
    return await _apiServices.updateGroupHeaderImageInCommunity(
        groupId, name, headerImage!, description!, privacy);
  }

  @override
  Future<UpdateGroupInCommunityModelResponse> updateGroupImageInCommunity(
      String groupId,
      File? groupImage,
      String name,
      String? description,
      String privacy) async {
    return await _apiServices.updateGroupImageInCommunity(
        groupId, name, groupImage!, description!, privacy);
  }

  @override
  Future<UpdateGroupInCommunityModelResponse> updateGroupTextsInCommunity(
      String groupId, String name, String? description, String privacy) async {
    return await _apiServices.updateGroupTextsInCommunity(
        groupId, name, description!, privacy);
  }
}
