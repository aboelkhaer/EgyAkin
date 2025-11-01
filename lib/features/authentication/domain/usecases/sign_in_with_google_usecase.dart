import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class SignInWithGoogleUsecase
    implements BaseUseCase<SignInWithGoogleUseCaseInput, AuthenticationModelResponse> {
  final AuthenticationRepository repository;

  SignInWithGoogleUsecase(this.repository);

  @override
  Future<Either<Failure, AuthenticationModelResponse>> execute(
      SignInWithGoogleUseCaseInput input) async {
    return await repository.signInWithGoogle(
      accessToken: input.accessToken,
      deviceId: input.deviceId,
    );
  }
}

class SignInWithGoogleUseCaseInput {
  final String? accessToken;
  final String deviceId;

  const SignInWithGoogleUseCaseInput({
    required this.accessToken,
    required this.deviceId,
  });
}
