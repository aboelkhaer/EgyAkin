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
      currentPage: (json['current_page'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'] as String?,
      from: (json['from'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      lastPageUrl: json['last_page_url'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: (json['perPage'] as num?)?.toInt(),
      prevPageUrl: json['prev_page_url'] as String?,
      to: (json['to'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$GetSearchDataModelResponseImplToJson(
        _$GetSearchDataModelResponseImpl instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'links': instance.links,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'perPage': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };
