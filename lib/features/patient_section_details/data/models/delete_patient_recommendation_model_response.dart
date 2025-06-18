// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'delete_patient_recommendation_model_response.freezed.dart';
part 'delete_patient_recommendation_model_response.g.dart';

@freezed
class DeletePatientRecommendationModelResponse with _$DeletePatientRecommendationModelResponse {
  const factory DeletePatientRecommendationModelResponse({
   String? message,
  }) = _DeletePatientRecommendationModelResponse;
  factory DeletePatientRecommendationModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePatientRecommendationModelResponseFromJson(json);
}
