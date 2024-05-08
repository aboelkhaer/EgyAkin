// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'delete_patient_model_response.freezed.dart';
part 'delete_patient_model_response.g.dart';

@freezed
class DeletePatientModelResponse with _$DeletePatientModelResponse {
  const factory DeletePatientModelResponse({
    bool? value,
    String? message,
  }) = _DeletePatientModelResponse;
  factory DeletePatientModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePatientModelResponseFromJson(json);
}
