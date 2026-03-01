import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/authentication/data/models/authentication_with_google_model_response.dart';
import '../../../../exports.dart';

class SignInWithAppleUsecase
    implements
        BaseUseCase<SignInWithAppleUseCaseInput,
            AuthenticationWithGoogleModelResponse> {
  final AuthenticationRepository repository;

  SignInWithAppleUsecase(this.repository);

  @override
  Future<Either<Failure, AuthenticationWithGoogleModelResponse>> execute(
      SignInWithAppleUseCaseInput input) async {
    return await repository.signInWithApple(
      identityToken: input.identityToken,
      authorizationCode: input.authorizationCode,
      deviceId: input.deviceId,
      fcmToken: input.fcmToken,
    );
  }
}

class SignInWithAppleUseCaseInput {
  final String? identityToken;
  final String? authorizationCode;
  final String deviceId;
  final String? fcmToken;
  const SignInWithAppleUseCaseInput({
    required this.identityToken,
    required this.authorizationCode,
    required this.deviceId,
    required this.fcmToken,
  });
}
