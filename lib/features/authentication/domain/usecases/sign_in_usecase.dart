import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class SignInUsecase
    implements BaseUseCase<SignInUseCaseInput, AuthenticationModelResponse> {
  final AuthenticationRepository repository;

  SignInUsecase(this.repository);

  @override
  Future<Either<Failure, AuthenticationModelResponse>> execute(
      SignInUseCaseInput input) async {
    return await repository.signIn(
      email: input.email,
      password: input.password,
      fcmToken: input.fcmToken,
      deviceId: input.deviceId,
    );
  }
}

class SignInUseCaseInput {
  final String email;
  final String password;
  final String? fcmToken;
  final String deviceId;

  const SignInUseCaseInput({
    required this.email,
    required this.password,
    required this.fcmToken,
    required this.deviceId,
  });
}
