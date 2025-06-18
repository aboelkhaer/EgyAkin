
import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/search_for_dose_model_response.dart';
import '../../../../exports.dart';

class SearchForDoseInMedicationSectionUsecase
    implements BaseUseCase<SearchForDoseInMedicationSectionUsecaseInput, SearchForDoseInMedicationSectionModelResponse> {
  final PatientSectionDetailsRepository repository;

  SearchForDoseInMedicationSectionUsecase(this.repository);

  @override
  Future<Either<Failure, SearchForDoseInMedicationSectionModelResponse>> execute(
      SearchForDoseInMedicationSectionUsecaseInput input) async {
    return await repository.searchForDoseInMedicationSection(input.dose, input.page);
  }
}
class SearchForDoseInMedicationSectionUsecaseInput{
  final String dose;
  final int page;

  SearchForDoseInMedicationSectionUsecaseInput({required this.dose, required this.page});
}