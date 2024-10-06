// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'apply_patient_filters_model_response.freezed.dart';
part 'apply_patient_filters_model_response.g.dart';

@freezed
class ApplyPatientFiltersModelResponse with _$ApplyPatientFiltersModelResponse {
  const factory ApplyPatientFiltersModelResponse({
    String? message,
  }) = _ApplyPatientFiltersModelResponse;
  factory ApplyPatientFiltersModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ApplyPatientFiltersModelResponseFromJson(json);
}
