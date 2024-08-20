// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_achievements_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetAchievementsModelResponseImpl _$$GetAchievementsModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetAchievementsModelResponseImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      score: json['score'] as String?,
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$GetAchievementsModelResponseImplToJson(
        _$GetAchievementsModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'score': instance.score,
      'image': instance.image,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$PivotAchievementsModelResponseImpl
    _$$PivotAchievementsModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$PivotAchievementsModelResponseImpl(
          userId: json['user_id'] as String?,
          achievementId: json['achievement_id'] as String?,
          achieved: json['achieved'] as String?,
          createdAt: json['created_at'] as String?,
          updatedAt: json['updated_at'] as String?,
        );

Map<String, dynamic> _$$PivotAchievementsModelResponseImplToJson(
        _$PivotAchievementsModelResponseImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'achievement_id': instance.achievementId,
      'achieved': instance.achieved,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
