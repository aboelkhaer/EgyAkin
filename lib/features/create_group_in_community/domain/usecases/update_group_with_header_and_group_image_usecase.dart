import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

class UpdateGroupWithHeaderAndGroupImageUsecase
    implements
        BaseUseCase<UpdateGroupWithHeaderAndGroupImageUsecaseInput,
            UpdateGroupInCommunityModelResponse> {
  final CreateGroupInCommunityRepository repository;

  UpdateGroupWithHeaderAndGroupImageUsecase(this.repository);

  @override
  Future<Either<Failure, UpdateGroupInCommunityModelResponse>> execute(
    UpdateGroupWithHeaderAndGroupImageUsecaseInput input,
  ) async {
    return await repository.updateGroupWithHeaderAndGroupImageInCommunity(
      input.groupId,
      input.groupImage,
      input.headerImage,
      input.name,
      input.description,
      input.privacy,
    );
  }
}

class UpdateGroupWithHeaderAndGroupImageUsecaseInput {
  final String groupId;
  final File headerImage;
  final File groupImage;
  final String name;
  final String? description;
  final String privacy;

  UpdateGroupWithHeaderAndGroupImageUsecaseInput({
    required this.groupImage,
    required this.name,
    required this.description,
    required this.privacy,
    required this.groupId,
    required this.headerImage,
  });
}
