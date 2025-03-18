import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/create_group_in_community/data/models/update_group_in_community_model_response.dart';
import 'package:egy_akin/features/create_group_in_community/domain/repositories/create_group_in_community_repo.dart';
import '../../../../exports.dart';

class UpdateGroupImageInCommunityUsecase
    implements
        BaseUseCase<UpdateGroupImageInCommunityUsecaseInput,
            UpdateGroupInCommunityModelResponse> {
  final CreateGroupInCommunityRepository repository;

  UpdateGroupImageInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, UpdateGroupInCommunityModelResponse>> execute(
    UpdateGroupImageInCommunityUsecaseInput input,
  ) async {
    return await repository.updateGroupImageInCommunity(
      input.groupId,
      input.groupImage,
      input.name,
      input.description,
      input.privacy,
    );
  }
}

class UpdateGroupImageInCommunityUsecaseInput {
  final String groupId;

  final File? groupImage;
  final String name;
  final String? description;
  final String privacy;

  UpdateGroupImageInCommunityUsecaseInput({
    required this.groupImage,
    required this.name,
    required this.description,
    required this.privacy,
    required this.groupId,
  });
}
