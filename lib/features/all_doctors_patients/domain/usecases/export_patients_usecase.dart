import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/export_patients_model_response.dart';
import '../../../../exports.dart';

class ExportPatientsUsecase
    implements BaseUseCase<NoParams, ExportPatientsModelResponse> {
  final AllDoctorsPatientsRepository repository;

  ExportPatientsUsecase(this.repository);

  @override
  Future<Either<Failure, ExportPatientsModelResponse>> execute(
      NoParams input) async {
    return await repository.exportFilteredPatients();
  }
}
