import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/apply_patient_filters_model_response.dart';
import '../../../../exports.dart';

class ApplyPatientsFiltersUsecase
    implements
        BaseUseCase<Map<String, dynamic>, ApplyPatientFiltersModelResponse> {
  final AllDoctorsPatientsRepository repository;

  ApplyPatientsFiltersUsecase(this.repository);

  @override
  Future<Either<Failure, ApplyPatientFiltersModelResponse>> execute(
      Map<String, dynamic> map) async {
    return await repository.applyPatientsFilters(map);
  }
}
