// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_patient_section_details_model_response.freezed.dart';
part 'update_patient_section_details_model_response.g.dart';

@freezed
class UpdatePatientSectionDetailsModelResponse
    with _$UpdatePatientSectionDetailsModelResponse {
  const factory UpdatePatientSectionDetailsModelResponse({
    String? message,
  }) = _UpdatePatientSectionDetailsModelResponse;
  factory UpdatePatientSectionDetailsModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdatePatientSectionDetailsModelResponseFromJson(json);
}
