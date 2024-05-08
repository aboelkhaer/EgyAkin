import 'dart:io';
import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UploadProfileImageModelResponse>> uploadProfileImage({
    required File image,
  });
  Future<Either<Failure, SignOutModelResponse>> signOut();
}
