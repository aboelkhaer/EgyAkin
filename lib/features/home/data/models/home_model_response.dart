// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_model_response.freezed.dart';
part 'home_model_response.g.dart';

num? flexibleNumFromJson(Object? value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is String) return num.tryParse(value.trim());
  return null;
}

@freezed
class HomeModelResponse with _$HomeModelResponse {
  const factory HomeModelResponse({
    bool? value,
    bool? verified,
    String? unreadCount,
    String? isSyndicateCardRequired,
    @JsonKey(name: 'app_update_message') dynamic appUpdateMessage,
    @JsonKey(name: 'doctor_patient_count') String? doctorPatientCount,
    @JsonKey(name: 'all_patient_count') String? allPatientCount,
    @JsonKey(name: 'score_value') String? scoreValue,
    @JsonKey(name: 'role') String? role,
    @JsonKey(name: 'user_type') String? userType,
    @JsonKey(name: 'permissions_changed') bool? permissionsChanged,
    @JsonKey(name: 'isUserBlocked') bool? isUserBlocked,
    @JsonKey(name: 'posts_count') String? postsCount,
    @JsonKey(name: 'saved_posts_count') String? savedPosts,
    @JsonKey(name: 'marked_patient_count') String? markedPatientsCount,
    @JsonKey(name: 'pending_outcome_count') String? pendingOutcomeCount,
    @JsonKey(name: 'draft_count') String? draftCount,
    @JsonKey(name: 'pending_consultation_count') String? pendingConsultationCount,
    @JsonKey(name: 'research_insights') ResearchInsightsModel? researchInsights,
    HomeDataModelResponse? data,
  }) = _HomeModelResponse;
  factory HomeModelResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeModelResponseFromJson(json);
}

@freezed
class HomeDataModelResponse with _$HomeDataModelResponse {
  const factory HomeDataModelResponse({
    @JsonKey(name: 'all_patients') List<PatientHomeDataModel>? allPatients,
    @JsonKey(name: 'current_patient')
    List<PatientHomeDataModel>? currentPatients,
    List<DoctorModel>? topDoctors,
    List<DoctorModel>? pendingSyndicateCard,
    List<PostModel>? posts,
    @JsonKey(name: 'feed_posts') List<PostCommunityModel>? feeds,
    @JsonKey(name: 'trending_hashtags') List<TrendModel>? trendsHashtags,
    @JsonKey(name: 'latest_groups') List<GroupModel>? latestGroups,
    @JsonKey(name: 'pending_outcomes') List<PatientHomeDataModel>? pendingOutcomes,
    List<PatientHomeDataModel>? drafts,
    @JsonKey(name: 'pending_consultations')
    List<GetCurrentDoctorConsultationModelResponse>? pendingConsultations,
    List<HomeActivityModel>? activity,
    @JsonKey(name: 'week_recap') WeekRecapModel? weekRecap,
    @JsonKey(name: 'research_insights') ResearchInsightsModel? researchInsights,
  }) = _HomeDataModelResponse;
  factory HomeDataModelResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataModelResponseFromJson(json);
}

@freezed
class ResearchInsightsModel with _$ResearchInsightsModel {
  const factory ResearchInsightsModel({
    ResearchPopulationModel? population,
    @JsonKey(name: 'aki_incidence_pct', fromJson: flexibleNumFromJson)
    num? akiIncidencePct,
    @JsonKey(name: 'aki_incidence_delta_pct', fromJson: flexibleNumFromJson)
    num? akiIncidenceDeltaPct,
    @JsonKey(name: 'most_common_cause') String? mostCommonCause,
    @JsonKey(name: 'most_common_cause_pct', fromJson: flexibleNumFromJson)
    num? mostCommonCausePct,
    @JsonKey(name: 'avg_egfr_at_admission', fromJson: flexibleNumFromJson)
    num? avgEgfrAtAdmission,
    @JsonKey(name: 'avg_egfr_at_admission_delta', fromJson: flexibleNumFromJson)
    num? avgEgfrAtAdmissionDelta,
    @JsonKey(name: 'computed_at') String? computedAt,
  }) = _ResearchInsightsModel;

  factory ResearchInsightsModel.fromJson(Map<String, dynamic> json) =>
      _$ResearchInsightsModelFromJson(json);
}

@freezed
class ResearchPopulationModel with _$ResearchPopulationModel {
  const factory ResearchPopulationModel({
    @JsonKey(name: 'patient_count', fromJson: flexibleNumFromJson)
    num? patientCount,
    @JsonKey(name: 'hospital_count', fromJson: flexibleNumFromJson)
    num? hospitalCount,
  }) = _ResearchPopulationModel;

  factory ResearchPopulationModel.fromJson(Map<String, dynamic> json) =>
      _$ResearchPopulationModelFromJson(json);
}

@freezed
class WeekRecapModel with _$WeekRecapModel {
  const factory WeekRecapModel({
    String? from,
    String? to,
    @JsonKey(name: 'patients_added') int? patientsAdded,
    @JsonKey(name: 'all_patients_added') int? allPatientsAdded,
    @JsonKey(name: 'outcomes_submitted') int? outcomesSubmitted,
    @JsonKey(name: 'points_earned') int? pointsEarned,
  }) = _WeekRecapModel;

  factory WeekRecapModel.fromJson(Map<String, dynamic> json) =>
      _$WeekRecapModelFromJson(json);
}

@freezed
class PatientHomeDataModel with _$PatientHomeDataModel {
  const factory PatientHomeDataModel({
    int? id,
    String? name,
    String? hospital,
    @JsonKey(fromJson: flexibleNumFromJson) num? age,
    @JsonKey(fromJson: flexibleNumFromJson) num? egfr,
    @JsonKey(name: 'egfr_previous', fromJson: flexibleNumFromJson)
    num? egfrPrevious,
    @JsonKey(fromJson: flexibleNumFromJson) num? bmi,
    @JsonKey(name: 'updated_at') String? updatedAt,
    DoctorModel? doctor,
    SectionHomeDataModel? sections,
    @JsonKey(name: 'sections_completed') int? sectionsCompleted,
    @JsonKey(name: 'sections_total') int? sectionsTotal,
    @JsonKey(name: 'sections_last_updated_at') String? sectionsLastUpdatedAt,
    @JsonKey(name: 'next_section') NextSectionModel? nextSection,
  }) = _PatientHomeDataModel;
  factory PatientHomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$PatientHomeDataModelFromJson(json);
}

@freezed
class NextSectionModel with _$NextSectionModel {
  const factory NextSectionModel({
    int? id,
    String? name,
  }) = _NextSectionModel;

  factory NextSectionModel.fromJson(Map<String, dynamic> json) =>
      _$NextSectionModelFromJson(json);
}

@freezed
class SectionHomeDataModel with _$SectionHomeDataModel {
  const factory SectionHomeDataModel({
    @JsonKey(name: 'patient_id') int? patientId,
    @JsonKey(name: 'submit_status') bool? submitStatus,
    @JsonKey(name: 'outcome_status') bool? outcomeStatus,
  }) = _SectionHomeDataModel;
  factory SectionHomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$SectionHomeDataModelFromJson(json);
}

@freezed
class HomeActivityModel with _$HomeActivityModel {
  const factory HomeActivityModel({
    int? id,
    HomeActivityActorModel? actor,
    String? verb,
    HomeActivityTargetModel? target,
    String? at,
    bool? read,
  }) = _HomeActivityModel;

  factory HomeActivityModel.fromJson(Map<String, dynamic> json) =>
      _$HomeActivityModelFromJson(json);
}

@freezed
class HomeActivityActorModel with _$HomeActivityActorModel {
  const factory HomeActivityActorModel({
    int? id,
    @JsonKey(name: 'name') String? firstName,
    @JsonKey(name: 'lname') String? lastName,
    String? image,
    String? avatar,
    String? isSyndicateCardRequired,
  }) = _HomeActivityActorModel;

  factory HomeActivityActorModel.fromJson(Map<String, dynamic> json) =>
      _$HomeActivityActorModelFromJson(json);
}

@freezed
class HomeActivityTargetModel with _$HomeActivityTargetModel {
  const factory HomeActivityTargetModel({
    @JsonKey(name: 'patient_id') int? patientId,
    @JsonKey(name: 'type_id') int? typeId,
    String? content,
    @JsonKey(name: 'localization_key') String? localizationKey,
    @JsonKey(name: 'localization_params')
    Map<String, dynamic>? localizationParams,
  }) = _HomeActivityTargetModel;

  factory HomeActivityTargetModel.fromJson(Map<String, dynamic> json) =>
      _$HomeActivityTargetModelFromJson(json);
}
