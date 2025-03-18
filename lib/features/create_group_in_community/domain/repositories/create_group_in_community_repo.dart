import 'dart:io';

import 'package:egy_akin/features/create_group_in_community/data/models/create_group_in_community_model_response.dart';
import 'package:egy_akin/features/create_group_in_community/data/models/update_group_in_community_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class CreateGroupInCommunityRepository {
  Future<Either<Failure, CreateGroupInCommunityModelResponse>>
      createGroupInCommunity(
    File? headerImage,
    File? groupImage,
    String name,
    String? description,
    String privacy,
  );
  Future<Either<Failure, UpdateGroupInCommunityModelResponse>>
      updateGroupTextsInCommunity(
    String groupId,
    String name,
    String? description,
    String privacy,
  );
  Future<Either<Failure, UpdateGroupInCommunityModelResponse>>
      updateGroupHeaderImageInCommunity(
    String groupId,
    File? headerImage,
    String name,
    String? description,
    String privacy,
  );
  Future<Either<Failure, UpdateGroupInCommunityModelResponse>>
      updateGroupImageInCommunity(
    String groupId,
    File? groupImage,
    String name,
    String? description,
    String privacy,
  );
}
