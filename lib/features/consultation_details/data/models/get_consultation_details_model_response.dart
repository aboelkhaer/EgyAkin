// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/features/home/data/models/home_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_consultation_details_model_response.freezed.dart';
part 'get_consultation_details_model_response.g.dart';

@freezed
class GetConsultationDetailsModelResponse
    with _$GetConsultationDetailsModelResponse {
  const factory GetConsultationDetailsModelResponse({
    String? id,
    @JsonKey(name: 'doctor_id') String? doctorId,
    @JsonKey(name: 'patient_id') String? patientId,
    @JsonKey(name: 'consult_message') String? consultMessage,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'doctor_fname') String? doctorFirstName,
    @JsonKey(name: 'doctor_lname') String? doctorLastName,
    @JsonKey(name: 'patient_info') PatientHomeDataModel? patientModel,
    List<DoctorsConsultationDetailsModelResponse>? consultationDoctors,
  }) = _GetConsultationDetailsModelResponse;
  factory GetConsultationDetailsModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetConsultationDetailsModelResponseFromJson(json);
}

@freezed
class DoctorsConsultationDetailsModelResponse
    with _$DoctorsConsultationDetailsModelResponse {
  const factory DoctorsConsultationDetailsModelResponse({
    String? id,
    @JsonKey(name: 'consultation_id') String? consultationId,
    @JsonKey(name: 'consult_doctor_id') String? doctorId,
    @JsonKey(name: 'consult_doctor_fname') String? doctorFirstName,
    @JsonKey(name: 'consult_doctor_lname') String? doctorLastName,
    @JsonKey(name: 'consult_doctor_image') String? doctorImage,
    String? workingplace,
    bool? isVerified,
    String? reply,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _DoctorsConsultationDetailsModelResponse;
  factory DoctorsConsultationDetailsModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DoctorsConsultationDetailsModelResponseFromJson(json);
}
