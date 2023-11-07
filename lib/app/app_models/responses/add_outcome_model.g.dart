// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_outcome_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOutcometModelResponse _$AddOutcometModelResponseFromJson(
        Map<String, dynamic> json) =>
    AddOutcometModelResponse(
      message: json['message'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$AddOutcometModelResponseToJson(
        AddOutcometModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
