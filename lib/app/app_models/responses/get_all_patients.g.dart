// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_patients.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllBasPatientstModelResponse _$GetAllBasPatientstModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllBasPatientstModelResponse(
      basePatientList: (json['data'] as List<dynamic>?)
          ?.map((e) => BasePatientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..value = json['value'] as bool?;

Map<String, dynamic> _$GetAllBasPatientstModelResponseToJson(
        GetAllBasPatientstModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.basePatientList,
    };
