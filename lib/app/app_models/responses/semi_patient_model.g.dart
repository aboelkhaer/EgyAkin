// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semi_patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SemiPatientModel _$SemiPatientModelFromJson(Map<String, dynamic> json) =>
    SemiPatientModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      message: json['message'] as String?,
      submitStatus: json['submit_status'] as bool?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$SemiPatientModelToJson(SemiPatientModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'id': instance.id,
      'name': instance.name,
      'doctor_id': instance.doctorId,
      'message': instance.message,
      'submit_status': instance.submitStatus,
    };
