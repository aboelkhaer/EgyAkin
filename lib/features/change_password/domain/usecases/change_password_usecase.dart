import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/change_password/data/models/change_password_model_response.dart';
import '../../../../exports.dart';

class ChangePasswordUsecase
    implements
        BaseUseCase<ChangePasswordUsecaseInput, ChangePasswordModelResponse> {
  final ChangePasswordRepository repository;

  ChangePasswordUsecase(this.repository);

  @override
  Future<Either<Failure, ChangePasswordModelResponse>> execute(
      ChangePasswordUsecaseInput input) async {
    return await repository.changePassword(
      oldPassword: input.oldPassword,
      newPassword: input.newPassword,
    );
  }
}

class ChangePasswordUsecaseInput {
  final String oldPassword;
  final String newPassword;

  ChangePasswordUsecaseInput({
    required this.oldPassword,
    required this.newPassword,
  });
}
