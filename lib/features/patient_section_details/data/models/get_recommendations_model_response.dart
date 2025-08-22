// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_recommendations_model_response.freezed.dart';
part 'get_recommendations_model_response.g.dart';

@freezed
class GetRecommendationsModelResponse with _$GetRecommendationsModelResponse {
  const factory GetRecommendationsModelResponse({
    List<GetRecommendationsDataModelResponse>? data,
  }) = _GetRecommendationsModelResponse;
  factory GetRecommendationsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetRecommendationsModelResponseFromJson(json);
}

@freezed
class GetRecommendationsDataModelResponse
    with _$GetRecommendationsDataModelResponse {
  const factory GetRecommendationsDataModelResponse({
    int? id,
    @JsonKey(name: 'patient_id') int? patientId,
    @JsonKey(name: 'dose_name') String? doseName,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    String? dose,
    String? route,
    String? frequency,
    String? duration,
    String? type,
    String? content,
  }) = _GetRecommendationsDataModelResponse;
  factory GetRecommendationsDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetRecommendationsDataModelResponseFromJson(json);
}
