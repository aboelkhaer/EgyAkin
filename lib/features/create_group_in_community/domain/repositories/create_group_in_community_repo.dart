import 'dart:io';

import 'package:egy_akin/features/create_group_in_community/data/models/create_group_in_community_model_response.dart';

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
}
