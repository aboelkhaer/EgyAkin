import 'package:dartz/dartz.dart';
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
