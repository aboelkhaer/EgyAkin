import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/current_doctor_patients/data/models/get_current_doctor_patients_model_response.dart';
import '../../../../exports.dart';

class GetCurrentDoctorPatientsUsecase
    implements BaseUseCase<int, GetDoctorPatientsModelResponse> {
  final CurrentDoctorPatientsRepository repository;

  GetCurrentDoctorPatientsUsecase(this.repository);

  @override
  Future<Either<Failure, GetDoctorPatientsModelResponse>> excute(
      int page) async {
    return await repository.getCurrentDoctorPatients(page);
  }
}
