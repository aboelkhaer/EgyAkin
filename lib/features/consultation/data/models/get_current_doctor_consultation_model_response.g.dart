// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_doctor_consultation_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetCurrentDoctorConsultationModelResponseImpl
    _$$GetCurrentDoctorConsultationModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetCurrentDoctorConsultationModelResponseImpl(
          id: json['id'] as String?,
          doctorId: json['doctor_id'] as String?,
          patientId: json['patient_id'] as String?,
          doctorFirstName: json['doctor_fname'] as String?,
          doctorLastName: json['doctor_lname'] as String?,
          image: json['image'] as String?,
          workingplace: json['workingplace'] as String?,
          isSyndicateCard: json['isSyndicateCard'] as String?,
          patientName: json['patient_name'] as String?,
          status: json['status'] as String?,
          createdAt: json['created_at'] as String?,
          updatedAt: json['updated_at'] as String?,
          consultMessage: json['consult_message'] as String?,
        );

Map<String, dynamic> _$$GetCurrentDoctorConsultationModelResponseImplToJson(
        _$GetCurrentDoctorConsultationModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_id': instance.doctorId,
      'patient_id': instance.patientId,
      'doctor_fname': instance.doctorFirstName,
      'doctor_lname': instance.doctorLastName,
      'image': instance.image,
      'workingplace': instance.workingplace,
      'isSyndicateCard': instance.isSyndicateCard,
      'patient_name': instance.patientName,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'consult_message': instance.consultMessage,
    };
