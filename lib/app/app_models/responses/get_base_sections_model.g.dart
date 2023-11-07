// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_base_sections_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBaseSectionsModelResponse _$GetBaseSectionsModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetBaseSectionsModelResponse(
      baseSectionsList: (json['data'] as List<dynamic>?)
          ?.map((e) => BaseSectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      submitStatus: json['submit_status'] as bool?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$GetBaseSectionsModelResponseToJson(
        GetBaseSectionsModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.baseSectionsList,
      'submit_status': instance.submitStatus,
    };
