// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCurrentPatientstModelResponse _$GetCurrentPatientstModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetCurrentPatientstModelResponse(
      basePatientList: (json['data'] as List<dynamic>?)
          ?.map((e) => BasePatientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..value = json['value'] as bool?
      ..scoreValue = json['score_value'] as String?
      ..verified = json['verified'] as bool?;

Map<String, dynamic> _$GetCurrentPatientstModelResponseToJson(
        GetCurrentPatientstModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'score_value': instance.scoreValue,
      'verified': instance.verified,
      'data': instance.basePatientList,
    };
