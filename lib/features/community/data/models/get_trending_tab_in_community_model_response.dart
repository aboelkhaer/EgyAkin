// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_trending_tab_in_community_model_response.freezed.dart';
part 'get_trending_tab_in_community_model_response.g.dart';

@freezed
class GetTrendingTabInCommunityModelResponse
    with _$GetTrendingTabInCommunityModelResponse {
  const factory GetTrendingTabInCommunityModelResponse({
    List<TrendModel>? data,
  }) = _GetTrendingTabInCommunityModelResponse;
  factory GetTrendingTabInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetTrendingTabInCommunityModelResponseFromJson(json);
}

@freezed
class TrendModel with _$TrendModel {
  const factory TrendModel({
    int? id,
    String? tag,
    @JsonKey(name: 'usage_count') int? usageCount,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _TrendModel;
  factory TrendModel.fromJson(Map<String, dynamic> json) =>
      _$TrendModelFromJson(json);
}
