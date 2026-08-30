import 'dart:io';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/home/data/models/user_me_response.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModelResponse>> getHome();
  Future<Either<Failure, UserMeResponse>> getUserMe();
  Future<Either<Failure, UploadSyndicateCardModelResponse>>
      uploadSyndicateCard({
    required File image,
  });
  Future<Either<Failure, GetPermissionsModelResponse>> getRolePermissions();
}
