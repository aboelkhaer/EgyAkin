// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'lock_or_unlock_consultation_model_response.freezed.dart';
part 'lock_or_unlock_consultation_model_response.g.dart';

@freezed
class LockOrUnlockConsultationModelResponse
    with _$LockOrUnlockConsultationModelResponse {
  const factory LockOrUnlockConsultationModelResponse({
    String? message,
    LockOrUnlockConsultationModelResponseData? data,
  }) = _LockOrUnlockConsultationModelResponse;
  factory LockOrUnlockConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$LockOrUnlockConsultationModelResponseFromJson(json);
}

@freezed
class LockOrUnlockConsultationModelResponseData
    with _$LockOrUnlockConsultationModelResponseData {
  const factory LockOrUnlockConsultationModelResponseData({
      @JsonKey(name: 'consultation_id') int? consultationId,
      @JsonKey(name: 'is_open') bool? isOpen,
  }) = _LockOrUnlockConsultationModelResponseData;
  factory LockOrUnlockConsultationModelResponseData.fromJson(
          Map<String, dynamic> json) =>
      _$LockOrUnlockConsultationModelResponseDataFromJson(json);
}
