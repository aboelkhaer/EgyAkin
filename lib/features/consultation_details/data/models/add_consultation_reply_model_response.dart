// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_consultation_reply_model_response.freezed.dart';
part 'add_consultation_reply_model_response.g.dart';

@freezed
class AddConsultationReplyModelResponse
    with _$AddConsultationReplyModelResponse {
  const factory AddConsultationReplyModelResponse({
    String? message,
  }) = _AddConsultationReplyModelResponse;
  factory AddConsultationReplyModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AddConsultationReplyModelResponseFromJson(json);
}
