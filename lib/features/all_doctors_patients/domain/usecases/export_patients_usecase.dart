import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/export_patients_model_response.dart';
import '../../../../exports.dart';

class ExportPatientsUsecase
    implements BaseUseCase<bool, ExportPatientsModelResponse> {
  final AllDoctorsPatientsRepository repository;

  ExportPatientsUsecase(this.repository);

  @override
  Future<Either<Failure, ExportPatientsModelResponse>> execute(
      bool isOnlyMyPatients) async {
    return await repository.exportFilteredPatients(isOnlyMyPatients);
  }
}
