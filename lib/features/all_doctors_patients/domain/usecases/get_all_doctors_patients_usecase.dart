import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_all_doctors_patients_model_response.dart';
import '../../../../exports.dart';

class GetAllDoctorsPatientsUsecase
    implements BaseUseCase<int, GetAllDoctorsPatientsModelResponse> {
  final AllDoctorsPatientsRepository repository;

  GetAllDoctorsPatientsUsecase(this.repository);

  @override
  Future<Either<Failure, GetAllDoctorsPatientsModelResponse>> execute(
      int page) async {
    return await repository.getAllDoctorsPatients(page);
  }
}
