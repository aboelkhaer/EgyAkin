// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_external_model_response.freezed.dart';
part 'invite_external_model_response.g.dart';

@freezed
class InviteExternalModelResponse with _$InviteExternalModelResponse {
  const factory InviteExternalModelResponse({
    bool? value,
    String? message,
    InviteExternalData? data,
  }) = _InviteExternalModelResponse;

  factory InviteExternalModelResponse.fromJson(Map<String, dynamic> json) =>
      _$InviteExternalModelResponseFromJson(json);
}

@freezed
class InviteExternalData with _$InviteExternalData {
  const factory InviteExternalData({
    @JsonKey(name: 'invite_id') int? inviteId,
    @JsonKey(name: 'consultation_id') int? consultationId,
    String? email,
    @JsonKey(name: 'expires_at') String? expiresAt,
    /// Present on 409 when the email already has an account.
    @JsonKey(name: 'existing_user_id') int? existingUserId,
  }) = _InviteExternalData;

  factory InviteExternalData.fromJson(Map<String, dynamic> json) =>
      _$InviteExternalDataFromJson(json);
}
