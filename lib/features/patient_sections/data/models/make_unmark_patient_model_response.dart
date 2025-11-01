// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'make_unmark_patient_model_response.freezed.dart';
part 'make_unmark_patient_model_response.g.dart';

@freezed
class MakeUnMarkPatientModelResponse with _$MakeUnMarkPatientModelResponse {
  const factory MakeUnMarkPatientModelResponse({
    String? message,
  }) = _MakeUnMarkPatientModelResponse;
  factory MakeUnMarkPatientModelResponse.fromJson(Map<String, dynamic> json) =>
      _$MakeUnMarkPatientModelResponseFromJson(json);
}
