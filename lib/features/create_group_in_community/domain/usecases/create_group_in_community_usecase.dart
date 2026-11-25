import 'dart:io';

import 'package:dartz/dartz.dart';
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
