import 'package:egy_akin/features/change_password/data/models/change_password_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, ChangePasswordModelResponse>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
