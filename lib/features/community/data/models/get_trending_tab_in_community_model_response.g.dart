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
        );

Map<String, dynamic> _$$GetTrendingTabInCommunityModelResponseImplToJson(
        _$GetTrendingTabInCommunityModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
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
