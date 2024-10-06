// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_filters_options_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetFiltersOptionsModelResponseImpl
    _$$GetFiltersOptionsModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$GetFiltersOptionsModelResponseImpl(
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => GetFiltersOptionsDataModelResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetFiltersOptionsModelResponseImplToJson(
        _$GetFiltersOptionsModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$GetFiltersOptionsDataModelResponseImpl
    _$$GetFiltersOptionsDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetFiltersOptionsDataModelResponseImpl(
          id: (json['id'] as num?)?.toInt(),
          condition: json['condition'] as String?,
          values: json['values'] as List<dynamic>?,
          type: json['type'] as String?,
          keyboardType: json['keyboard_type'] as String?,
        );

Map<String, dynamic> _$$GetFiltersOptionsDataModelResponseImplToJson(
        _$GetFiltersOptionsDataModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'condition': instance.condition,
      'values': instance.values,
      'type': instance.type,
      'keyboard_type': instance.keyboardType,
    };
