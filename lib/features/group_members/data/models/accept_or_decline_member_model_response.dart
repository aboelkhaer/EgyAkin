// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'accept_or_decline_member_model_response.freezed.dart';
part 'accept_or_decline_member_model_response.g.dart';

@freezed
class AcceptOrDeclineMemberModelResponse
    with _$AcceptOrDeclineMemberModelResponse {
  const factory AcceptOrDeclineMemberModelResponse({
    String? message,
  }) = _AcceptOrDeclineMemberModelResponse;
  factory AcceptOrDeclineMemberModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AcceptOrDeclineMemberModelResponseFromJson(json);
}
