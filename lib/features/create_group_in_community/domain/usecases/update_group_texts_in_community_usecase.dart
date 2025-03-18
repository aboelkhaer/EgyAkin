import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/create_group_in_community/data/models/update_group_in_community_model_response.dart';
import 'package:egy_akin/features/create_group_in_community/domain/repositories/create_group_in_community_repo.dart';
import '../../../../exports.dart';

class UpdateGroupTextsInCommunityUsecase
    implements
        BaseUseCase<UpdateGroupTextsInCommunityUsecaseInput,
            UpdateGroupInCommunityModelResponse> {
  final CreateGroupInCommunityRepository repository;

  UpdateGroupTextsInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, UpdateGroupInCommunityModelResponse>> execute(
    UpdateGroupTextsInCommunityUsecaseInput input,
  ) async {
    return await repository.updateGroupTextsInCommunity(
      input.groupId,
      input.name,
      input.description,
      input.privacy,
    );
  }
}

class UpdateGroupTextsInCommunityUsecaseInput {
  final String groupId;

  final String name;
  final String? description;
  final String privacy;

  UpdateGroupTextsInCommunityUsecaseInput({
    required this.groupId,
    required this.name,
    required this.description,
    required this.privacy,
  });
}
