// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_contact_us_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddContactUsModelResponse _$AddContactUsModelResponseFromJson(
        Map<String, dynamic> json) =>
    AddContactUsModelResponse(
      message: json['message'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$AddContactUsModelResponseToJson(
        AddContactUsModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
