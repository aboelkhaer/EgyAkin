// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'join_group_model_response.freezed.dart';
part 'join_group_model_response.g.dart';

@freezed
class JoinGroupModelResponse with _$JoinGroupModelResponse {
  const factory JoinGroupModelResponse({
    String? message,
  }) = _JoinGroupModelResponse;
  factory JoinGroupModelResponse.fromJson(Map<String, dynamic> json) =>
      _$JoinGroupModelResponseFromJson(json);
}
