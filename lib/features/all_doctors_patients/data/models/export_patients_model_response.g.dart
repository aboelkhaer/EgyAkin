// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_patients_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExportPatientsModelResponseImpl _$$ExportPatientsModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ExportPatientsModelResponseImpl(
      message: json['message'] as String?,
      fileUrl: json['file_url'] as String?,
      patientCount: (json['patient_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ExportPatientsModelResponseImplToJson(
        _$ExportPatientsModelResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'file_url': instance.fileUrl,
      'patient_count': instance.patientCount,
    };
