import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

class SignOutUsecase implements BaseUseCase<NoParams, SignOutModelResponse> {
  final ProfileRepository repository;

  SignOutUsecase(this.repository);

  @override
  Future<Either<Failure, SignOutModelResponse>> excute(NoParams input) async {
    return await repository.signOut();
  }
}
