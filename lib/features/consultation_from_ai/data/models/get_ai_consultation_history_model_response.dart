// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_ai_consultation_history_model_response.freezed.dart';
part 'get_ai_consultation_history_model_response.g.dart';

@freezed
class GetAiConsultationHistoryModelResponse
    with _$GetAiConsultationHistoryModelResponse {
  const factory GetAiConsultationHistoryModelResponse({
    bool? value,
    String? message,
    @JsonKey(name: 'trial_count') int? trialCount,
    @JsonKey(name: 'reset_date') String? resetDate,
    ConsultationHistory? history,
  }) = _GetAiConsultationHistoryModelResponse;
  factory GetAiConsultationHistoryModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetAiConsultationHistoryModelResponseFromJson(json);
}

@freezed
class ConsultationHistory with _$ConsultationHistory {
  const factory ConsultationHistory({
    @JsonKey(name: 'current_page') int? currentPage,
    List<ConsultationData>? data,
    int? total,
    @JsonKey(name: 'last_page') int? lastPage,
  }) = _ConsultationHistory;

  factory ConsultationHistory.fromJson(Map<String, dynamic> json) =>
      _$ConsultationHistoryFromJson(json);
}

@freezed
class ConsultationData with _$ConsultationData {
  const factory ConsultationData({
    int? id,
    @JsonKey(name: 'doctor_id') int? doctorId,
    @JsonKey(name: 'patient_id') int? patientId,
    String? question,
    String? response,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _ConsultationData;

  factory ConsultationData.fromJson(Map<String, dynamic> json) =>
      _$ConsultationDataFromJson(json);
}
