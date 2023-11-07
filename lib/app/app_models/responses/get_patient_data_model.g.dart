// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_patient_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPatientDataModelResponse _$GetPatientDataModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetPatientDataModelResponse(
      basePatientModel: json['data'] == null
          ? null
          : BasePatientModel.fromJson(json['data'] as Map<String, dynamic>),
    )..value = json['value'] as bool?;

Map<String, dynamic> _$GetPatientDataModelResponseToJson(
        GetPatientDataModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.basePatientModel,
    };
