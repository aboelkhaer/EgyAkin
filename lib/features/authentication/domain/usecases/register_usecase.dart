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
      deviceId: input.deviceId,
    );
  }
}

class RegisterUsecaseInput {
  final DoctorModel doctorModel;
  final String deviceId;

  RegisterUsecaseInput({required this.doctorModel, required this.deviceId});
}
