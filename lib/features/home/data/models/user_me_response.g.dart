// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_me_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserMeResponseImpl _$$UserMeResponseImplFromJson(Map<String, dynamic> json) =>
    _$UserMeResponseImpl(
      value: json['value'] as bool?,
      verified: json['verified'] as bool?,
      unreadCount: _flexibleStringFromJson(json['unreadCount']),
      isSyndicateCardRequired:
          _flexibleStringFromJson(json['isSyndicateCardRequired']),
      isUserBlocked: json['isUserBlocked'] as bool?,
      doctorPatientCount: _flexibleStringFromJson(json['doctor_patient_count']),
      markedPatientCount: _flexibleStringFromJson(json['marked_patient_count']),
      allPatientCount: _flexibleStringFromJson(json['all_patient_count']),
      scoreValue: _flexibleStringFromJson(json['score_value']),
      postsCount: _flexibleStringFromJson(json['posts_count']),
      savedPostsCount: _flexibleStringFromJson(json['saved_posts_count']),
      appUpdateMessage: json['app_update_message'],
      role: json['role'] as String?,
      userType: json['user_type'] as String?,
      permissionsChanged: json['permissions_changed'] as bool?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profile: json['profile'] == null
          ? null
          : UserMeProfile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserMeResponseImplToJson(
        _$UserMeResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'verified': instance.verified,
      'unreadCount': instance.unreadCount,
      'isSyndicateCardRequired': instance.isSyndicateCardRequired,
      'isUserBlocked': instance.isUserBlocked,
      'doctor_patient_count': instance.doctorPatientCount,
      'marked_patient_count': instance.markedPatientCount,
      'all_patient_count': instance.allPatientCount,
      'score_value': instance.scoreValue,
      'posts_count': instance.postsCount,
      'saved_posts_count': instance.savedPostsCount,
      'app_update_message': instance.appUpdateMessage,
      'role': instance.role,
      'user_type': instance.userType,
      'permissions_changed': instance.permissionsChanged,
      'permissions': instance.permissions,
      'profile': instance.profile,
    };

_$UserMeProfileImpl _$$UserMeProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserMeProfileImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      lname: json['lname'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      avatar: json['avatar'] as String?,
      age: json['age'] as String?,
      gender: json['gender'] as String?,
      birthDate: json['birth_date'] as String?,
      phone: json['phone'] as String?,
      specialty: json['specialty'] as String?,
      workingplace: json['workingplace'] as String?,
      job: json['job'] as String?,
      highestdegree: json['highestdegree'] as String?,
      registrationNumber: json['registration_number'] as String?,
      syndicateCard: json['syndicate_card'] as String?,
      locale: json['locale'] as String?,
      version: json['version'] as String?,
      profileCompleted: json['profile_completed'] as bool?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      phoneVerifiedAt: json['phone_verified_at'] as String?,
      socialVerifiedAt: json['social_verified_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$UserMeProfileImplToJson(_$UserMeProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lname': instance.lname,
      'email': instance.email,
      'image': instance.image,
      'avatar': instance.avatar,
      'age': instance.age,
      'gender': instance.gender,
      'birth_date': instance.birthDate,
      'phone': instance.phone,
      'specialty': instance.specialty,
      'workingplace': instance.workingplace,
      'job': instance.job,
      'highestdegree': instance.highestdegree,
      'registration_number': instance.registrationNumber,
      'syndicate_card': instance.syndicateCard,
      'locale': instance.locale,
      'version': instance.version,
      'profile_completed': instance.profileCompleted,
      'email_verified_at': instance.emailVerifiedAt,
      'phone_verified_at': instance.phoneVerifiedAt,
      'social_verified_at': instance.socialVerifiedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
