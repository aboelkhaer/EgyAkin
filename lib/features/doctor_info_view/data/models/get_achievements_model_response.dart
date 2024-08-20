// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_achievements_model_response.freezed.dart';
part 'get_achievements_model_response.g.dart';

@freezed
class GetAchievementsModelResponse with _$GetAchievementsModelResponse {
  const factory GetAchievementsModelResponse({
    int? id,
    String? name,
    String? description,
    String? score,
    String? image,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _GetAchievementsModelResponse;
  factory GetAchievementsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAchievementsModelResponseFromJson(json);
}

@freezed
class PivotAchievementsModelResponse with _$PivotAchievementsModelResponse {
  const factory PivotAchievementsModelResponse({
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'achievement_id') String? achievementId,
    String? achieved,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _PivotAchievementsModelResponse;
  factory PivotAchievementsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$PivotAchievementsModelResponseFromJson(json);
}
