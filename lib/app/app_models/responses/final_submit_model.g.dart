// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'final_submit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinalSubmitModelResponse _$FinalSubmitModelResponseFromJson(
        Map<String, dynamic> json) =>
    FinalSubmitModelResponse(
      message: json['message'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$FinalSubmitModelResponseToJson(
        FinalSubmitModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
