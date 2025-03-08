import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/create_group_in_community/data/models/create_group_in_community_model_response.dart';
import 'package:egy_akin/features/create_group_in_community/domain/repositories/create_group_in_community_repo.dart';
import '../../../../exports.dart';

class CreateGroupInCommunityUsecase
    implements
        BaseUseCase<CreateGroupInCommunityUsecaseInput,
            CreateGroupInCommunityModelResponse> {
  final CreateGroupInCommunityRepository repository;

  CreateGroupInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, CreateGroupInCommunityModelResponse>> execute(
    CreateGroupInCommunityUsecaseInput input,
  ) async {
    return await repository.createGroupInCommunity(
      input.headerImage,
      input.groupImage,
      input.name,
      input.description,
      input.privacy,
    );
  }
}

class CreateGroupInCommunityUsecaseInput {
  final File? headerImage;
  final File? groupImage;
  final String name;
  final String? description;
  final String privacy;

  CreateGroupInCommunityUsecaseInput(
      {required this.headerImage,
      required this.groupImage,
      required this.name,
      required this.description,
      required this.privacy});
}
