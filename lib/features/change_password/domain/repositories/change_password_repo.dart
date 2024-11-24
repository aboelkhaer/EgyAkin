import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, ChangePasswordModelResponse>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
