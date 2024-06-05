// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_doctor_profile_model_response.freezed.dart';
part 'update_doctor_profile_model_response.g.dart';

@freezed
class UpdateDoctorProfileModelResponse with _$UpdateDoctorProfileModelResponse {
  const factory UpdateDoctorProfileModelResponse({
    DoctorModel? data,
    String? message,
  }) = _UpdateDoctorProfileModelResponse;
  factory UpdateDoctorProfileModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateDoctorProfileModelResponseFromJson(json);
}
