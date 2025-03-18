// ignore_for_file: invalid_annotation_target

import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_saved_posts_model_response.freezed.dart';
part 'get_saved_posts_model_response.g.dart';

@freezed
class GetSavedPostsModelResponse with _$GetSavedPostsModelResponse {
  const factory GetSavedPostsModelResponse({
    GetPostsCommunityDataModelResponse? data,
  }) = _GetSavedPostsModelResponse;
  factory GetSavedPostsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSavedPostsModelResponseFromJson(json);
}
