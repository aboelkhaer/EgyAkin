// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeletePatientModelResponse _$DeletePatientModelResponseFromJson(
        Map<String, dynamic> json) =>
    DeletePatientModelResponse(
      message: json['message'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$DeletePatientModelResponseToJson(
        DeletePatientModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
