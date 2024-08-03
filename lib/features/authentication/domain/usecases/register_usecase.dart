import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class RegisterUsecase
    implements BaseUseCase<DoctorModel, AuthenticationModelResponse> {
  final AuthenticationRepository repository;

  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, AuthenticationModelResponse>> execute(
      DoctorModel doctorModel) async {
    return await repository.register(doctorModel: doctorModel);
  }
}
