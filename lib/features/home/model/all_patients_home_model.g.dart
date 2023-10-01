// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_patients_home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPatientHomeModelResponse _$AllPatientHomeModelResponseFromJson(
        Map<String, dynamic> json) =>
    AllPatientHomeModelResponse(
      value: json['value'] as bool?,
      allPatientHomeModel: (json['data'] as List<dynamic>?)
          ?.map((e) => AllPatientHomeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPatientHomeModelResponseToJson(
        AllPatientHomeModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.allPatientHomeModel,
    };

AllPatientHomeModel _$AllPatientHomeModelFromJson(Map<String, dynamic> json) =>
    AllPatientHomeModel(
      id: json['id'] as int?,
      ownerId: json['owner_id'] as int?,
      name: json['name'] as String?,
      hospital: json['hospital'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      ownerModel: json['owner'] == null
          ? null
          : OwnerModel.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllPatientHomeModelToJson(
        AllPatientHomeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'name': instance.name,
      'hospital': instance.hospital,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'owner': instance.ownerModel,
    };

OwnerModel _$OwnerModelFromJson(Map<String, dynamic> json) => OwnerModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      lastName: json['lname'] as String?,
    );

Map<String, dynamic> _$OwnerModelToJson(OwnerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lname': instance.lastName,
    };
