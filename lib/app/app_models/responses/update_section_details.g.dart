// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_section_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSectionDetailsModelResponse _$UpdateSectionDetailsModelResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateSectionDetailsModelResponse(
      message: json['message'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$UpdateSectionDetailsModelResponseToJson(
        UpdateSectionDetailsModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
