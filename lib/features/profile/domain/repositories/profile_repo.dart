import 'dart:io';

import 'package:egy_akin/features/profile/data/models/sign_out_model_response.dart';
import 'package:egy_akin/features/profile/data/models/upload_profile_image_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UploadProfileImageModelResponse>> uploadProfileImage({
    required File image,
  });
  Future<Either<Failure, SignOutModelResponse>> signOut();
}
