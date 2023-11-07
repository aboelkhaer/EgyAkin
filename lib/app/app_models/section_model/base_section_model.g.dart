// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseSectionModel _$BaseSectionModelFromJson(Map<String, dynamic> json) =>
    BaseSectionModel(
      sectionId: json['section_id'] as int?,
      sectionName: json['section_name'] as String?,
      sectionStatus: json['section_status'] as bool?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$BaseSectionModelToJson(BaseSectionModel instance) =>
    <String, dynamic>{
      'section_id': instance.sectionId,
      'section_name': instance.sectionName,
      'section_status': instance.sectionStatus,
      'updated_at': instance.updatedAt,
    };
