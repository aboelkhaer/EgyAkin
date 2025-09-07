import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticationModelResponse>> signIn({
    required String email,
    required String password,
    required String? fcmToken,
    required String deviceId,
  });
  Future<Either<Failure, AuthenticationModelResponse>> register({
    required DoctorModel doctorModel,
    required String deviceId,
  });
  Future<Either<Failure, SendFCMTokenModelResponse>> sendFCMToken({
    required String? fcmToken,
  });
}
