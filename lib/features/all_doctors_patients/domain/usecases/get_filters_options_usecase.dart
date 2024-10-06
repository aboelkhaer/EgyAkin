import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_filters_options_model_response.dart';
import '../../../../exports.dart';

class GetFiltersOptionsUsecase
    implements BaseUseCase<NoParams, GetFiltersOptionsModelResponse> {
  final AllDoctorsPatientsRepository repository;

  GetFiltersOptionsUsecase(this.repository);

  @override
  Future<Either<Failure, GetFiltersOptionsModelResponse>> execute(
      NoParams input) async {
    return await repository.getFiltersOptions();
  }
}
