// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_patient_recommendation_model_response.freezed.dart';
part 'update_patient_recommendation_model_response.g.dart';

@freezed
class UpdatePatientRecommendationModelResponse with _$UpdatePatientRecommendationModelResponse {
  const factory UpdatePatientRecommendationModelResponse({
   String? message,
  }) = _UpdatePatientRecommendationModelResponse;
  factory UpdatePatientRecommendationModelResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdatePatientRecommendationModelResponseFromJson(json);
}
