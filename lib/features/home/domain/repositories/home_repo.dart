import 'dart:io';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModelResponse>> getHome();
  Future<Either<Failure, UploadSyndicateCardModelResponse>>
      uploadSyndicateCard({
    required File image,
  });
  Future<Either<Failure, GetPermissionsModelResponse>> getRolePermissions();
}
