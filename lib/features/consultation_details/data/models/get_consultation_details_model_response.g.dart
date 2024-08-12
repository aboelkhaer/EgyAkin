// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_consultation_details_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetConsultationDetailsModelResponseImpl
    _$$GetConsultationDetailsModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetConsultationDetailsModelResponseImpl(
          id: json['id'] as String?,
          doctorId: json['doctor_id'] as String?,
          patientId: json['patient_id'] as String?,
          consultMessage: json['consult_message'] as String?,
          status: json['status'] as String?,
          createdAt: json['created_at'] as String?,
          updatedAt: json['updated_at'] as String?,
          consultationDoctors: (json['consultation_doctors'] as List<dynamic>?)
              ?.map((e) => DoctorsConsultationDetailsModelResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetConsultationDetailsModelResponseImplToJson(
        _$GetConsultationDetailsModelResponseImpl instance) =>
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

_$DoctorsConsultationDetailsModelResponseImpl
    _$$DoctorsConsultationDetailsModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$DoctorsConsultationDetailsModelResponseImpl(
          id: json['id'] as String?,
          consultationId: json['consultation_id'] as String?,
          doctorId: json['consult_doctor_id'] as String?,
          doctorFirstName: json['consult_doctor_fname'] as String?,
          doctorLastName: json['consult_doctor_lname'] as String?,
          doctorImage: json['consult_doctor_image'] as String?,
          workingplace: json['workingplace'] as String?,
          isVerified: json['isVerified'] as bool?,
          reply: json['reply'] as String?,
          status: json['status'] as String?,
          createdAt: json['created_at'] as String?,
          updatedAt: json['updated_at'] as String?,
        );

Map<String, dynamic> _$$DoctorsConsultationDetailsModelResponseImplToJson(
        _$DoctorsConsultationDetailsModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'consultation_id': instance.consultationId,
      'consult_doctor_id': instance.doctorId,
      'consult_doctor_fname': instance.doctorFirstName,
      'consult_doctor_lname': instance.doctorLastName,
      'consult_doctor_image': instance.doctorImage,
      'workingplace': instance.workingplace,
      'isVerified': instance.isVerified,
      'reply': instance.reply,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
