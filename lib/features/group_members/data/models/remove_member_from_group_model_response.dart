// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'remove_member_from_group_model_response.freezed.dart';
part 'remove_member_from_group_model_response.g.dart';

@freezed
class RemoveMemberFromGroupModelResponse
    with _$RemoveMemberFromGroupModelResponse {
  const factory RemoveMemberFromGroupModelResponse({
    String? message,
  }) = _RemoveMemberFromGroupModelResponse;
  factory RemoveMemberFromGroupModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$RemoveMemberFromGroupModelResponseFromJson(json);
}
