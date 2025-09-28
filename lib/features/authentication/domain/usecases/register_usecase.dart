import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class RegisterUsecase
    implements BaseUseCase<RegisterUsecaseInput, AuthenticationModelResponse> {
  final AuthenticationRepository repository;

  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, AuthenticationModelResponse>> execute(
      RegisterUsecaseInput input) async {
    return await repository.register(
      doctorModel: input.doctorModel,
    );
  }
}

class RegisterUsecaseInput {
  final DoctorModel doctorModel;

  RegisterUsecaseInput({required this.doctorModel,});
}
