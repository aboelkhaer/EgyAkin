// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_group_model_response.freezed.dart';
part 'leave_group_model_response.g.dart';

@freezed
class LeaveGroupModelResponse with _$LeaveGroupModelResponse {
  const factory LeaveGroupModelResponse({
    String? message,
  }) = _LeaveGroupModelResponse;
  factory LeaveGroupModelResponse.fromJson(Map<String, dynamic> json) =>
      _$LeaveGroupModelResponseFromJson(json);
}
