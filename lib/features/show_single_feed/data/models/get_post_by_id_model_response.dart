// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../exports.dart';

part 'get_post_by_id_model_response.freezed.dart';
part 'get_post_by_id_model_response.g.dart';

@freezed
class GetPostByIdModelResponse with _$GetPostByIdModelResponse {
  const factory GetPostByIdModelResponse({
    bool? value,
    PostCommunityModel? data,
  }) = _GetPostByIdModelResponse;

  factory GetPostByIdModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostByIdModelResponseFromJson(json);
}
