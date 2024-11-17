// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_ai_consultation_request_model_response.freezed.dart';
part 'send_ai_consultation_request_model_response.g.dart';

@freezed
class SendAIConsultationRequestModelResponse
    with _$SendAIConsultationRequestModelResponse {
  const factory SendAIConsultationRequestModelResponse({
    String? message,
  }) = _SendAIConsultationRequestModelResponse;
  factory SendAIConsultationRequestModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SendAIConsultationRequestModelResponseFromJson(json);
}
