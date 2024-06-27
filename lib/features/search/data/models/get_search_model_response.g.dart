// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_search_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetSearchModelResponseImpl _$$GetSearchModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetSearchModelResponseImpl(
      value: json['value'] as bool?,
      data: json['data'] == null
          ? null
          : GetSearchDataModelResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetSearchModelResponseImplToJson(
        _$GetSearchModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };

_$GetSearchDataModelResponseImpl _$$GetSearchDataModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetSearchDataModelResponseImpl(
      patients: (json['patients'] as List<dynamic>?)
          ?.map((e) => PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      doses: (json['doses'] as List<dynamic>?)
          ?.map((e) => SearchDataForDosesModelResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GetSearchDataModelResponseImplToJson(
        _$GetSearchDataModelResponseImpl instance) =>
    <String, dynamic>{
      'patients': instance.patients,
      'doses': instance.doses,
    };

_$SearchDataForDosesModelResponseImpl
    _$$SearchDataForDosesModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$SearchDataForDosesModelResponseImpl(
          id: (json['id'] as num?)?.toInt(),
          title: json['title'] as String?,
          description: json['description'] as String?,
          dose: json['dose'] as String?,
          createdAt: json['created_at'] as String?,
        );

Map<String, dynamic> _$$SearchDataForDosesModelResponseImplToJson(
        _$SearchDataForDosesModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'dose': instance.dose,
      'created_at': instance.createdAt,
    };
