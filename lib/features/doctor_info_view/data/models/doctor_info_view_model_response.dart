// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'doctor_info_view_model_response.freezed.dart';
part 'doctor_info_view_model_response.g.dart';

@freezed
class DoctorInfoViewModelResponse with _$DoctorInfoViewModelResponse {
  const factory DoctorInfoViewModelResponse({
    @JsonKey(name: 'patient_count') String? patientCount,
    @JsonKey(name: 'score_value') String? scoreValue,
    DoctorModel? data,
  }) = _DoctorInfoViewModelResponse;
  factory DoctorInfoViewModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorInfoViewModelResponseFromJson(json);
}
