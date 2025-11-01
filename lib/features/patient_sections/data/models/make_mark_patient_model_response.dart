// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'make_mark_patient_model_response.freezed.dart';
part 'make_mark_patient_model_response.g.dart';

@freezed
class MakeMarkPatientModelResponse with _$MakeMarkPatientModelResponse {
  const factory MakeMarkPatientModelResponse({
    String? message,
  }) = _MakeMarkPatientModelResponse;
  factory MakeMarkPatientModelResponse.fromJson(Map<String, dynamic> json) =>
      _$MakeMarkPatientModelResponseFromJson(json);
}
