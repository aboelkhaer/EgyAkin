// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_patient_recommendation_model_response.freezed.dart';
part 'create_patient_recommendation_model_response.g.dart';

@freezed
class CreatePatientRecommendationModelResponse with _$CreatePatientRecommendationModelResponse {
  const factory CreatePatientRecommendationModelResponse({
   String? message,
  }) = _CreatePatientRecommendationModelResponse;
  factory CreatePatientRecommendationModelResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePatientRecommendationModelResponseFromJson(json);
}
