// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_groups_in_community_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetAllGroupsInCommunityModelResponseImpl
    _$$GetAllGroupsInCommunityModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetAllGroupsInCommunityModelResponseImpl(
          value: json['value'] as bool?,
          data: json['data'] == null
              ? null
              : GetAllGroupsInCommunityDataModelResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$GetAllGroupsInCommunityModelResponseImplToJson(
        _$GetAllGroupsInCommunityModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };

_$GetAllGroupsInCommunityDataModelResponseImpl
    _$$GetAllGroupsInCommunityDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetAllGroupsInCommunityDataModelResponseImpl(
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => GroupModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          currentPage: (json['current_page'] as num?)?.toInt(),
          firstPageUrl: json['first_page_url'] as String?,
          from: (json['from'] as num?)?.toInt(),
          lastPage: (json['last_page'] as num?)?.toInt(),
          lastPageUrl: json['last_page_url'] as String?,
          nextPageUrl: json['next_page_url'] as String?,
          path: json['path'] as String?,
          perPage: (json['perPage'] as num?)?.toInt(),
          prevPageUrl: json['prev_page_url'] as String?,
          to: (json['to'] as num?)?.toInt(),
          total: (json['total'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$GetAllGroupsInCommunityDataModelResponseImplToJson(
        _$GetAllGroupsInCommunityDataModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'current_page': instance.currentPage,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'perPage': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };
