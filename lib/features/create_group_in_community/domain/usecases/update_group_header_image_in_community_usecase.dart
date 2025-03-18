import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/create_group_in_community/data/models/update_group_in_community_model_response.dart';
import 'package:egy_akin/features/create_group_in_community/domain/repositories/create_group_in_community_repo.dart';
import '../../../../exports.dart';

class UpdateGroupHeaderImageInCommunityUsecase
    implements
        BaseUseCase<UpdateGroupHeaderImageInCommunityUsecaseInput,
            UpdateGroupInCommunityModelResponse> {
  final CreateGroupInCommunityRepository repository;

  UpdateGroupHeaderImageInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, UpdateGroupInCommunityModelResponse>> execute(
    UpdateGroupHeaderImageInCommunityUsecaseInput input,
  ) async {
    return await repository.updateGroupHeaderImageInCommunity(
      input.groupId,
      input.headerImage,
      input.name,
      input.description,
      input.privacy,
    );
  }
}

class UpdateGroupHeaderImageInCommunityUsecaseInput {
  final String groupId;
  final File? headerImage;

  final String name;
  final String? description;
  final String privacy;

  UpdateGroupHeaderImageInCommunityUsecaseInput({
    required this.headerImage,
    required this.name,
    required this.description,
    required this.privacy,
    required this.groupId,
  });
}
