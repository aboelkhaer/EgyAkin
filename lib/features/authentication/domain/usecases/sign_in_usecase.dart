import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class SignInUsecase
    implements BaseUseCase<SignInUseCaseInput, AuthenticationModelResponse> {
  final AuthenticationRepository repository;

  SignInUsecase(this.repository);

  @override
  Future<Either<Failure, AuthenticationModelResponse>> excute(
      SignInUseCaseInput input) async {
    return await repository.signIn(
      email: input.email,
      password: input.password,
    );
  }
}

class SignInUseCaseInput {
  final String email;
  final String password;
  const SignInUseCaseInput({
    required this.email,
    required this.password,
  });
}
