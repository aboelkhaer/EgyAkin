import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetCurrentDoctorPatientsUsecase
    implements BaseUseCase<int, GetDoctorPatientsModelResponse> {
  final CurrentDoctorPatientsRepository repository;

  GetCurrentDoctorPatientsUsecase(this.repository);

  @override
  Future<Either<Failure, GetDoctorPatientsModelResponse>> execute(
      int page) async {
    return await repository.getCurrentDoctorPatients(page);
  }
}
