// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientHomeModelResponse _$PatientHomeModelResponseFromJson(
        Map<String, dynamic> json) =>
    PatientHomeModelResponse(
      value: json['value'] as bool?,
      patientHomeModel: (json['data'] as List<dynamic>?)
          ?.map((e) => PatientHomeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PatientHomeModelResponseToJson(
        PatientHomeModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.patientHomeModel,
    };

PatientHomeModel _$PatientHomeModelFromJson(Map<String, dynamic> json) =>
    PatientHomeModel(
      id: json['id'] as int?,
      ownerId: json['owner_id'] as int?,
      name: json['name'] as String?,
      hospital: json['hospital'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PatientHomeModelToJson(PatientHomeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'name': instance.name,
      'hospital': instance.hospital,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
