import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_recommendation_model.freezed.dart';
part 'patient_recommendation_model.g.dart';

@freezed
class PatientRecommendationModel with _$PatientRecommendationModel {
  const factory PatientRecommendationModel({
    required String id,
    required String? doseName,
    required String? dose,
    required String? route,
    required String? frequency,
    required String? duration,
    required String? type,
    required String? content,
  }) = _PatientRecommendationModel;

  factory PatientRecommendationModel.fromJson(Map<String, dynamic> json) =>
      _$PatientRecommendationModelFromJson(json);
} 