// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_current_doctor_consultation_model_response.freezed.dart';
part 'get_current_doctor_consultation_model_response.g.dart';

@freezed
class GetCurrentDoctorConsultationModelResponse
    with _$GetCurrentDoctorConsultationModelResponse {
  const factory GetCurrentDoctorConsultationModelResponse({
    int? id,
    @JsonKey(name: 'doctor_id') String? doctorId,
    @JsonKey(name: 'patient_id') String? patientId,
    @JsonKey(name: 'consult_message') String? consultMessage,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'consultation_doctors')
    List<ConsultationDoctorsModelResponse>? consultationDoctors,
  }) = _GetCurrentDoctorConsultationModelResponse;
  factory GetCurrentDoctorConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetCurrentDoctorConsultationModelResponseFromJson(json);
}

@freezed
class ConsultationDoctorsModelResponse with _$ConsultationDoctorsModelResponse {
  const factory ConsultationDoctorsModelResponse({
    int? id,
    @JsonKey(name: 'doctor_id') String? doctorId,
    String? reply,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _ConsultationDoctorsModelResponse;
  factory ConsultationDoctorsModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ConsultationDoctorsModelResponseFromJson(json);
}
