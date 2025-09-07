// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_consultation_search_model_response.freezed.dart';
part 'get_consultation_search_model_response.g.dart';

@freezed
class GetConsultationSearchModelResponse
    with _$GetConsultationSearchModelResponse {
  const factory GetConsultationSearchModelResponse({
    bool? value,
    List<DoctorModelInConsultationModelResponse>? data,
  }) = _GetConsultationSearchModelResponse;
  factory GetConsultationSearchModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetConsultationSearchModelResponseFromJson(json);
}

@freezed
class DoctorModelInConsultationModelResponse
    with _$DoctorModelInConsultationModelResponse {
  const factory DoctorModelInConsultationModelResponse({
    @JsonKey(fromJson: _parseId) int? id,
    @JsonKey(name: 'name') String? firstName,
    @JsonKey(name: 'lname') String? lastName,
    String? email,
    String? phone,
    String? specialty,
    String? workingplace,
    String? image,
    @JsonKey(name: 'syndicate_card') String? syndicateCard,
    String? isSyndicateCardRequired,
    @JsonKey(name: 'patients_count') String? patientsCount,
    String? score,
    String? role,
    String? status,
    String? isVerified,
  }) = _DoctorModelInConsultationModelResponse;
  factory DoctorModelInConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DoctorModelInConsultationModelResponseFromJson(json);
}

// Helper function to parse ID from string or int
int? _parseId(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) {
    return int.tryParse(value);
  }
  return null;
}
