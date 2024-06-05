import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/profile/data/models/sign_out_model_response.dart';
import 'package:egy_akin/features/profile/domain/repositories/profile_repo.dart';

import '../../../../exports.dart';

class SignOutUsecase implements BaseUseCase<NoParams, SignOutModelResponse> {
  final ProfileRepository repository;

  SignOutUsecase(this.repository);

  @override
  Future<Either<Failure, SignOutModelResponse>> excute(NoParams input) async {
    return await repository.signOut();
  }
}
