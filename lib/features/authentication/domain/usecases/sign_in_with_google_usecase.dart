import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/authentication/data/models/authentication_with_google_model_response.dart';
import '../../../../exports.dart';

class SignInWithGoogleUsecase
    implements BaseUseCase<SignInWithGoogleUseCaseInput, AuthenticationWithGoogleModelResponse> {
  final AuthenticationRepository repository;

  SignInWithGoogleUsecase(this.repository);

  @override
  Future<Either<Failure, AuthenticationWithGoogleModelResponse>> execute(
      SignInWithGoogleUseCaseInput input) async {
    return await repository.signInWithGoogle(
      accessToken: input.accessToken,
      deviceId: input.deviceId,
      fcmToken: input.fcmToken,
    );
  }
}

class SignInWithGoogleUseCaseInput {
  final String? accessToken;
  final String deviceId;
  final String? fcmToken;
  const SignInWithGoogleUseCaseInput({
    required this.accessToken,
    required this.deviceId,
    required this.fcmToken,
  });
}
