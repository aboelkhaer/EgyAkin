// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_sort_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SortOptionModelResponseImpl _$$SortOptionModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SortOptionModelResponseImpl(
      key: json['key'] as String?,
      label: json['label'] as String?,
      defaultDirection: json['default_direction'] as String?,
    );

Map<String, dynamic> _$$SortOptionModelResponseImplToJson(
        _$SortOptionModelResponseImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'default_direction': instance.defaultDirection,
    };

_$AppliedSortModelResponseImpl _$$AppliedSortModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AppliedSortModelResponseImpl(
      key: json['key'] as String?,
      direction: json['direction'] as String?,
    );

Map<String, dynamic> _$$AppliedSortModelResponseImplToJson(
        _$AppliedSortModelResponseImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'direction': instance.direction,
    };
