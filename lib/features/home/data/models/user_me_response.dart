// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_me_response.freezed.dart';
part 'user_me_response.g.dart';

String? _flexibleStringFromJson(Object? value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is num) return value.toString();
  return value.toString();
}

/// Account state from `GET /user/me`.
///
/// Do **not** parse this with [HomeModelResponse] — that model expects a `data`
/// dashboard blob and would silently drop `profile`.
@freezed
class UserMeResponse with _$UserMeResponse {
  const factory UserMeResponse({
    bool? value,
    bool? verified,
    @JsonKey(fromJson: _flexibleStringFromJson) String? unreadCount,
    @JsonKey(fromJson: _flexibleStringFromJson)
    String? isSyndicateCardRequired,
    @JsonKey(name: 'isUserBlocked') bool? isUserBlocked,
    @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
    String? doctorPatientCount,
    @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
    String? markedPatientCount,
    @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
    String? allPatientCount,
    @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
    String? scoreValue,
    @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
    String? postsCount,
    @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
    String? savedPostsCount,
    @JsonKey(name: 'app_update_message') dynamic appUpdateMessage,
    String? role,
    @JsonKey(name: 'user_type') String? userType,
    @JsonKey(name: 'permissions_changed') bool? permissionsChanged,
    List<String>? permissions,
    UserMeProfile? profile,
  }) = _UserMeResponse;

  factory UserMeResponse.fromJson(Map<String, dynamic> json) =>
      _$UserMeResponseFromJson(json);
}

@freezed
class UserMeProfile with _$UserMeProfile {
  const factory UserMeProfile({
    int? id,
    String? name,
    String? lname,
    String? email,
    String? image,
    String? avatar,
    String? age,
    String? gender,
    @JsonKey(name: 'birth_date') String? birthDate,
    String? phone,
    String? specialty,
    String? workingplace,
    String? job,
    String? highestdegree,
    @JsonKey(name: 'registration_number') String? registrationNumber,
    @JsonKey(name: 'syndicate_card') String? syndicateCard,
    String? locale,
    String? version,
    @JsonKey(name: 'profile_completed') bool? profileCompleted,
    @JsonKey(name: 'email_verified_at') String? emailVerifiedAt,
    @JsonKey(name: 'phone_verified_at') String? phoneVerifiedAt,
    @JsonKey(name: 'social_verified_at') String? socialVerifiedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _UserMeProfile;

  factory UserMeProfile.fromJson(Map<String, dynamic> json) =>
      _$UserMeProfileFromJson(json);
}
