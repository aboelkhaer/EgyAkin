// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_search_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetSearchModelResponseImpl _$$GetSearchModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetSearchModelResponseImpl(
      value: json['value'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GetSearchModelResponseImplToJson(
        _$GetSearchModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };
