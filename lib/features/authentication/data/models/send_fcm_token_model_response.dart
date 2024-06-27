// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_fcm_token_model_response.freezed.dart';
part 'send_fcm_token_model_response.g.dart';

@freezed
class SendFCMTokenModelResponse with _$SendFCMTokenModelResponse {
  const factory SendFCMTokenModelResponse({
    String? message,
  }) = _SendFCMTokenModelResponse;
  factory SendFCMTokenModelResponse.fromJson(Map<String, dynamic> json) =>
      _$SendFCMTokenModelResponseFromJson(json);
}
