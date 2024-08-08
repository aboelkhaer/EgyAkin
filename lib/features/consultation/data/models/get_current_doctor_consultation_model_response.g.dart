// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_doctor_consultation_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetCurrentDoctorConsultationModelResponseImpl
    _$$GetCurrentDoctorConsultationModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetCurrentDoctorConsultationModelResponseImpl(
          id: (json['id'] as num?)?.toInt(),
          doctorId: json['doctor_id'] as String?,
          patientId: json['patient_id'] as String?,
          consultMessage: json['consult_message'] as String?,
          status: json['status'] as String?,
          createdAt: json['created_at'] as String?,
          updatedAt: json['updated_at'] as String?,
          consultationDoctors: (json['consultation_doctors'] as List<dynamic>?)
              ?.map((e) => ConsultationDoctorsModelResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetCurrentDoctorConsultationModelResponseImplToJson(
        _$GetCurrentDoctorConsultationModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_id': instance.doctorId,
      'patient_id': instance.patientId,
      'consult_message': instance.consultMessage,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'consultation_doctors': instance.consultationDoctors,
    };

_$ConsultationDoctorsModelResponseImpl
    _$$ConsultationDoctorsModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$ConsultationDoctorsModelResponseImpl(
          id: (json['id'] as num?)?.toInt(),
          doctorId: json['doctor_id'] as String?,
          reply: json['reply'] as String?,
          status: json['status'] as String?,
          createdAt: json['created_at'] as String?,
          updatedAt: json['updated_at'] as String?,
        );

Map<String, dynamic> _$$ConsultationDoctorsModelResponseImplToJson(
        _$ConsultationDoctorsModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_id': instance.doctorId,
      'reply': instance.reply,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
