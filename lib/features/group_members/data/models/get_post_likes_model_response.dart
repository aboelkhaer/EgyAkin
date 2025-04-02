// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_post_likes_model_response.freezed.dart';
part 'get_post_likes_model_response.g.dart';

@freezed
class GetPostLikesModelResponse with _$GetPostLikesModelResponse {
  const factory GetPostLikesModelResponse({
    MembersDataModelResponse? data,
  }) = _GetPostLikesModelResponse;
  factory GetPostLikesModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostLikesModelResponseFromJson(json);
}
