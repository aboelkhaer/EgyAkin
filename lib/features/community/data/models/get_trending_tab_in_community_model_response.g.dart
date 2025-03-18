// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_trending_tab_in_community_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetTrendingTabInCommunityModelResponseImpl
    _$$GetTrendingTabInCommunityModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetTrendingTabInCommunityModelResponseImpl(
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => TrendModel.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$$GetTrendingTabInCommunityModelResponseImplToJson(
        _$GetTrendingTabInCommunityModelResponseImpl instance) =>
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

_$TrendModelImpl _$$TrendModelImplFromJson(Map<String, dynamic> json) =>
    _$TrendModelImpl(
      id: (json['id'] as num?)?.toInt(),
      tag: json['tag'] as String?,
      usageCount: (json['usage_count'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$TrendModelImplToJson(_$TrendModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'usage_count': instance.usageCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
