import 'dart:io';

import 'package:dartz/dartz.dart';
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
