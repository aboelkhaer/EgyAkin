// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_me_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserMeResponse _$UserMeResponseFromJson(Map<String, dynamic> json) {
  return _UserMeResponse.fromJson(json);
}

/// @nodoc
mixin _$UserMeResponse {
  bool? get value => throw _privateConstructorUsedError;
  bool? get verified => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleStringFromJson)
  String? get unreadCount => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleStringFromJson)
  String? get isSyndicateCardRequired => throw _privateConstructorUsedError;
  @JsonKey(name: 'isUserBlocked')
  bool? get isUserBlocked => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
  String? get doctorPatientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
  String? get markedPatientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
  String? get allPatientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
  String? get scoreValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
  String? get postsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
  String? get savedPostsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'app_update_message')
  dynamic get appUpdateMessage => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_type')
  String? get userType => throw _privateConstructorUsedError;
  @JsonKey(name: 'permissions_changed')
  bool? get permissionsChanged => throw _privateConstructorUsedError;
  List<String>? get permissions => throw _privateConstructorUsedError;
  UserMeProfile? get profile => throw _privateConstructorUsedError;

  /// Serializes this UserMeResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserMeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserMeResponseCopyWith<UserMeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMeResponseCopyWith<$Res> {
  factory $UserMeResponseCopyWith(
          UserMeResponse value, $Res Function(UserMeResponse) then) =
      _$UserMeResponseCopyWithImpl<$Res, UserMeResponse>;
  @useResult
  $Res call(
      {bool? value,
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
      UserMeProfile? profile});

  $UserMeProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class _$UserMeResponseCopyWithImpl<$Res, $Val extends UserMeResponse>
    implements $UserMeResponseCopyWith<$Res> {
  _$UserMeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserMeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? verified = freezed,
    Object? unreadCount = freezed,
    Object? isSyndicateCardRequired = freezed,
    Object? isUserBlocked = freezed,
    Object? doctorPatientCount = freezed,
    Object? markedPatientCount = freezed,
    Object? allPatientCount = freezed,
    Object? scoreValue = freezed,
    Object? postsCount = freezed,
    Object? savedPostsCount = freezed,
    Object? appUpdateMessage = freezed,
    Object? role = freezed,
    Object? userType = freezed,
    Object? permissionsChanged = freezed,
    Object? permissions = freezed,
    Object? profile = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
      isUserBlocked: freezed == isUserBlocked
          ? _value.isUserBlocked
          : isUserBlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      doctorPatientCount: freezed == doctorPatientCount
          ? _value.doctorPatientCount
          : doctorPatientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      markedPatientCount: freezed == markedPatientCount
          ? _value.markedPatientCount
          : markedPatientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      allPatientCount: freezed == allPatientCount
          ? _value.allPatientCount
          : allPatientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreValue: freezed == scoreValue
          ? _value.scoreValue
          : scoreValue // ignore: cast_nullable_to_non_nullable
              as String?,
      postsCount: freezed == postsCount
          ? _value.postsCount
          : postsCount // ignore: cast_nullable_to_non_nullable
              as String?,
      savedPostsCount: freezed == savedPostsCount
          ? _value.savedPostsCount
          : savedPostsCount // ignore: cast_nullable_to_non_nullable
              as String?,
      appUpdateMessage: freezed == appUpdateMessage
          ? _value.appUpdateMessage
          : appUpdateMessage // ignore: cast_nullable_to_non_nullable
              as dynamic,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      permissionsChanged: freezed == permissionsChanged
          ? _value.permissionsChanged
          : permissionsChanged // ignore: cast_nullable_to_non_nullable
              as bool?,
      permissions: freezed == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserMeProfile?,
    ) as $Val);
  }

  /// Create a copy of UserMeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserMeProfileCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $UserMeProfileCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserMeResponseImplCopyWith<$Res>
    implements $UserMeResponseCopyWith<$Res> {
  factory _$$UserMeResponseImplCopyWith(_$UserMeResponseImpl value,
          $Res Function(_$UserMeResponseImpl) then) =
      __$$UserMeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
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
      UserMeProfile? profile});

  @override
  $UserMeProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class __$$UserMeResponseImplCopyWithImpl<$Res>
    extends _$UserMeResponseCopyWithImpl<$Res, _$UserMeResponseImpl>
    implements _$$UserMeResponseImplCopyWith<$Res> {
  __$$UserMeResponseImplCopyWithImpl(
      _$UserMeResponseImpl _value, $Res Function(_$UserMeResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserMeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? verified = freezed,
    Object? unreadCount = freezed,
    Object? isSyndicateCardRequired = freezed,
    Object? isUserBlocked = freezed,
    Object? doctorPatientCount = freezed,
    Object? markedPatientCount = freezed,
    Object? allPatientCount = freezed,
    Object? scoreValue = freezed,
    Object? postsCount = freezed,
    Object? savedPostsCount = freezed,
    Object? appUpdateMessage = freezed,
    Object? role = freezed,
    Object? userType = freezed,
    Object? permissionsChanged = freezed,
    Object? permissions = freezed,
    Object? profile = freezed,
  }) {
    return _then(_$UserMeResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
      isUserBlocked: freezed == isUserBlocked
          ? _value.isUserBlocked
          : isUserBlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      doctorPatientCount: freezed == doctorPatientCount
          ? _value.doctorPatientCount
          : doctorPatientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      markedPatientCount: freezed == markedPatientCount
          ? _value.markedPatientCount
          : markedPatientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      allPatientCount: freezed == allPatientCount
          ? _value.allPatientCount
          : allPatientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreValue: freezed == scoreValue
          ? _value.scoreValue
          : scoreValue // ignore: cast_nullable_to_non_nullable
              as String?,
      postsCount: freezed == postsCount
          ? _value.postsCount
          : postsCount // ignore: cast_nullable_to_non_nullable
              as String?,
      savedPostsCount: freezed == savedPostsCount
          ? _value.savedPostsCount
          : savedPostsCount // ignore: cast_nullable_to_non_nullable
              as String?,
      appUpdateMessage: freezed == appUpdateMessage
          ? _value.appUpdateMessage
          : appUpdateMessage // ignore: cast_nullable_to_non_nullable
              as dynamic,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      permissionsChanged: freezed == permissionsChanged
          ? _value.permissionsChanged
          : permissionsChanged // ignore: cast_nullable_to_non_nullable
              as bool?,
      permissions: freezed == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserMeProfile?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserMeResponseImpl implements _UserMeResponse {
  const _$UserMeResponseImpl(
      {this.value,
      this.verified,
      @JsonKey(fromJson: _flexibleStringFromJson) this.unreadCount,
      @JsonKey(fromJson: _flexibleStringFromJson) this.isSyndicateCardRequired,
      @JsonKey(name: 'isUserBlocked') this.isUserBlocked,
      @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
      this.doctorPatientCount,
      @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
      this.markedPatientCount,
      @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
      this.allPatientCount,
      @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
      this.scoreValue,
      @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
      this.postsCount,
      @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
      this.savedPostsCount,
      @JsonKey(name: 'app_update_message') this.appUpdateMessage,
      this.role,
      @JsonKey(name: 'user_type') this.userType,
      @JsonKey(name: 'permissions_changed') this.permissionsChanged,
      final List<String>? permissions,
      this.profile})
      : _permissions = permissions;

  factory _$UserMeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserMeResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final bool? verified;
  @override
  @JsonKey(fromJson: _flexibleStringFromJson)
  final String? unreadCount;
  @override
  @JsonKey(fromJson: _flexibleStringFromJson)
  final String? isSyndicateCardRequired;
  @override
  @JsonKey(name: 'isUserBlocked')
  final bool? isUserBlocked;
  @override
  @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
  final String? doctorPatientCount;
  @override
  @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
  final String? markedPatientCount;
  @override
  @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
  final String? allPatientCount;
  @override
  @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
  final String? scoreValue;
  @override
  @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
  final String? postsCount;
  @override
  @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
  final String? savedPostsCount;
  @override
  @JsonKey(name: 'app_update_message')
  final dynamic appUpdateMessage;
  @override
  final String? role;
  @override
  @JsonKey(name: 'user_type')
  final String? userType;
  @override
  @JsonKey(name: 'permissions_changed')
  final bool? permissionsChanged;
  final List<String>? _permissions;
  @override
  List<String>? get permissions {
    final value = _permissions;
    if (value == null) return null;
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final UserMeProfile? profile;

  @override
  String toString() {
    return 'UserMeResponse(value: $value, verified: $verified, unreadCount: $unreadCount, isSyndicateCardRequired: $isSyndicateCardRequired, isUserBlocked: $isUserBlocked, doctorPatientCount: $doctorPatientCount, markedPatientCount: $markedPatientCount, allPatientCount: $allPatientCount, scoreValue: $scoreValue, postsCount: $postsCount, savedPostsCount: $savedPostsCount, appUpdateMessage: $appUpdateMessage, role: $role, userType: $userType, permissionsChanged: $permissionsChanged, permissions: $permissions, profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserMeResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(
                    other.isSyndicateCardRequired, isSyndicateCardRequired) ||
                other.isSyndicateCardRequired == isSyndicateCardRequired) &&
            (identical(other.isUserBlocked, isUserBlocked) ||
                other.isUserBlocked == isUserBlocked) &&
            (identical(other.doctorPatientCount, doctorPatientCount) ||
                other.doctorPatientCount == doctorPatientCount) &&
            (identical(other.markedPatientCount, markedPatientCount) ||
                other.markedPatientCount == markedPatientCount) &&
            (identical(other.allPatientCount, allPatientCount) ||
                other.allPatientCount == allPatientCount) &&
            (identical(other.scoreValue, scoreValue) ||
                other.scoreValue == scoreValue) &&
            (identical(other.postsCount, postsCount) ||
                other.postsCount == postsCount) &&
            (identical(other.savedPostsCount, savedPostsCount) ||
                other.savedPostsCount == savedPostsCount) &&
            const DeepCollectionEquality()
                .equals(other.appUpdateMessage, appUpdateMessage) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.permissionsChanged, permissionsChanged) ||
                other.permissionsChanged == permissionsChanged) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      value,
      verified,
      unreadCount,
      isSyndicateCardRequired,
      isUserBlocked,
      doctorPatientCount,
      markedPatientCount,
      allPatientCount,
      scoreValue,
      postsCount,
      savedPostsCount,
      const DeepCollectionEquality().hash(appUpdateMessage),
      role,
      userType,
      permissionsChanged,
      const DeepCollectionEquality().hash(_permissions),
      profile);

  /// Create a copy of UserMeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserMeResponseImplCopyWith<_$UserMeResponseImpl> get copyWith =>
      __$$UserMeResponseImplCopyWithImpl<_$UserMeResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserMeResponseImplToJson(
      this,
    );
  }
}

abstract class _UserMeResponse implements UserMeResponse {
  const factory _UserMeResponse(
      {final bool? value,
      final bool? verified,
      @JsonKey(fromJson: _flexibleStringFromJson) final String? unreadCount,
      @JsonKey(fromJson: _flexibleStringFromJson)
      final String? isSyndicateCardRequired,
      @JsonKey(name: 'isUserBlocked') final bool? isUserBlocked,
      @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
      final String? doctorPatientCount,
      @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
      final String? markedPatientCount,
      @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
      final String? allPatientCount,
      @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
      final String? scoreValue,
      @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
      final String? postsCount,
      @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
      final String? savedPostsCount,
      @JsonKey(name: 'app_update_message') final dynamic appUpdateMessage,
      final String? role,
      @JsonKey(name: 'user_type') final String? userType,
      @JsonKey(name: 'permissions_changed') final bool? permissionsChanged,
      final List<String>? permissions,
      final UserMeProfile? profile}) = _$UserMeResponseImpl;

  factory _UserMeResponse.fromJson(Map<String, dynamic> json) =
      _$UserMeResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  bool? get verified;
  @override
  @JsonKey(fromJson: _flexibleStringFromJson)
  String? get unreadCount;
  @override
  @JsonKey(fromJson: _flexibleStringFromJson)
  String? get isSyndicateCardRequired;
  @override
  @JsonKey(name: 'isUserBlocked')
  bool? get isUserBlocked;
  @override
  @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
  String? get doctorPatientCount;
  @override
  @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
  String? get markedPatientCount;
  @override
  @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
  String? get allPatientCount;
  @override
  @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
  String? get scoreValue;
  @override
  @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
  String? get postsCount;
  @override
  @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
  String? get savedPostsCount;
  @override
  @JsonKey(name: 'app_update_message')
  dynamic get appUpdateMessage;
  @override
  String? get role;
  @override
  @JsonKey(name: 'user_type')
  String? get userType;
  @override
  @JsonKey(name: 'permissions_changed')
  bool? get permissionsChanged;
  @override
  List<String>? get permissions;
  @override
  UserMeProfile? get profile;

  /// Create a copy of UserMeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserMeResponseImplCopyWith<_$UserMeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserMeProfile _$UserMeProfileFromJson(Map<String, dynamic> json) {
  return _UserMeProfile.fromJson(json);
}

/// @nodoc
mixin _$UserMeProfile {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get lname => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get age => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'birth_date')
  String? get birthDate => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get specialty => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;
  String? get job => throw _privateConstructorUsedError;
  String? get highestdegree => throw _privateConstructorUsedError;
  @JsonKey(name: 'registration_number')
  String? get registrationNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'syndicate_card')
  String? get syndicateCard => throw _privateConstructorUsedError;
  String? get locale => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_completed')
  bool? get profileCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'email_verified_at')
  String? get emailVerifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_verified_at')
  String? get phoneVerifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'social_verified_at')
  String? get socialVerifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserMeProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserMeProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserMeProfileCopyWith<UserMeProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMeProfileCopyWith<$Res> {
  factory $UserMeProfileCopyWith(
          UserMeProfile value, $Res Function(UserMeProfile) then) =
      _$UserMeProfileCopyWithImpl<$Res, UserMeProfile>;
  @useResult
  $Res call(
      {int? id,
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
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$UserMeProfileCopyWithImpl<$Res, $Val extends UserMeProfile>
    implements $UserMeProfileCopyWith<$Res> {
  _$UserMeProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserMeProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? lname = freezed,
    Object? email = freezed,
    Object? image = freezed,
    Object? avatar = freezed,
    Object? age = freezed,
    Object? gender = freezed,
    Object? birthDate = freezed,
    Object? phone = freezed,
    Object? specialty = freezed,
    Object? workingplace = freezed,
    Object? job = freezed,
    Object? highestdegree = freezed,
    Object? registrationNumber = freezed,
    Object? syndicateCard = freezed,
    Object? locale = freezed,
    Object? version = freezed,
    Object? profileCompleted = freezed,
    Object? emailVerifiedAt = freezed,
    Object? phoneVerifiedAt = freezed,
    Object? socialVerifiedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lname: freezed == lname
          ? _value.lname
          : lname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      specialty: freezed == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String?,
      highestdegree: freezed == highestdegree
          ? _value.highestdegree
          : highestdegree // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      syndicateCard: freezed == syndicateCard
          ? _value.syndicateCard
          : syndicateCard // ignore: cast_nullable_to_non_nullable
              as String?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      profileCompleted: freezed == profileCompleted
          ? _value.profileCompleted
          : profileCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneVerifiedAt: freezed == phoneVerifiedAt
          ? _value.phoneVerifiedAt
          : phoneVerifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      socialVerifiedAt: freezed == socialVerifiedAt
          ? _value.socialVerifiedAt
          : socialVerifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserMeProfileImplCopyWith<$Res>
    implements $UserMeProfileCopyWith<$Res> {
  factory _$$UserMeProfileImplCopyWith(
          _$UserMeProfileImpl value, $Res Function(_$UserMeProfileImpl) then) =
      __$$UserMeProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
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
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$UserMeProfileImplCopyWithImpl<$Res>
    extends _$UserMeProfileCopyWithImpl<$Res, _$UserMeProfileImpl>
    implements _$$UserMeProfileImplCopyWith<$Res> {
  __$$UserMeProfileImplCopyWithImpl(
      _$UserMeProfileImpl _value, $Res Function(_$UserMeProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserMeProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? lname = freezed,
    Object? email = freezed,
    Object? image = freezed,
    Object? avatar = freezed,
    Object? age = freezed,
    Object? gender = freezed,
    Object? birthDate = freezed,
    Object? phone = freezed,
    Object? specialty = freezed,
    Object? workingplace = freezed,
    Object? job = freezed,
    Object? highestdegree = freezed,
    Object? registrationNumber = freezed,
    Object? syndicateCard = freezed,
    Object? locale = freezed,
    Object? version = freezed,
    Object? profileCompleted = freezed,
    Object? emailVerifiedAt = freezed,
    Object? phoneVerifiedAt = freezed,
    Object? socialVerifiedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UserMeProfileImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lname: freezed == lname
          ? _value.lname
          : lname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      specialty: freezed == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String?,
      highestdegree: freezed == highestdegree
          ? _value.highestdegree
          : highestdegree // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      syndicateCard: freezed == syndicateCard
          ? _value.syndicateCard
          : syndicateCard // ignore: cast_nullable_to_non_nullable
              as String?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      profileCompleted: freezed == profileCompleted
          ? _value.profileCompleted
          : profileCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneVerifiedAt: freezed == phoneVerifiedAt
          ? _value.phoneVerifiedAt
          : phoneVerifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      socialVerifiedAt: freezed == socialVerifiedAt
          ? _value.socialVerifiedAt
          : socialVerifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserMeProfileImpl implements _UserMeProfile {
  const _$UserMeProfileImpl(
      {this.id,
      this.name,
      this.lname,
      this.email,
      this.image,
      this.avatar,
      this.age,
      this.gender,
      @JsonKey(name: 'birth_date') this.birthDate,
      this.phone,
      this.specialty,
      this.workingplace,
      this.job,
      this.highestdegree,
      @JsonKey(name: 'registration_number') this.registrationNumber,
      @JsonKey(name: 'syndicate_card') this.syndicateCard,
      this.locale,
      this.version,
      @JsonKey(name: 'profile_completed') this.profileCompleted,
      @JsonKey(name: 'email_verified_at') this.emailVerifiedAt,
      @JsonKey(name: 'phone_verified_at') this.phoneVerifiedAt,
      @JsonKey(name: 'social_verified_at') this.socialVerifiedAt,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$UserMeProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserMeProfileImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? lname;
  @override
  final String? email;
  @override
  final String? image;
  @override
  final String? avatar;
  @override
  final String? age;
  @override
  final String? gender;
  @override
  @JsonKey(name: 'birth_date')
  final String? birthDate;
  @override
  final String? phone;
  @override
  final String? specialty;
  @override
  final String? workingplace;
  @override
  final String? job;
  @override
  final String? highestdegree;
  @override
  @JsonKey(name: 'registration_number')
  final String? registrationNumber;
  @override
  @JsonKey(name: 'syndicate_card')
  final String? syndicateCard;
  @override
  final String? locale;
  @override
  final String? version;
  @override
  @JsonKey(name: 'profile_completed')
  final bool? profileCompleted;
  @override
  @JsonKey(name: 'email_verified_at')
  final String? emailVerifiedAt;
  @override
  @JsonKey(name: 'phone_verified_at')
  final String? phoneVerifiedAt;
  @override
  @JsonKey(name: 'social_verified_at')
  final String? socialVerifiedAt;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'UserMeProfile(id: $id, name: $name, lname: $lname, email: $email, image: $image, avatar: $avatar, age: $age, gender: $gender, birthDate: $birthDate, phone: $phone, specialty: $specialty, workingplace: $workingplace, job: $job, highestdegree: $highestdegree, registrationNumber: $registrationNumber, syndicateCard: $syndicateCard, locale: $locale, version: $version, profileCompleted: $profileCompleted, emailVerifiedAt: $emailVerifiedAt, phoneVerifiedAt: $phoneVerifiedAt, socialVerifiedAt: $socialVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserMeProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lname, lname) || other.lname == lname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty) &&
            (identical(other.workingplace, workingplace) ||
                other.workingplace == workingplace) &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.highestdegree, highestdegree) ||
                other.highestdegree == highestdegree) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.syndicateCard, syndicateCard) ||
                other.syndicateCard == syndicateCard) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.profileCompleted, profileCompleted) ||
                other.profileCompleted == profileCompleted) &&
            (identical(other.emailVerifiedAt, emailVerifiedAt) ||
                other.emailVerifiedAt == emailVerifiedAt) &&
            (identical(other.phoneVerifiedAt, phoneVerifiedAt) ||
                other.phoneVerifiedAt == phoneVerifiedAt) &&
            (identical(other.socialVerifiedAt, socialVerifiedAt) ||
                other.socialVerifiedAt == socialVerifiedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        lname,
        email,
        image,
        avatar,
        age,
        gender,
        birthDate,
        phone,
        specialty,
        workingplace,
        job,
        highestdegree,
        registrationNumber,
        syndicateCard,
        locale,
        version,
        profileCompleted,
        emailVerifiedAt,
        phoneVerifiedAt,
        socialVerifiedAt,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of UserMeProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserMeProfileImplCopyWith<_$UserMeProfileImpl> get copyWith =>
      __$$UserMeProfileImplCopyWithImpl<_$UserMeProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserMeProfileImplToJson(
      this,
    );
  }
}

abstract class _UserMeProfile implements UserMeProfile {
  const factory _UserMeProfile(
      {final int? id,
      final String? name,
      final String? lname,
      final String? email,
      final String? image,
      final String? avatar,
      final String? age,
      final String? gender,
      @JsonKey(name: 'birth_date') final String? birthDate,
      final String? phone,
      final String? specialty,
      final String? workingplace,
      final String? job,
      final String? highestdegree,
      @JsonKey(name: 'registration_number') final String? registrationNumber,
      @JsonKey(name: 'syndicate_card') final String? syndicateCard,
      final String? locale,
      final String? version,
      @JsonKey(name: 'profile_completed') final bool? profileCompleted,
      @JsonKey(name: 'email_verified_at') final String? emailVerifiedAt,
      @JsonKey(name: 'phone_verified_at') final String? phoneVerifiedAt,
      @JsonKey(name: 'social_verified_at') final String? socialVerifiedAt,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at')
      final String? updatedAt}) = _$UserMeProfileImpl;

  factory _UserMeProfile.fromJson(Map<String, dynamic> json) =
      _$UserMeProfileImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get lname;
  @override
  String? get email;
  @override
  String? get image;
  @override
  String? get avatar;
  @override
  String? get age;
  @override
  String? get gender;
  @override
  @JsonKey(name: 'birth_date')
  String? get birthDate;
  @override
  String? get phone;
  @override
  String? get specialty;
  @override
  String? get workingplace;
  @override
  String? get job;
  @override
  String? get highestdegree;
  @override
  @JsonKey(name: 'registration_number')
  String? get registrationNumber;
  @override
  @JsonKey(name: 'syndicate_card')
  String? get syndicateCard;
  @override
  String? get locale;
  @override
  String? get version;
  @override
  @JsonKey(name: 'profile_completed')
  bool? get profileCompleted;
  @override
  @JsonKey(name: 'email_verified_at')
  String? get emailVerifiedAt;
  @override
  @JsonKey(name: 'phone_verified_at')
  String? get phoneVerifiedAt;
  @override
  @JsonKey(name: 'social_verified_at')
  String? get socialVerifiedAt;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of UserMeProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserMeProfileImplCopyWith<_$UserMeProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
