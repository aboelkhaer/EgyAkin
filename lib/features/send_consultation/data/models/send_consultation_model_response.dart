// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_consultation_model_response.freezed.dart';

@freezed
class SendConsultationModelResponse with _$SendConsultationModelResponse {
  const SendConsultationModelResponse._();

  const factory SendConsultationModelResponse({
    String? message,
    int? id,
    @JsonKey(name: 'consultation_id') int? consultationId,
    Map<String, dynamic>? data,
  }) = _SendConsultationModelResponse;

  factory SendConsultationModelResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    return SendConsultationModelResponse(
      message: json['message'] as String?,
      id: (json['id'] as num?)?.toInt(),
      consultationId: (json['consultation_id'] as num?)?.toInt(),
      data: rawData is Map<String, dynamic>
          ? rawData
          : rawData is Map
              ? Map<String, dynamic>.from(rawData)
              : null,
    );
  }

  /// Best-effort id from common API shapes (`id`, `consultation_id`, or nested `data`).
  String? get resolvedConsultationId {
    if (id != null) return id.toString();
    if (consultationId != null) return consultationId.toString();
    final d = data;
    if (d == null) return null;
    final nested = d['id'] ?? d['consultation_id'];
    if (nested == null) return null;
    return nested.toString();
  }
}
