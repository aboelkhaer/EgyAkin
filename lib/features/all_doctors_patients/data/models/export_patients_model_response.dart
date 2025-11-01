// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'export_patients_model_response.freezed.dart';
part 'export_patients_model_response.g.dart';

@freezed
class ExportPatientsModelResponse with _$ExportPatientsModelResponse {
  const factory ExportPatientsModelResponse({
    String? message,
    @JsonKey(name: 'file_url') String? fileUrl,
    @JsonKey(name: 'patient_count') int? patientCount,
  }) = _ExportPatientsModelResponse;
  factory ExportPatientsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ExportPatientsModelResponseFromJson(json);
}
