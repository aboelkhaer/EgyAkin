import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/apply_patient_filters_model_response.dart';
import '../../../../exports.dart';

class ApplyPatientsFiltersUsecase
    implements
        BaseUseCase<ApplyPatientsFiltersUsecaseInput,
            ApplyPatientFiltersModelResponse> {
  final AllDoctorsPatientsRepository repository;

  ApplyPatientsFiltersUsecase(this.repository);

  @override
  Future<Either<Failure, ApplyPatientFiltersModelResponse>> execute(
      ApplyPatientsFiltersUsecaseInput input) async {
    return await repository.applyPatientsFilters(input.map, input.page);
  }
}

class ApplyPatientsFiltersUsecaseInput {
  final Map<String, dynamic> map;
  final int page;

  ApplyPatientsFiltersUsecaseInput({required this.map, required this.page});
}
