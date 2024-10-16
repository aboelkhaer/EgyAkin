// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_like_on_post_model_response.freezed.dart';
part 'add_like_on_post_model_response.g.dart';

@freezed
class AddLikeOnPostModelResponse with _$AddLikeOnPostModelResponse {
  const factory AddLikeOnPostModelResponse({
    String? message,
  }) = _AddLikeOnPostModelResponse;
  factory AddLikeOnPostModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AddLikeOnPostModelResponseFromJson(json);
}
