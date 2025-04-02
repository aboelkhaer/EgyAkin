// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_model_response.freezed.dart';
part 'home_model_response.g.dart';

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
    @JsonKey(name: 'isUserBlocked') bool? isUserBlocked,
    @JsonKey(name: 'posts_count') String? postsCount,
    @JsonKey(name: 'saved_posts_count') String? savedPosts,
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
  }) = _HomeDataModelResponse;
  factory HomeDataModelResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataModelResponseFromJson(json);
}

@freezed
class PatientHomeDataModel with _$PatientHomeDataModel {
  const factory PatientHomeDataModel({
    int? id,
    String? name,
    String? hospital,
    @JsonKey(name: 'updated_at') String? updatedAt,
    DoctorModel? doctor,
    SectionHomeDataModel? sections,
  }) = _PatientHomeDataModel;
  factory PatientHomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$PatientHomeDataModelFromJson(json);
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
