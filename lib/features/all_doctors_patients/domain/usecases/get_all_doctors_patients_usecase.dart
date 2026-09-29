import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/domain/usecases/patients_list_page_input.dart';
import '../../../../exports.dart';

class GetAllDoctorsPatientsUsecase
    implements
        BaseUseCase<PatientsListPageInput, GetAllDoctorsPatientsModelResponse> {
  final AllDoctorsPatientsRepository repository;

  GetAllDoctorsPatientsUsecase(this.repository);

  @override
  Future<Either<Failure, GetAllDoctorsPatientsModelResponse>> execute(
      PatientsListPageInput input) async {
    return await repository.getAllDoctorsPatients(input);
  }
}
