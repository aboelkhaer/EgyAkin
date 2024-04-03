import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/profile/data/models/upload_profile_image_model_response.dart';
import 'package:egy_akin/features/profile/domain/repositories/profile_repo.dart';
import '../../../../exports.dart';

class UploadProfileImageUsecase
    implements BaseUseCase<File, UploadProfileImageModelResponse> {
  final ProfileRepository repository;

  UploadProfileImageUsecase(this.repository);

  @override
  Future<Either<Failure, UploadProfileImageModelResponse>> excute(
      File image) async {
    return await repository.uploadProfileImage(image: image);
  }
}
