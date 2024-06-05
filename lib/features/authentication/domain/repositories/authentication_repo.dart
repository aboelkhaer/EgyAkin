import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticationModelResponse>> signIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, AuthenticationModelResponse>> register({
    required DoctorModel doctorModel,
  });
}
