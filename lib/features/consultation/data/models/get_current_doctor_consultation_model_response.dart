// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_current_doctor_consultation_model_response.freezed.dart';
part 'get_current_doctor_consultation_model_response.g.dart';

@freezed
class GetCurrentDoctorConsultationModelResponse
    with _$GetCurrentDoctorConsultationModelResponse {
  const factory GetCurrentDoctorConsultationModelResponse({
    String? id,
    @JsonKey(name: 'doctor_id') String? doctorId,
    @JsonKey(name: 'patient_id') String? patientId,
    @JsonKey(name: 'doctor_fname') String? doctorFirstName,
    @JsonKey(name: 'doctor_lname') String? doctorLastName,
    String? image,
    String? workingplace,
    @JsonKey(name: 'isSyndicateCard') String? isSyndicateCard,
    @JsonKey(name: 'patient_name') String? patientName,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'consult_message') String? consultMessage,
  }) = _GetCurrentDoctorConsultationModelResponse;
  factory GetCurrentDoctorConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetCurrentDoctorConsultationModelResponseFromJson(json);
}
