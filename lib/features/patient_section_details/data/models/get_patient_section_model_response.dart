// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_patient_section_model_response.freezed.dart';
part 'get_patient_section_model_response.g.dart';

@freezed
class GetPatientSectionDetailsModelResponse
    with _$GetPatientSectionDetailsModelResponse {
  const factory GetPatientSectionDetailsModelResponse({
    bool? value,
    List<QuestionModel>? data,
  }) = _GetPatientSectionDetailsModelResponse;
  factory GetPatientSectionDetailsModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetPatientSectionDetailsModelResponseFromJson(json);
}
