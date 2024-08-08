// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_consultation_model_response.freezed.dart';
part 'send_consultation_model_response.g.dart';

@freezed
class SendConsultationModelResponse with _$SendConsultationModelResponse {
  const factory SendConsultationModelResponse({
    String? message,
  }) = _SendConsultationModelResponse;
  factory SendConsultationModelResponse.fromJson(Map<String, dynamic> json) =>
      _$SendConsultationModelResponseFromJson(json);
}
