import 'dart:io';

import 'package:egy_akin/features/community/data/models/add_like_on_post_model_response.dart';
import 'package:egy_akin/features/community/data/models/delete_post_model_response.dart';
import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';
import 'package:egy_akin/features/community/data/models/join_group_model_response.dart';
import 'package:egy_akin/features/community/data/models/save_or_unsave_post_model_response.dart';
import 'package:egy_akin/features/create_group_in_community/data/models/create_group_in_community_model_response.dart';

import '../../../../exports.dart';

abstract class CreateGroupInCommunityDatasource {
  Future<CreateGroupInCommunityModelResponse> createGroupInCommunity(
    File? headerImage,
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
}
