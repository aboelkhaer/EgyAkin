import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/domain/usecases/patients_list_page_input.dart';
import '../../../../exports.dart';

class GetCurrentDoctorPatientsUsecase
    implements BaseUseCase<PatientsListPageInput, GetDoctorPatientsModelResponse> {
  final CurrentDoctorPatientsRepository repository;

  GetCurrentDoctorPatientsUsecase(this.repository);

  @override
  Future<Either<Failure, GetDoctorPatientsModelResponse>> execute(
      PatientsListPageInput input) async {
    return await repository.getCurrentDoctorPatients(input);
  }
}
