
// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_for_dose_model_response.freezed.dart';
part 'search_for_dose_model_response.g.dart';

@freezed
class SearchForDoseInMedicationSectionModelResponse with _$SearchForDoseInMedicationSectionModelResponse {
  const factory SearchForDoseInMedicationSectionModelResponse({
  SearchForDoseInMedicationSectionDataModelResponse? data,
  }) = _SearchForDoseInMedicationSectionModelResponse;
  factory SearchForDoseInMedicationSectionModelResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchForDoseInMedicationSectionModelResponseFromJson(json);
}

@freezed
class SearchForDoseInMedicationSectionDataModelResponse with _$SearchForDoseInMedicationSectionDataModelResponse {
  const factory SearchForDoseInMedicationSectionDataModelResponse({
   List<DoseModelInSearch>? data,
  }) = _SearchForDoseInMedicationSectionDataModelResponse;
  factory SearchForDoseInMedicationSectionDataModelResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchForDoseInMedicationSectionDataModelResponseFromJson(json);
}

@freezed
class DoseModelInSearch with _$DoseModelInSearch {
  const factory DoseModelInSearch({
   int? id,
   String? title,
   String? description,
   String? dose,
  
  }) = _DoseModelInSearch;
  factory DoseModelInSearch.fromJson(Map<String, dynamic> json) =>
      _$DoseModelInSearchFromJson(json);
}
