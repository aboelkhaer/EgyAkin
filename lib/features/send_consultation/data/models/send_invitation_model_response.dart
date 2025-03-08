// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_invitation_model_response.freezed.dart';
part 'send_invitation_model_response.g.dart';

@freezed
class SendInvitationModelResponse with _$SendInvitationModelResponse {
  const factory SendInvitationModelResponse({
    String? message,
  }) = _SendInvitationModelResponse;
  factory SendInvitationModelResponse.fromJson(Map<String, dynamic> json) =>
      _$SendInvitationModelResponseFromJson(json);
}
