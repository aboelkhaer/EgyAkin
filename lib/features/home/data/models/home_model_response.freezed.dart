// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeModelResponse _$HomeModelResponseFromJson(Map<String, dynamic> json) {
  return _HomeModelResponse.fromJson(json);
}

/// @nodoc
mixin _$HomeModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  bool? get verified => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleStringFromJson)
  String? get unreadCount => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleStringFromJson)
  String? get isSyndicateCardRequired => throw _privateConstructorUsedError;
  @JsonKey(name: 'app_update_message')
  dynamic get appUpdateMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
  String? get doctorPatientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
  String? get allPatientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
  String? get scoreValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'role')
  String? get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_type')
  String? get userType => throw _privateConstructorUsedError;
  @JsonKey(name: 'permissions_changed')
  bool? get permissionsChanged => throw _privateConstructorUsedError;
  @JsonKey(name: 'isUserBlocked')
  bool? get isUserBlocked => throw _privateConstructorUsedError;
  @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
  String? get postsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
  String? get savedPosts => throw _privateConstructorUsedError;
  @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
  String? get markedPatientsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'pending_outcome_count', fromJson: _flexibleStringFromJson)
  String? get pendingOutcomeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'draft_count', fromJson: _flexibleStringFromJson)
  String? get draftCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'research_insights')
  ResearchInsightsModel? get researchInsights =>
      throw _privateConstructorUsedError;
  HomeDataModelResponse? get data => throw _privateConstructorUsedError;

  /// Serializes this HomeModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeModelResponseCopyWith<HomeModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeModelResponseCopyWith<$Res> {
  factory $HomeModelResponseCopyWith(
          HomeModelResponse value, $Res Function(HomeModelResponse) then) =
      _$HomeModelResponseCopyWithImpl<$Res, HomeModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      bool? verified,
      @JsonKey(fromJson: _flexibleStringFromJson) String? unreadCount,
      @JsonKey(fromJson: _flexibleStringFromJson)
      String? isSyndicateCardRequired,
      @JsonKey(name: 'app_update_message') dynamic appUpdateMessage,
      @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
      String? doctorPatientCount,
      @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
      String? allPatientCount,
      @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
      String? scoreValue,
      @JsonKey(name: 'role') String? role,
      @JsonKey(name: 'user_type') String? userType,
      @JsonKey(name: 'permissions_changed') bool? permissionsChanged,
      @JsonKey(name: 'isUserBlocked') bool? isUserBlocked,
      @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
      String? postsCount,
      @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
      String? savedPosts,
      @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
      String? markedPatientsCount,
      @JsonKey(name: 'pending_outcome_count', fromJson: _flexibleStringFromJson)
      String? pendingOutcomeCount,
      @JsonKey(name: 'draft_count', fromJson: _flexibleStringFromJson)
      String? draftCount,
      @JsonKey(name: 'research_insights')
      ResearchInsightsModel? researchInsights,
      HomeDataModelResponse? data});

  $ResearchInsightsModelCopyWith<$Res>? get researchInsights;
  $HomeDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$HomeModelResponseCopyWithImpl<$Res, $Val extends HomeModelResponse>
    implements $HomeModelResponseCopyWith<$Res> {
  _$HomeModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? verified = freezed,
    Object? unreadCount = freezed,
    Object? isSyndicateCardRequired = freezed,
    Object? appUpdateMessage = freezed,
    Object? doctorPatientCount = freezed,
    Object? allPatientCount = freezed,
    Object? scoreValue = freezed,
    Object? role = freezed,
    Object? userType = freezed,
    Object? permissionsChanged = freezed,
    Object? isUserBlocked = freezed,
    Object? postsCount = freezed,
    Object? savedPosts = freezed,
    Object? markedPatientsCount = freezed,
    Object? pendingOutcomeCount = freezed,
    Object? draftCount = freezed,
    Object? researchInsights = freezed,
    Object? data = freezed,
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
      appUpdateMessage: freezed == appUpdateMessage
          ? _value.appUpdateMessage
          : appUpdateMessage // ignore: cast_nullable_to_non_nullable
              as dynamic,
      doctorPatientCount: freezed == doctorPatientCount
          ? _value.doctorPatientCount
          : doctorPatientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      allPatientCount: freezed == allPatientCount
          ? _value.allPatientCount
          : allPatientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreValue: freezed == scoreValue
          ? _value.scoreValue
          : scoreValue // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isUserBlocked: freezed == isUserBlocked
          ? _value.isUserBlocked
          : isUserBlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      postsCount: freezed == postsCount
          ? _value.postsCount
          : postsCount // ignore: cast_nullable_to_non_nullable
              as String?,
      savedPosts: freezed == savedPosts
          ? _value.savedPosts
          : savedPosts // ignore: cast_nullable_to_non_nullable
              as String?,
      markedPatientsCount: freezed == markedPatientsCount
          ? _value.markedPatientsCount
          : markedPatientsCount // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingOutcomeCount: freezed == pendingOutcomeCount
          ? _value.pendingOutcomeCount
          : pendingOutcomeCount // ignore: cast_nullable_to_non_nullable
              as String?,
      draftCount: freezed == draftCount
          ? _value.draftCount
          : draftCount // ignore: cast_nullable_to_non_nullable
              as String?,
      researchInsights: freezed == researchInsights
          ? _value.researchInsights
          : researchInsights // ignore: cast_nullable_to_non_nullable
              as ResearchInsightsModel?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as HomeDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of HomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResearchInsightsModelCopyWith<$Res>? get researchInsights {
    if (_value.researchInsights == null) {
      return null;
    }

    return $ResearchInsightsModelCopyWith<$Res>(_value.researchInsights!,
        (value) {
      return _then(_value.copyWith(researchInsights: value) as $Val);
    });
  }

  /// Create a copy of HomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomeDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $HomeDataModelResponseCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeModelResponseImplCopyWith<$Res>
    implements $HomeModelResponseCopyWith<$Res> {
  factory _$$HomeModelResponseImplCopyWith(_$HomeModelResponseImpl value,
          $Res Function(_$HomeModelResponseImpl) then) =
      __$$HomeModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      bool? verified,
      @JsonKey(fromJson: _flexibleStringFromJson) String? unreadCount,
      @JsonKey(fromJson: _flexibleStringFromJson)
      String? isSyndicateCardRequired,
      @JsonKey(name: 'app_update_message') dynamic appUpdateMessage,
      @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
      String? doctorPatientCount,
      @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
      String? allPatientCount,
      @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
      String? scoreValue,
      @JsonKey(name: 'role') String? role,
      @JsonKey(name: 'user_type') String? userType,
      @JsonKey(name: 'permissions_changed') bool? permissionsChanged,
      @JsonKey(name: 'isUserBlocked') bool? isUserBlocked,
      @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
      String? postsCount,
      @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
      String? savedPosts,
      @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
      String? markedPatientsCount,
      @JsonKey(name: 'pending_outcome_count', fromJson: _flexibleStringFromJson)
      String? pendingOutcomeCount,
      @JsonKey(name: 'draft_count', fromJson: _flexibleStringFromJson)
      String? draftCount,
      @JsonKey(name: 'research_insights')
      ResearchInsightsModel? researchInsights,
      HomeDataModelResponse? data});

  @override
  $ResearchInsightsModelCopyWith<$Res>? get researchInsights;
  @override
  $HomeDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$HomeModelResponseImplCopyWithImpl<$Res>
    extends _$HomeModelResponseCopyWithImpl<$Res, _$HomeModelResponseImpl>
    implements _$$HomeModelResponseImplCopyWith<$Res> {
  __$$HomeModelResponseImplCopyWithImpl(_$HomeModelResponseImpl _value,
      $Res Function(_$HomeModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? verified = freezed,
    Object? unreadCount = freezed,
    Object? isSyndicateCardRequired = freezed,
    Object? appUpdateMessage = freezed,
    Object? doctorPatientCount = freezed,
    Object? allPatientCount = freezed,
    Object? scoreValue = freezed,
    Object? role = freezed,
    Object? userType = freezed,
    Object? permissionsChanged = freezed,
    Object? isUserBlocked = freezed,
    Object? postsCount = freezed,
    Object? savedPosts = freezed,
    Object? markedPatientsCount = freezed,
    Object? pendingOutcomeCount = freezed,
    Object? draftCount = freezed,
    Object? researchInsights = freezed,
    Object? data = freezed,
  }) {
    return _then(_$HomeModelResponseImpl(
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
      appUpdateMessage: freezed == appUpdateMessage
          ? _value.appUpdateMessage
          : appUpdateMessage // ignore: cast_nullable_to_non_nullable
              as dynamic,
      doctorPatientCount: freezed == doctorPatientCount
          ? _value.doctorPatientCount
          : doctorPatientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      allPatientCount: freezed == allPatientCount
          ? _value.allPatientCount
          : allPatientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreValue: freezed == scoreValue
          ? _value.scoreValue
          : scoreValue // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isUserBlocked: freezed == isUserBlocked
          ? _value.isUserBlocked
          : isUserBlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      postsCount: freezed == postsCount
          ? _value.postsCount
          : postsCount // ignore: cast_nullable_to_non_nullable
              as String?,
      savedPosts: freezed == savedPosts
          ? _value.savedPosts
          : savedPosts // ignore: cast_nullable_to_non_nullable
              as String?,
      markedPatientsCount: freezed == markedPatientsCount
          ? _value.markedPatientsCount
          : markedPatientsCount // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingOutcomeCount: freezed == pendingOutcomeCount
          ? _value.pendingOutcomeCount
          : pendingOutcomeCount // ignore: cast_nullable_to_non_nullable
              as String?,
      draftCount: freezed == draftCount
          ? _value.draftCount
          : draftCount // ignore: cast_nullable_to_non_nullable
              as String?,
      researchInsights: freezed == researchInsights
          ? _value.researchInsights
          : researchInsights // ignore: cast_nullable_to_non_nullable
              as ResearchInsightsModel?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as HomeDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeModelResponseImpl implements _HomeModelResponse {
  const _$HomeModelResponseImpl(
      {this.value,
      this.verified,
      @JsonKey(fromJson: _flexibleStringFromJson) this.unreadCount,
      @JsonKey(fromJson: _flexibleStringFromJson) this.isSyndicateCardRequired,
      @JsonKey(name: 'app_update_message') this.appUpdateMessage,
      @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
      this.doctorPatientCount,
      @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
      this.allPatientCount,
      @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
      this.scoreValue,
      @JsonKey(name: 'role') this.role,
      @JsonKey(name: 'user_type') this.userType,
      @JsonKey(name: 'permissions_changed') this.permissionsChanged,
      @JsonKey(name: 'isUserBlocked') this.isUserBlocked,
      @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
      this.postsCount,
      @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
      this.savedPosts,
      @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
      this.markedPatientsCount,
      @JsonKey(name: 'pending_outcome_count', fromJson: _flexibleStringFromJson)
      this.pendingOutcomeCount,
      @JsonKey(name: 'draft_count', fromJson: _flexibleStringFromJson)
      this.draftCount,
      @JsonKey(name: 'research_insights') this.researchInsights,
      this.data});

  factory _$HomeModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeModelResponseImplFromJson(json);

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
  @JsonKey(name: 'app_update_message')
  final dynamic appUpdateMessage;
  @override
  @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
  final String? doctorPatientCount;
  @override
  @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
  final String? allPatientCount;
  @override
  @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
  final String? scoreValue;
  @override
  @JsonKey(name: 'role')
  final String? role;
  @override
  @JsonKey(name: 'user_type')
  final String? userType;
  @override
  @JsonKey(name: 'permissions_changed')
  final bool? permissionsChanged;
  @override
  @JsonKey(name: 'isUserBlocked')
  final bool? isUserBlocked;
  @override
  @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
  final String? postsCount;
  @override
  @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
  final String? savedPosts;
  @override
  @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
  final String? markedPatientsCount;
  @override
  @JsonKey(name: 'pending_outcome_count', fromJson: _flexibleStringFromJson)
  final String? pendingOutcomeCount;
  @override
  @JsonKey(name: 'draft_count', fromJson: _flexibleStringFromJson)
  final String? draftCount;
  @override
  @JsonKey(name: 'research_insights')
  final ResearchInsightsModel? researchInsights;
  @override
  final HomeDataModelResponse? data;

  @override
  String toString() {
    return 'HomeModelResponse(value: $value, verified: $verified, unreadCount: $unreadCount, isSyndicateCardRequired: $isSyndicateCardRequired, appUpdateMessage: $appUpdateMessage, doctorPatientCount: $doctorPatientCount, allPatientCount: $allPatientCount, scoreValue: $scoreValue, role: $role, userType: $userType, permissionsChanged: $permissionsChanged, isUserBlocked: $isUserBlocked, postsCount: $postsCount, savedPosts: $savedPosts, markedPatientsCount: $markedPatientsCount, pendingOutcomeCount: $pendingOutcomeCount, draftCount: $draftCount, researchInsights: $researchInsights, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(
                    other.isSyndicateCardRequired, isSyndicateCardRequired) ||
                other.isSyndicateCardRequired == isSyndicateCardRequired) &&
            const DeepCollectionEquality()
                .equals(other.appUpdateMessage, appUpdateMessage) &&
            (identical(other.doctorPatientCount, doctorPatientCount) ||
                other.doctorPatientCount == doctorPatientCount) &&
            (identical(other.allPatientCount, allPatientCount) ||
                other.allPatientCount == allPatientCount) &&
            (identical(other.scoreValue, scoreValue) ||
                other.scoreValue == scoreValue) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.permissionsChanged, permissionsChanged) ||
                other.permissionsChanged == permissionsChanged) &&
            (identical(other.isUserBlocked, isUserBlocked) ||
                other.isUserBlocked == isUserBlocked) &&
            (identical(other.postsCount, postsCount) ||
                other.postsCount == postsCount) &&
            (identical(other.savedPosts, savedPosts) ||
                other.savedPosts == savedPosts) &&
            (identical(other.markedPatientsCount, markedPatientsCount) ||
                other.markedPatientsCount == markedPatientsCount) &&
            (identical(other.pendingOutcomeCount, pendingOutcomeCount) ||
                other.pendingOutcomeCount == pendingOutcomeCount) &&
            (identical(other.draftCount, draftCount) ||
                other.draftCount == draftCount) &&
            (identical(other.researchInsights, researchInsights) ||
                other.researchInsights == researchInsights) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        value,
        verified,
        unreadCount,
        isSyndicateCardRequired,
        const DeepCollectionEquality().hash(appUpdateMessage),
        doctorPatientCount,
        allPatientCount,
        scoreValue,
        role,
        userType,
        permissionsChanged,
        isUserBlocked,
        postsCount,
        savedPosts,
        markedPatientsCount,
        pendingOutcomeCount,
        draftCount,
        researchInsights,
        data
      ]);

  /// Create a copy of HomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeModelResponseImplCopyWith<_$HomeModelResponseImpl> get copyWith =>
      __$$HomeModelResponseImplCopyWithImpl<_$HomeModelResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeModelResponseImplToJson(
      this,
    );
  }
}

abstract class _HomeModelResponse implements HomeModelResponse {
  const factory _HomeModelResponse(
      {final bool? value,
      final bool? verified,
      @JsonKey(fromJson: _flexibleStringFromJson) final String? unreadCount,
      @JsonKey(fromJson: _flexibleStringFromJson)
      final String? isSyndicateCardRequired,
      @JsonKey(name: 'app_update_message') final dynamic appUpdateMessage,
      @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
      final String? doctorPatientCount,
      @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
      final String? allPatientCount,
      @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
      final String? scoreValue,
      @JsonKey(name: 'role') final String? role,
      @JsonKey(name: 'user_type') final String? userType,
      @JsonKey(name: 'permissions_changed') final bool? permissionsChanged,
      @JsonKey(name: 'isUserBlocked') final bool? isUserBlocked,
      @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
      final String? postsCount,
      @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
      final String? savedPosts,
      @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
      final String? markedPatientsCount,
      @JsonKey(name: 'pending_outcome_count', fromJson: _flexibleStringFromJson)
      final String? pendingOutcomeCount,
      @JsonKey(name: 'draft_count', fromJson: _flexibleStringFromJson)
      final String? draftCount,
      @JsonKey(name: 'research_insights')
      final ResearchInsightsModel? researchInsights,
      final HomeDataModelResponse? data}) = _$HomeModelResponseImpl;

  factory _HomeModelResponse.fromJson(Map<String, dynamic> json) =
      _$HomeModelResponseImpl.fromJson;

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
  @JsonKey(name: 'app_update_message')
  dynamic get appUpdateMessage;
  @override
  @JsonKey(name: 'doctor_patient_count', fromJson: _flexibleStringFromJson)
  String? get doctorPatientCount;
  @override
  @JsonKey(name: 'all_patient_count', fromJson: _flexibleStringFromJson)
  String? get allPatientCount;
  @override
  @JsonKey(name: 'score_value', fromJson: _flexibleStringFromJson)
  String? get scoreValue;
  @override
  @JsonKey(name: 'role')
  String? get role;
  @override
  @JsonKey(name: 'user_type')
  String? get userType;
  @override
  @JsonKey(name: 'permissions_changed')
  bool? get permissionsChanged;
  @override
  @JsonKey(name: 'isUserBlocked')
  bool? get isUserBlocked;
  @override
  @JsonKey(name: 'posts_count', fromJson: _flexibleStringFromJson)
  String? get postsCount;
  @override
  @JsonKey(name: 'saved_posts_count', fromJson: _flexibleStringFromJson)
  String? get savedPosts;
  @override
  @JsonKey(name: 'marked_patient_count', fromJson: _flexibleStringFromJson)
  String? get markedPatientsCount;
  @override
  @JsonKey(name: 'pending_outcome_count', fromJson: _flexibleStringFromJson)
  String? get pendingOutcomeCount;
  @override
  @JsonKey(name: 'draft_count', fromJson: _flexibleStringFromJson)
  String? get draftCount;
  @override
  @JsonKey(name: 'research_insights')
  ResearchInsightsModel? get researchInsights;
  @override
  HomeDataModelResponse? get data;

  /// Create a copy of HomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeModelResponseImplCopyWith<_$HomeModelResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeDataModelResponse _$HomeDataModelResponseFromJson(
    Map<String, dynamic> json) {
  return _HomeDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$HomeDataModelResponse {
  @JsonKey(name: 'all_patients')
  List<PatientHomeDataModel>? get allPatients =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'current_patient')
  List<PatientHomeDataModel>? get currentPatients =>
      throw _privateConstructorUsedError;
  List<DoctorModel>? get topDoctors => throw _privateConstructorUsedError;
  List<DoctorModel>? get pendingSyndicateCard =>
      throw _privateConstructorUsedError;
  List<PostModel>? get posts => throw _privateConstructorUsedError;
  @JsonKey(name: 'feed_posts')
  List<PostCommunityModel>? get feeds => throw _privateConstructorUsedError;
  @JsonKey(name: 'trending_hashtags')
  List<TrendModel>? get trendsHashtags => throw _privateConstructorUsedError;
  @JsonKey(name: 'latest_groups')
  List<GroupModel>? get latestGroups => throw _privateConstructorUsedError;
  @JsonKey(name: 'pending_outcomes')
  List<PatientHomeDataModel>? get pendingOutcomes =>
      throw _privateConstructorUsedError;

  /// Dedicated draft patients when the API provides them; otherwise derive
  /// from [currentPatients] where submit_status is not true.
  @JsonKey(name: 'drafts')
  List<PatientHomeDataModel>? get drafts => throw _privateConstructorUsedError;
  @JsonKey(name: 'pending_consultations')
  List<GetCurrentDoctorConsultationModelResponse>? get pendingConsultations =>
      throw _privateConstructorUsedError;
  List<HomeActivityModel>? get activity => throw _privateConstructorUsedError;
  @JsonKey(name: 'week_recap')
  WeekRecapModel? get weekRecap => throw _privateConstructorUsedError;
  @JsonKey(name: 'research_insights')
  ResearchInsightsModel? get researchInsights =>
      throw _privateConstructorUsedError;

  /// Serializes this HomeDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeDataModelResponseCopyWith<HomeDataModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeDataModelResponseCopyWith<$Res> {
  factory $HomeDataModelResponseCopyWith(HomeDataModelResponse value,
          $Res Function(HomeDataModelResponse) then) =
      _$HomeDataModelResponseCopyWithImpl<$Res, HomeDataModelResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'all_patients') List<PatientHomeDataModel>? allPatients,
      @JsonKey(name: 'current_patient')
      List<PatientHomeDataModel>? currentPatients,
      List<DoctorModel>? topDoctors,
      List<DoctorModel>? pendingSyndicateCard,
      List<PostModel>? posts,
      @JsonKey(name: 'feed_posts') List<PostCommunityModel>? feeds,
      @JsonKey(name: 'trending_hashtags') List<TrendModel>? trendsHashtags,
      @JsonKey(name: 'latest_groups') List<GroupModel>? latestGroups,
      @JsonKey(name: 'pending_outcomes')
      List<PatientHomeDataModel>? pendingOutcomes,
      @JsonKey(name: 'drafts') List<PatientHomeDataModel>? drafts,
      @JsonKey(name: 'pending_consultations')
      List<GetCurrentDoctorConsultationModelResponse>? pendingConsultations,
      List<HomeActivityModel>? activity,
      @JsonKey(name: 'week_recap') WeekRecapModel? weekRecap,
      @JsonKey(name: 'research_insights')
      ResearchInsightsModel? researchInsights});

  $WeekRecapModelCopyWith<$Res>? get weekRecap;
  $ResearchInsightsModelCopyWith<$Res>? get researchInsights;
}

/// @nodoc
class _$HomeDataModelResponseCopyWithImpl<$Res,
        $Val extends HomeDataModelResponse>
    implements $HomeDataModelResponseCopyWith<$Res> {
  _$HomeDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allPatients = freezed,
    Object? currentPatients = freezed,
    Object? topDoctors = freezed,
    Object? pendingSyndicateCard = freezed,
    Object? posts = freezed,
    Object? feeds = freezed,
    Object? trendsHashtags = freezed,
    Object? latestGroups = freezed,
    Object? pendingOutcomes = freezed,
    Object? drafts = freezed,
    Object? pendingConsultations = freezed,
    Object? activity = freezed,
    Object? weekRecap = freezed,
    Object? researchInsights = freezed,
  }) {
    return _then(_value.copyWith(
      allPatients: freezed == allPatients
          ? _value.allPatients
          : allPatients // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      currentPatients: freezed == currentPatients
          ? _value.currentPatients
          : currentPatients // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      topDoctors: freezed == topDoctors
          ? _value.topDoctors
          : topDoctors // ignore: cast_nullable_to_non_nullable
              as List<DoctorModel>?,
      pendingSyndicateCard: freezed == pendingSyndicateCard
          ? _value.pendingSyndicateCard
          : pendingSyndicateCard // ignore: cast_nullable_to_non_nullable
              as List<DoctorModel>?,
      posts: freezed == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>?,
      feeds: freezed == feeds
          ? _value.feeds
          : feeds // ignore: cast_nullable_to_non_nullable
              as List<PostCommunityModel>?,
      trendsHashtags: freezed == trendsHashtags
          ? _value.trendsHashtags
          : trendsHashtags // ignore: cast_nullable_to_non_nullable
              as List<TrendModel>?,
      latestGroups: freezed == latestGroups
          ? _value.latestGroups
          : latestGroups // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>?,
      pendingOutcomes: freezed == pendingOutcomes
          ? _value.pendingOutcomes
          : pendingOutcomes // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      drafts: freezed == drafts
          ? _value.drafts
          : drafts // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      pendingConsultations: freezed == pendingConsultations
          ? _value.pendingConsultations
          : pendingConsultations // ignore: cast_nullable_to_non_nullable
              as List<GetCurrentDoctorConsultationModelResponse>?,
      activity: freezed == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as List<HomeActivityModel>?,
      weekRecap: freezed == weekRecap
          ? _value.weekRecap
          : weekRecap // ignore: cast_nullable_to_non_nullable
              as WeekRecapModel?,
      researchInsights: freezed == researchInsights
          ? _value.researchInsights
          : researchInsights // ignore: cast_nullable_to_non_nullable
              as ResearchInsightsModel?,
    ) as $Val);
  }

  /// Create a copy of HomeDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeekRecapModelCopyWith<$Res>? get weekRecap {
    if (_value.weekRecap == null) {
      return null;
    }

    return $WeekRecapModelCopyWith<$Res>(_value.weekRecap!, (value) {
      return _then(_value.copyWith(weekRecap: value) as $Val);
    });
  }

  /// Create a copy of HomeDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResearchInsightsModelCopyWith<$Res>? get researchInsights {
    if (_value.researchInsights == null) {
      return null;
    }

    return $ResearchInsightsModelCopyWith<$Res>(_value.researchInsights!,
        (value) {
      return _then(_value.copyWith(researchInsights: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeDataModelResponseImplCopyWith<$Res>
    implements $HomeDataModelResponseCopyWith<$Res> {
  factory _$$HomeDataModelResponseImplCopyWith(
          _$HomeDataModelResponseImpl value,
          $Res Function(_$HomeDataModelResponseImpl) then) =
      __$$HomeDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'all_patients') List<PatientHomeDataModel>? allPatients,
      @JsonKey(name: 'current_patient')
      List<PatientHomeDataModel>? currentPatients,
      List<DoctorModel>? topDoctors,
      List<DoctorModel>? pendingSyndicateCard,
      List<PostModel>? posts,
      @JsonKey(name: 'feed_posts') List<PostCommunityModel>? feeds,
      @JsonKey(name: 'trending_hashtags') List<TrendModel>? trendsHashtags,
      @JsonKey(name: 'latest_groups') List<GroupModel>? latestGroups,
      @JsonKey(name: 'pending_outcomes')
      List<PatientHomeDataModel>? pendingOutcomes,
      @JsonKey(name: 'drafts') List<PatientHomeDataModel>? drafts,
      @JsonKey(name: 'pending_consultations')
      List<GetCurrentDoctorConsultationModelResponse>? pendingConsultations,
      List<HomeActivityModel>? activity,
      @JsonKey(name: 'week_recap') WeekRecapModel? weekRecap,
      @JsonKey(name: 'research_insights')
      ResearchInsightsModel? researchInsights});

  @override
  $WeekRecapModelCopyWith<$Res>? get weekRecap;
  @override
  $ResearchInsightsModelCopyWith<$Res>? get researchInsights;
}

/// @nodoc
class __$$HomeDataModelResponseImplCopyWithImpl<$Res>
    extends _$HomeDataModelResponseCopyWithImpl<$Res,
        _$HomeDataModelResponseImpl>
    implements _$$HomeDataModelResponseImplCopyWith<$Res> {
  __$$HomeDataModelResponseImplCopyWithImpl(_$HomeDataModelResponseImpl _value,
      $Res Function(_$HomeDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allPatients = freezed,
    Object? currentPatients = freezed,
    Object? topDoctors = freezed,
    Object? pendingSyndicateCard = freezed,
    Object? posts = freezed,
    Object? feeds = freezed,
    Object? trendsHashtags = freezed,
    Object? latestGroups = freezed,
    Object? pendingOutcomes = freezed,
    Object? drafts = freezed,
    Object? pendingConsultations = freezed,
    Object? activity = freezed,
    Object? weekRecap = freezed,
    Object? researchInsights = freezed,
  }) {
    return _then(_$HomeDataModelResponseImpl(
      allPatients: freezed == allPatients
          ? _value._allPatients
          : allPatients // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      currentPatients: freezed == currentPatients
          ? _value._currentPatients
          : currentPatients // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      topDoctors: freezed == topDoctors
          ? _value._topDoctors
          : topDoctors // ignore: cast_nullable_to_non_nullable
              as List<DoctorModel>?,
      pendingSyndicateCard: freezed == pendingSyndicateCard
          ? _value._pendingSyndicateCard
          : pendingSyndicateCard // ignore: cast_nullable_to_non_nullable
              as List<DoctorModel>?,
      posts: freezed == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>?,
      feeds: freezed == feeds
          ? _value._feeds
          : feeds // ignore: cast_nullable_to_non_nullable
              as List<PostCommunityModel>?,
      trendsHashtags: freezed == trendsHashtags
          ? _value._trendsHashtags
          : trendsHashtags // ignore: cast_nullable_to_non_nullable
              as List<TrendModel>?,
      latestGroups: freezed == latestGroups
          ? _value._latestGroups
          : latestGroups // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>?,
      pendingOutcomes: freezed == pendingOutcomes
          ? _value._pendingOutcomes
          : pendingOutcomes // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      drafts: freezed == drafts
          ? _value._drafts
          : drafts // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      pendingConsultations: freezed == pendingConsultations
          ? _value._pendingConsultations
          : pendingConsultations // ignore: cast_nullable_to_non_nullable
              as List<GetCurrentDoctorConsultationModelResponse>?,
      activity: freezed == activity
          ? _value._activity
          : activity // ignore: cast_nullable_to_non_nullable
              as List<HomeActivityModel>?,
      weekRecap: freezed == weekRecap
          ? _value.weekRecap
          : weekRecap // ignore: cast_nullable_to_non_nullable
              as WeekRecapModel?,
      researchInsights: freezed == researchInsights
          ? _value.researchInsights
          : researchInsights // ignore: cast_nullable_to_non_nullable
              as ResearchInsightsModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeDataModelResponseImpl implements _HomeDataModelResponse {
  const _$HomeDataModelResponseImpl(
      {@JsonKey(name: 'all_patients')
      final List<PatientHomeDataModel>? allPatients,
      @JsonKey(name: 'current_patient')
      final List<PatientHomeDataModel>? currentPatients,
      final List<DoctorModel>? topDoctors,
      final List<DoctorModel>? pendingSyndicateCard,
      final List<PostModel>? posts,
      @JsonKey(name: 'feed_posts') final List<PostCommunityModel>? feeds,
      @JsonKey(name: 'trending_hashtags')
      final List<TrendModel>? trendsHashtags,
      @JsonKey(name: 'latest_groups') final List<GroupModel>? latestGroups,
      @JsonKey(name: 'pending_outcomes')
      final List<PatientHomeDataModel>? pendingOutcomes,
      @JsonKey(name: 'drafts') final List<PatientHomeDataModel>? drafts,
      @JsonKey(name: 'pending_consultations')
      final List<GetCurrentDoctorConsultationModelResponse>?
          pendingConsultations,
      final List<HomeActivityModel>? activity,
      @JsonKey(name: 'week_recap') this.weekRecap,
      @JsonKey(name: 'research_insights') this.researchInsights})
      : _allPatients = allPatients,
        _currentPatients = currentPatients,
        _topDoctors = topDoctors,
        _pendingSyndicateCard = pendingSyndicateCard,
        _posts = posts,
        _feeds = feeds,
        _trendsHashtags = trendsHashtags,
        _latestGroups = latestGroups,
        _pendingOutcomes = pendingOutcomes,
        _drafts = drafts,
        _pendingConsultations = pendingConsultations,
        _activity = activity;

  factory _$HomeDataModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeDataModelResponseImplFromJson(json);

  final List<PatientHomeDataModel>? _allPatients;
  @override
  @JsonKey(name: 'all_patients')
  List<PatientHomeDataModel>? get allPatients {
    final value = _allPatients;
    if (value == null) return null;
    if (_allPatients is EqualUnmodifiableListView) return _allPatients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PatientHomeDataModel>? _currentPatients;
  @override
  @JsonKey(name: 'current_patient')
  List<PatientHomeDataModel>? get currentPatients {
    final value = _currentPatients;
    if (value == null) return null;
    if (_currentPatients is EqualUnmodifiableListView) return _currentPatients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<DoctorModel>? _topDoctors;
  @override
  List<DoctorModel>? get topDoctors {
    final value = _topDoctors;
    if (value == null) return null;
    if (_topDoctors is EqualUnmodifiableListView) return _topDoctors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<DoctorModel>? _pendingSyndicateCard;
  @override
  List<DoctorModel>? get pendingSyndicateCard {
    final value = _pendingSyndicateCard;
    if (value == null) return null;
    if (_pendingSyndicateCard is EqualUnmodifiableListView)
      return _pendingSyndicateCard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PostModel>? _posts;
  @override
  List<PostModel>? get posts {
    final value = _posts;
    if (value == null) return null;
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PostCommunityModel>? _feeds;
  @override
  @JsonKey(name: 'feed_posts')
  List<PostCommunityModel>? get feeds {
    final value = _feeds;
    if (value == null) return null;
    if (_feeds is EqualUnmodifiableListView) return _feeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TrendModel>? _trendsHashtags;
  @override
  @JsonKey(name: 'trending_hashtags')
  List<TrendModel>? get trendsHashtags {
    final value = _trendsHashtags;
    if (value == null) return null;
    if (_trendsHashtags is EqualUnmodifiableListView) return _trendsHashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<GroupModel>? _latestGroups;
  @override
  @JsonKey(name: 'latest_groups')
  List<GroupModel>? get latestGroups {
    final value = _latestGroups;
    if (value == null) return null;
    if (_latestGroups is EqualUnmodifiableListView) return _latestGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PatientHomeDataModel>? _pendingOutcomes;
  @override
  @JsonKey(name: 'pending_outcomes')
  List<PatientHomeDataModel>? get pendingOutcomes {
    final value = _pendingOutcomes;
    if (value == null) return null;
    if (_pendingOutcomes is EqualUnmodifiableListView) return _pendingOutcomes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Dedicated draft patients when the API provides them; otherwise derive
  /// from [currentPatients] where submit_status is not true.
  final List<PatientHomeDataModel>? _drafts;

  /// Dedicated draft patients when the API provides them; otherwise derive
  /// from [currentPatients] where submit_status is not true.
  @override
  @JsonKey(name: 'drafts')
  List<PatientHomeDataModel>? get drafts {
    final value = _drafts;
    if (value == null) return null;
    if (_drafts is EqualUnmodifiableListView) return _drafts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<GetCurrentDoctorConsultationModelResponse>? _pendingConsultations;
  @override
  @JsonKey(name: 'pending_consultations')
  List<GetCurrentDoctorConsultationModelResponse>? get pendingConsultations {
    final value = _pendingConsultations;
    if (value == null) return null;
    if (_pendingConsultations is EqualUnmodifiableListView)
      return _pendingConsultations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<HomeActivityModel>? _activity;
  @override
  List<HomeActivityModel>? get activity {
    final value = _activity;
    if (value == null) return null;
    if (_activity is EqualUnmodifiableListView) return _activity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'week_recap')
  final WeekRecapModel? weekRecap;
  @override
  @JsonKey(name: 'research_insights')
  final ResearchInsightsModel? researchInsights;

  @override
  String toString() {
    return 'HomeDataModelResponse(allPatients: $allPatients, currentPatients: $currentPatients, topDoctors: $topDoctors, pendingSyndicateCard: $pendingSyndicateCard, posts: $posts, feeds: $feeds, trendsHashtags: $trendsHashtags, latestGroups: $latestGroups, pendingOutcomes: $pendingOutcomes, drafts: $drafts, pendingConsultations: $pendingConsultations, activity: $activity, weekRecap: $weekRecap, researchInsights: $researchInsights)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeDataModelResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._allPatients, _allPatients) &&
            const DeepCollectionEquality()
                .equals(other._currentPatients, _currentPatients) &&
            const DeepCollectionEquality()
                .equals(other._topDoctors, _topDoctors) &&
            const DeepCollectionEquality()
                .equals(other._pendingSyndicateCard, _pendingSyndicateCard) &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            const DeepCollectionEquality().equals(other._feeds, _feeds) &&
            const DeepCollectionEquality()
                .equals(other._trendsHashtags, _trendsHashtags) &&
            const DeepCollectionEquality()
                .equals(other._latestGroups, _latestGroups) &&
            const DeepCollectionEquality()
                .equals(other._pendingOutcomes, _pendingOutcomes) &&
            const DeepCollectionEquality().equals(other._drafts, _drafts) &&
            const DeepCollectionEquality()
                .equals(other._pendingConsultations, _pendingConsultations) &&
            const DeepCollectionEquality().equals(other._activity, _activity) &&
            (identical(other.weekRecap, weekRecap) ||
                other.weekRecap == weekRecap) &&
            (identical(other.researchInsights, researchInsights) ||
                other.researchInsights == researchInsights));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allPatients),
      const DeepCollectionEquality().hash(_currentPatients),
      const DeepCollectionEquality().hash(_topDoctors),
      const DeepCollectionEquality().hash(_pendingSyndicateCard),
      const DeepCollectionEquality().hash(_posts),
      const DeepCollectionEquality().hash(_feeds),
      const DeepCollectionEquality().hash(_trendsHashtags),
      const DeepCollectionEquality().hash(_latestGroups),
      const DeepCollectionEquality().hash(_pendingOutcomes),
      const DeepCollectionEquality().hash(_drafts),
      const DeepCollectionEquality().hash(_pendingConsultations),
      const DeepCollectionEquality().hash(_activity),
      weekRecap,
      researchInsights);

  /// Create a copy of HomeDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeDataModelResponseImplCopyWith<_$HomeDataModelResponseImpl>
      get copyWith => __$$HomeDataModelResponseImplCopyWithImpl<
          _$HomeDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _HomeDataModelResponse implements HomeDataModelResponse {
  const factory _HomeDataModelResponse(
          {@JsonKey(name: 'all_patients')
          final List<PatientHomeDataModel>? allPatients,
          @JsonKey(name: 'current_patient')
          final List<PatientHomeDataModel>? currentPatients,
          final List<DoctorModel>? topDoctors,
          final List<DoctorModel>? pendingSyndicateCard,
          final List<PostModel>? posts,
          @JsonKey(name: 'feed_posts') final List<PostCommunityModel>? feeds,
          @JsonKey(name: 'trending_hashtags')
          final List<TrendModel>? trendsHashtags,
          @JsonKey(name: 'latest_groups') final List<GroupModel>? latestGroups,
          @JsonKey(name: 'pending_outcomes')
          final List<PatientHomeDataModel>? pendingOutcomes,
          @JsonKey(name: 'drafts') final List<PatientHomeDataModel>? drafts,
          @JsonKey(name: 'pending_consultations')
          final List<GetCurrentDoctorConsultationModelResponse>?
              pendingConsultations,
          final List<HomeActivityModel>? activity,
          @JsonKey(name: 'week_recap') final WeekRecapModel? weekRecap,
          @JsonKey(name: 'research_insights')
          final ResearchInsightsModel? researchInsights}) =
      _$HomeDataModelResponseImpl;

  factory _HomeDataModelResponse.fromJson(Map<String, dynamic> json) =
      _$HomeDataModelResponseImpl.fromJson;

  @override
  @JsonKey(name: 'all_patients')
  List<PatientHomeDataModel>? get allPatients;
  @override
  @JsonKey(name: 'current_patient')
  List<PatientHomeDataModel>? get currentPatients;
  @override
  List<DoctorModel>? get topDoctors;
  @override
  List<DoctorModel>? get pendingSyndicateCard;
  @override
  List<PostModel>? get posts;
  @override
  @JsonKey(name: 'feed_posts')
  List<PostCommunityModel>? get feeds;
  @override
  @JsonKey(name: 'trending_hashtags')
  List<TrendModel>? get trendsHashtags;
  @override
  @JsonKey(name: 'latest_groups')
  List<GroupModel>? get latestGroups;
  @override
  @JsonKey(name: 'pending_outcomes')
  List<PatientHomeDataModel>? get pendingOutcomes;

  /// Dedicated draft patients when the API provides them; otherwise derive
  /// from [currentPatients] where submit_status is not true.
  @override
  @JsonKey(name: 'drafts')
  List<PatientHomeDataModel>? get drafts;
  @override
  @JsonKey(name: 'pending_consultations')
  List<GetCurrentDoctorConsultationModelResponse>? get pendingConsultations;
  @override
  List<HomeActivityModel>? get activity;
  @override
  @JsonKey(name: 'week_recap')
  WeekRecapModel? get weekRecap;
  @override
  @JsonKey(name: 'research_insights')
  ResearchInsightsModel? get researchInsights;

  /// Create a copy of HomeDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeDataModelResponseImplCopyWith<_$HomeDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ResearchInsightsModel _$ResearchInsightsModelFromJson(
    Map<String, dynamic> json) {
  return _ResearchInsightsModel.fromJson(json);
}

/// @nodoc
mixin _$ResearchInsightsModel {
  ResearchPopulationModel? get population => throw _privateConstructorUsedError;
  @JsonKey(name: 'aki_incidence_pct', fromJson: _flexibleNumFromJson)
  num? get akiIncidencePct => throw _privateConstructorUsedError;
  @JsonKey(name: 'aki_incidence_delta_pct', fromJson: _flexibleNumFromJson)
  num? get akiIncidenceDeltaPct => throw _privateConstructorUsedError;
  @JsonKey(name: 'most_common_cause')
  String? get mostCommonCause => throw _privateConstructorUsedError;
  @JsonKey(name: 'most_common_cause_pct', fromJson: _flexibleNumFromJson)
  num? get mostCommonCausePct => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_egfr_at_admission', fromJson: _flexibleNumFromJson)
  num? get avgEgfrAtAdmission => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_egfr_at_admission_delta', fromJson: _flexibleNumFromJson)
  num? get avgEgfrAtAdmissionDelta => throw _privateConstructorUsedError;
  @JsonKey(name: 'computed_at')
  String? get computedAt => throw _privateConstructorUsedError;

  /// Serializes this ResearchInsightsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResearchInsightsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResearchInsightsModelCopyWith<ResearchInsightsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResearchInsightsModelCopyWith<$Res> {
  factory $ResearchInsightsModelCopyWith(ResearchInsightsModel value,
          $Res Function(ResearchInsightsModel) then) =
      _$ResearchInsightsModelCopyWithImpl<$Res, ResearchInsightsModel>;
  @useResult
  $Res call(
      {ResearchPopulationModel? population,
      @JsonKey(name: 'aki_incidence_pct', fromJson: _flexibleNumFromJson)
      num? akiIncidencePct,
      @JsonKey(name: 'aki_incidence_delta_pct', fromJson: _flexibleNumFromJson)
      num? akiIncidenceDeltaPct,
      @JsonKey(name: 'most_common_cause') String? mostCommonCause,
      @JsonKey(name: 'most_common_cause_pct', fromJson: _flexibleNumFromJson)
      num? mostCommonCausePct,
      @JsonKey(name: 'avg_egfr_at_admission', fromJson: _flexibleNumFromJson)
      num? avgEgfrAtAdmission,
      @JsonKey(
          name: 'avg_egfr_at_admission_delta', fromJson: _flexibleNumFromJson)
      num? avgEgfrAtAdmissionDelta,
      @JsonKey(name: 'computed_at') String? computedAt});

  $ResearchPopulationModelCopyWith<$Res>? get population;
}

/// @nodoc
class _$ResearchInsightsModelCopyWithImpl<$Res,
        $Val extends ResearchInsightsModel>
    implements $ResearchInsightsModelCopyWith<$Res> {
  _$ResearchInsightsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResearchInsightsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? population = freezed,
    Object? akiIncidencePct = freezed,
    Object? akiIncidenceDeltaPct = freezed,
    Object? mostCommonCause = freezed,
    Object? mostCommonCausePct = freezed,
    Object? avgEgfrAtAdmission = freezed,
    Object? avgEgfrAtAdmissionDelta = freezed,
    Object? computedAt = freezed,
  }) {
    return _then(_value.copyWith(
      population: freezed == population
          ? _value.population
          : population // ignore: cast_nullable_to_non_nullable
              as ResearchPopulationModel?,
      akiIncidencePct: freezed == akiIncidencePct
          ? _value.akiIncidencePct
          : akiIncidencePct // ignore: cast_nullable_to_non_nullable
              as num?,
      akiIncidenceDeltaPct: freezed == akiIncidenceDeltaPct
          ? _value.akiIncidenceDeltaPct
          : akiIncidenceDeltaPct // ignore: cast_nullable_to_non_nullable
              as num?,
      mostCommonCause: freezed == mostCommonCause
          ? _value.mostCommonCause
          : mostCommonCause // ignore: cast_nullable_to_non_nullable
              as String?,
      mostCommonCausePct: freezed == mostCommonCausePct
          ? _value.mostCommonCausePct
          : mostCommonCausePct // ignore: cast_nullable_to_non_nullable
              as num?,
      avgEgfrAtAdmission: freezed == avgEgfrAtAdmission
          ? _value.avgEgfrAtAdmission
          : avgEgfrAtAdmission // ignore: cast_nullable_to_non_nullable
              as num?,
      avgEgfrAtAdmissionDelta: freezed == avgEgfrAtAdmissionDelta
          ? _value.avgEgfrAtAdmissionDelta
          : avgEgfrAtAdmissionDelta // ignore: cast_nullable_to_non_nullable
              as num?,
      computedAt: freezed == computedAt
          ? _value.computedAt
          : computedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ResearchInsightsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResearchPopulationModelCopyWith<$Res>? get population {
    if (_value.population == null) {
      return null;
    }

    return $ResearchPopulationModelCopyWith<$Res>(_value.population!, (value) {
      return _then(_value.copyWith(population: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ResearchInsightsModelImplCopyWith<$Res>
    implements $ResearchInsightsModelCopyWith<$Res> {
  factory _$$ResearchInsightsModelImplCopyWith(
          _$ResearchInsightsModelImpl value,
          $Res Function(_$ResearchInsightsModelImpl) then) =
      __$$ResearchInsightsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ResearchPopulationModel? population,
      @JsonKey(name: 'aki_incidence_pct', fromJson: _flexibleNumFromJson)
      num? akiIncidencePct,
      @JsonKey(name: 'aki_incidence_delta_pct', fromJson: _flexibleNumFromJson)
      num? akiIncidenceDeltaPct,
      @JsonKey(name: 'most_common_cause') String? mostCommonCause,
      @JsonKey(name: 'most_common_cause_pct', fromJson: _flexibleNumFromJson)
      num? mostCommonCausePct,
      @JsonKey(name: 'avg_egfr_at_admission', fromJson: _flexibleNumFromJson)
      num? avgEgfrAtAdmission,
      @JsonKey(
          name: 'avg_egfr_at_admission_delta', fromJson: _flexibleNumFromJson)
      num? avgEgfrAtAdmissionDelta,
      @JsonKey(name: 'computed_at') String? computedAt});

  @override
  $ResearchPopulationModelCopyWith<$Res>? get population;
}

/// @nodoc
class __$$ResearchInsightsModelImplCopyWithImpl<$Res>
    extends _$ResearchInsightsModelCopyWithImpl<$Res,
        _$ResearchInsightsModelImpl>
    implements _$$ResearchInsightsModelImplCopyWith<$Res> {
  __$$ResearchInsightsModelImplCopyWithImpl(_$ResearchInsightsModelImpl _value,
      $Res Function(_$ResearchInsightsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResearchInsightsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? population = freezed,
    Object? akiIncidencePct = freezed,
    Object? akiIncidenceDeltaPct = freezed,
    Object? mostCommonCause = freezed,
    Object? mostCommonCausePct = freezed,
    Object? avgEgfrAtAdmission = freezed,
    Object? avgEgfrAtAdmissionDelta = freezed,
    Object? computedAt = freezed,
  }) {
    return _then(_$ResearchInsightsModelImpl(
      population: freezed == population
          ? _value.population
          : population // ignore: cast_nullable_to_non_nullable
              as ResearchPopulationModel?,
      akiIncidencePct: freezed == akiIncidencePct
          ? _value.akiIncidencePct
          : akiIncidencePct // ignore: cast_nullable_to_non_nullable
              as num?,
      akiIncidenceDeltaPct: freezed == akiIncidenceDeltaPct
          ? _value.akiIncidenceDeltaPct
          : akiIncidenceDeltaPct // ignore: cast_nullable_to_non_nullable
              as num?,
      mostCommonCause: freezed == mostCommonCause
          ? _value.mostCommonCause
          : mostCommonCause // ignore: cast_nullable_to_non_nullable
              as String?,
      mostCommonCausePct: freezed == mostCommonCausePct
          ? _value.mostCommonCausePct
          : mostCommonCausePct // ignore: cast_nullable_to_non_nullable
              as num?,
      avgEgfrAtAdmission: freezed == avgEgfrAtAdmission
          ? _value.avgEgfrAtAdmission
          : avgEgfrAtAdmission // ignore: cast_nullable_to_non_nullable
              as num?,
      avgEgfrAtAdmissionDelta: freezed == avgEgfrAtAdmissionDelta
          ? _value.avgEgfrAtAdmissionDelta
          : avgEgfrAtAdmissionDelta // ignore: cast_nullable_to_non_nullable
              as num?,
      computedAt: freezed == computedAt
          ? _value.computedAt
          : computedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResearchInsightsModelImpl implements _ResearchInsightsModel {
  const _$ResearchInsightsModelImpl(
      {this.population,
      @JsonKey(name: 'aki_incidence_pct', fromJson: _flexibleNumFromJson)
      this.akiIncidencePct,
      @JsonKey(name: 'aki_incidence_delta_pct', fromJson: _flexibleNumFromJson)
      this.akiIncidenceDeltaPct,
      @JsonKey(name: 'most_common_cause') this.mostCommonCause,
      @JsonKey(name: 'most_common_cause_pct', fromJson: _flexibleNumFromJson)
      this.mostCommonCausePct,
      @JsonKey(name: 'avg_egfr_at_admission', fromJson: _flexibleNumFromJson)
      this.avgEgfrAtAdmission,
      @JsonKey(
          name: 'avg_egfr_at_admission_delta', fromJson: _flexibleNumFromJson)
      this.avgEgfrAtAdmissionDelta,
      @JsonKey(name: 'computed_at') this.computedAt});

  factory _$ResearchInsightsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResearchInsightsModelImplFromJson(json);

  @override
  final ResearchPopulationModel? population;
  @override
  @JsonKey(name: 'aki_incidence_pct', fromJson: _flexibleNumFromJson)
  final num? akiIncidencePct;
  @override
  @JsonKey(name: 'aki_incidence_delta_pct', fromJson: _flexibleNumFromJson)
  final num? akiIncidenceDeltaPct;
  @override
  @JsonKey(name: 'most_common_cause')
  final String? mostCommonCause;
  @override
  @JsonKey(name: 'most_common_cause_pct', fromJson: _flexibleNumFromJson)
  final num? mostCommonCausePct;
  @override
  @JsonKey(name: 'avg_egfr_at_admission', fromJson: _flexibleNumFromJson)
  final num? avgEgfrAtAdmission;
  @override
  @JsonKey(name: 'avg_egfr_at_admission_delta', fromJson: _flexibleNumFromJson)
  final num? avgEgfrAtAdmissionDelta;
  @override
  @JsonKey(name: 'computed_at')
  final String? computedAt;

  @override
  String toString() {
    return 'ResearchInsightsModel(population: $population, akiIncidencePct: $akiIncidencePct, akiIncidenceDeltaPct: $akiIncidenceDeltaPct, mostCommonCause: $mostCommonCause, mostCommonCausePct: $mostCommonCausePct, avgEgfrAtAdmission: $avgEgfrAtAdmission, avgEgfrAtAdmissionDelta: $avgEgfrAtAdmissionDelta, computedAt: $computedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResearchInsightsModelImpl &&
            (identical(other.population, population) ||
                other.population == population) &&
            (identical(other.akiIncidencePct, akiIncidencePct) ||
                other.akiIncidencePct == akiIncidencePct) &&
            (identical(other.akiIncidenceDeltaPct, akiIncidenceDeltaPct) ||
                other.akiIncidenceDeltaPct == akiIncidenceDeltaPct) &&
            (identical(other.mostCommonCause, mostCommonCause) ||
                other.mostCommonCause == mostCommonCause) &&
            (identical(other.mostCommonCausePct, mostCommonCausePct) ||
                other.mostCommonCausePct == mostCommonCausePct) &&
            (identical(other.avgEgfrAtAdmission, avgEgfrAtAdmission) ||
                other.avgEgfrAtAdmission == avgEgfrAtAdmission) &&
            (identical(
                    other.avgEgfrAtAdmissionDelta, avgEgfrAtAdmissionDelta) ||
                other.avgEgfrAtAdmissionDelta == avgEgfrAtAdmissionDelta) &&
            (identical(other.computedAt, computedAt) ||
                other.computedAt == computedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      population,
      akiIncidencePct,
      akiIncidenceDeltaPct,
      mostCommonCause,
      mostCommonCausePct,
      avgEgfrAtAdmission,
      avgEgfrAtAdmissionDelta,
      computedAt);

  /// Create a copy of ResearchInsightsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResearchInsightsModelImplCopyWith<_$ResearchInsightsModelImpl>
      get copyWith => __$$ResearchInsightsModelImplCopyWithImpl<
          _$ResearchInsightsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResearchInsightsModelImplToJson(
      this,
    );
  }
}

abstract class _ResearchInsightsModel implements ResearchInsightsModel {
  const factory _ResearchInsightsModel(
      {final ResearchPopulationModel? population,
      @JsonKey(name: 'aki_incidence_pct', fromJson: _flexibleNumFromJson)
      final num? akiIncidencePct,
      @JsonKey(name: 'aki_incidence_delta_pct', fromJson: _flexibleNumFromJson)
      final num? akiIncidenceDeltaPct,
      @JsonKey(name: 'most_common_cause') final String? mostCommonCause,
      @JsonKey(name: 'most_common_cause_pct', fromJson: _flexibleNumFromJson)
      final num? mostCommonCausePct,
      @JsonKey(name: 'avg_egfr_at_admission', fromJson: _flexibleNumFromJson)
      final num? avgEgfrAtAdmission,
      @JsonKey(
          name: 'avg_egfr_at_admission_delta', fromJson: _flexibleNumFromJson)
      final num? avgEgfrAtAdmissionDelta,
      @JsonKey(name: 'computed_at')
      final String? computedAt}) = _$ResearchInsightsModelImpl;

  factory _ResearchInsightsModel.fromJson(Map<String, dynamic> json) =
      _$ResearchInsightsModelImpl.fromJson;

  @override
  ResearchPopulationModel? get population;
  @override
  @JsonKey(name: 'aki_incidence_pct', fromJson: _flexibleNumFromJson)
  num? get akiIncidencePct;
  @override
  @JsonKey(name: 'aki_incidence_delta_pct', fromJson: _flexibleNumFromJson)
  num? get akiIncidenceDeltaPct;
  @override
  @JsonKey(name: 'most_common_cause')
  String? get mostCommonCause;
  @override
  @JsonKey(name: 'most_common_cause_pct', fromJson: _flexibleNumFromJson)
  num? get mostCommonCausePct;
  @override
  @JsonKey(name: 'avg_egfr_at_admission', fromJson: _flexibleNumFromJson)
  num? get avgEgfrAtAdmission;
  @override
  @JsonKey(name: 'avg_egfr_at_admission_delta', fromJson: _flexibleNumFromJson)
  num? get avgEgfrAtAdmissionDelta;
  @override
  @JsonKey(name: 'computed_at')
  String? get computedAt;

  /// Create a copy of ResearchInsightsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResearchInsightsModelImplCopyWith<_$ResearchInsightsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ResearchPopulationModel _$ResearchPopulationModelFromJson(
    Map<String, dynamic> json) {
  return _ResearchPopulationModel.fromJson(json);
}

/// @nodoc
mixin _$ResearchPopulationModel {
  @JsonKey(name: 'patient_count', fromJson: _flexibleNumFromJson)
  num? get patientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'hospital_count', fromJson: _flexibleNumFromJson)
  num? get hospitalCount => throw _privateConstructorUsedError;

  /// Serializes this ResearchPopulationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResearchPopulationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResearchPopulationModelCopyWith<ResearchPopulationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResearchPopulationModelCopyWith<$Res> {
  factory $ResearchPopulationModelCopyWith(ResearchPopulationModel value,
          $Res Function(ResearchPopulationModel) then) =
      _$ResearchPopulationModelCopyWithImpl<$Res, ResearchPopulationModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'patient_count', fromJson: _flexibleNumFromJson)
      num? patientCount,
      @JsonKey(name: 'hospital_count', fromJson: _flexibleNumFromJson)
      num? hospitalCount});
}

/// @nodoc
class _$ResearchPopulationModelCopyWithImpl<$Res,
        $Val extends ResearchPopulationModel>
    implements $ResearchPopulationModelCopyWith<$Res> {
  _$ResearchPopulationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResearchPopulationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientCount = freezed,
    Object? hospitalCount = freezed,
  }) {
    return _then(_value.copyWith(
      patientCount: freezed == patientCount
          ? _value.patientCount
          : patientCount // ignore: cast_nullable_to_non_nullable
              as num?,
      hospitalCount: freezed == hospitalCount
          ? _value.hospitalCount
          : hospitalCount // ignore: cast_nullable_to_non_nullable
              as num?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResearchPopulationModelImplCopyWith<$Res>
    implements $ResearchPopulationModelCopyWith<$Res> {
  factory _$$ResearchPopulationModelImplCopyWith(
          _$ResearchPopulationModelImpl value,
          $Res Function(_$ResearchPopulationModelImpl) then) =
      __$$ResearchPopulationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'patient_count', fromJson: _flexibleNumFromJson)
      num? patientCount,
      @JsonKey(name: 'hospital_count', fromJson: _flexibleNumFromJson)
      num? hospitalCount});
}

/// @nodoc
class __$$ResearchPopulationModelImplCopyWithImpl<$Res>
    extends _$ResearchPopulationModelCopyWithImpl<$Res,
        _$ResearchPopulationModelImpl>
    implements _$$ResearchPopulationModelImplCopyWith<$Res> {
  __$$ResearchPopulationModelImplCopyWithImpl(
      _$ResearchPopulationModelImpl _value,
      $Res Function(_$ResearchPopulationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResearchPopulationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientCount = freezed,
    Object? hospitalCount = freezed,
  }) {
    return _then(_$ResearchPopulationModelImpl(
      patientCount: freezed == patientCount
          ? _value.patientCount
          : patientCount // ignore: cast_nullable_to_non_nullable
              as num?,
      hospitalCount: freezed == hospitalCount
          ? _value.hospitalCount
          : hospitalCount // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResearchPopulationModelImpl implements _ResearchPopulationModel {
  const _$ResearchPopulationModelImpl(
      {@JsonKey(name: 'patient_count', fromJson: _flexibleNumFromJson)
      this.patientCount,
      @JsonKey(name: 'hospital_count', fromJson: _flexibleNumFromJson)
      this.hospitalCount});

  factory _$ResearchPopulationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResearchPopulationModelImplFromJson(json);

  @override
  @JsonKey(name: 'patient_count', fromJson: _flexibleNumFromJson)
  final num? patientCount;
  @override
  @JsonKey(name: 'hospital_count', fromJson: _flexibleNumFromJson)
  final num? hospitalCount;

  @override
  String toString() {
    return 'ResearchPopulationModel(patientCount: $patientCount, hospitalCount: $hospitalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResearchPopulationModelImpl &&
            (identical(other.patientCount, patientCount) ||
                other.patientCount == patientCount) &&
            (identical(other.hospitalCount, hospitalCount) ||
                other.hospitalCount == hospitalCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, patientCount, hospitalCount);

  /// Create a copy of ResearchPopulationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResearchPopulationModelImplCopyWith<_$ResearchPopulationModelImpl>
      get copyWith => __$$ResearchPopulationModelImplCopyWithImpl<
          _$ResearchPopulationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResearchPopulationModelImplToJson(
      this,
    );
  }
}

abstract class _ResearchPopulationModel implements ResearchPopulationModel {
  const factory _ResearchPopulationModel(
      {@JsonKey(name: 'patient_count', fromJson: _flexibleNumFromJson)
      final num? patientCount,
      @JsonKey(name: 'hospital_count', fromJson: _flexibleNumFromJson)
      final num? hospitalCount}) = _$ResearchPopulationModelImpl;

  factory _ResearchPopulationModel.fromJson(Map<String, dynamic> json) =
      _$ResearchPopulationModelImpl.fromJson;

  @override
  @JsonKey(name: 'patient_count', fromJson: _flexibleNumFromJson)
  num? get patientCount;
  @override
  @JsonKey(name: 'hospital_count', fromJson: _flexibleNumFromJson)
  num? get hospitalCount;

  /// Create a copy of ResearchPopulationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResearchPopulationModelImplCopyWith<_$ResearchPopulationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WeekRecapModel _$WeekRecapModelFromJson(Map<String, dynamic> json) {
  return _WeekRecapModel.fromJson(json);
}

/// @nodoc
mixin _$WeekRecapModel {
  String? get from => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;
  @JsonKey(name: 'patients_added', fromJson: _flexibleIntFromJson)
  int? get patientsAdded => throw _privateConstructorUsedError;
  @JsonKey(name: 'all_patients_added', fromJson: _flexibleIntFromJson)
  int? get allPatientsAdded => throw _privateConstructorUsedError;
  @JsonKey(name: 'outcomes_submitted', fromJson: _flexibleIntFromJson)
  int? get outcomesSubmitted => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'points_earned',
      readValue: _readPointsEarned,
      fromJson: _flexibleIntFromJson)
  int? get pointsEarned => throw _privateConstructorUsedError;

  /// Serializes this WeekRecapModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeekRecapModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeekRecapModelCopyWith<WeekRecapModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeekRecapModelCopyWith<$Res> {
  factory $WeekRecapModelCopyWith(
          WeekRecapModel value, $Res Function(WeekRecapModel) then) =
      _$WeekRecapModelCopyWithImpl<$Res, WeekRecapModel>;
  @useResult
  $Res call(
      {String? from,
      String? to,
      @JsonKey(name: 'patients_added', fromJson: _flexibleIntFromJson)
      int? patientsAdded,
      @JsonKey(name: 'all_patients_added', fromJson: _flexibleIntFromJson)
      int? allPatientsAdded,
      @JsonKey(name: 'outcomes_submitted', fromJson: _flexibleIntFromJson)
      int? outcomesSubmitted,
      @JsonKey(
          name: 'points_earned',
          readValue: _readPointsEarned,
          fromJson: _flexibleIntFromJson)
      int? pointsEarned});
}

/// @nodoc
class _$WeekRecapModelCopyWithImpl<$Res, $Val extends WeekRecapModel>
    implements $WeekRecapModelCopyWith<$Res> {
  _$WeekRecapModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeekRecapModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = freezed,
    Object? to = freezed,
    Object? patientsAdded = freezed,
    Object? allPatientsAdded = freezed,
    Object? outcomesSubmitted = freezed,
    Object? pointsEarned = freezed,
  }) {
    return _then(_value.copyWith(
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      patientsAdded: freezed == patientsAdded
          ? _value.patientsAdded
          : patientsAdded // ignore: cast_nullable_to_non_nullable
              as int?,
      allPatientsAdded: freezed == allPatientsAdded
          ? _value.allPatientsAdded
          : allPatientsAdded // ignore: cast_nullable_to_non_nullable
              as int?,
      outcomesSubmitted: freezed == outcomesSubmitted
          ? _value.outcomesSubmitted
          : outcomesSubmitted // ignore: cast_nullable_to_non_nullable
              as int?,
      pointsEarned: freezed == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeekRecapModelImplCopyWith<$Res>
    implements $WeekRecapModelCopyWith<$Res> {
  factory _$$WeekRecapModelImplCopyWith(_$WeekRecapModelImpl value,
          $Res Function(_$WeekRecapModelImpl) then) =
      __$$WeekRecapModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? from,
      String? to,
      @JsonKey(name: 'patients_added', fromJson: _flexibleIntFromJson)
      int? patientsAdded,
      @JsonKey(name: 'all_patients_added', fromJson: _flexibleIntFromJson)
      int? allPatientsAdded,
      @JsonKey(name: 'outcomes_submitted', fromJson: _flexibleIntFromJson)
      int? outcomesSubmitted,
      @JsonKey(
          name: 'points_earned',
          readValue: _readPointsEarned,
          fromJson: _flexibleIntFromJson)
      int? pointsEarned});
}

/// @nodoc
class __$$WeekRecapModelImplCopyWithImpl<$Res>
    extends _$WeekRecapModelCopyWithImpl<$Res, _$WeekRecapModelImpl>
    implements _$$WeekRecapModelImplCopyWith<$Res> {
  __$$WeekRecapModelImplCopyWithImpl(
      _$WeekRecapModelImpl _value, $Res Function(_$WeekRecapModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeekRecapModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = freezed,
    Object? to = freezed,
    Object? patientsAdded = freezed,
    Object? allPatientsAdded = freezed,
    Object? outcomesSubmitted = freezed,
    Object? pointsEarned = freezed,
  }) {
    return _then(_$WeekRecapModelImpl(
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      patientsAdded: freezed == patientsAdded
          ? _value.patientsAdded
          : patientsAdded // ignore: cast_nullable_to_non_nullable
              as int?,
      allPatientsAdded: freezed == allPatientsAdded
          ? _value.allPatientsAdded
          : allPatientsAdded // ignore: cast_nullable_to_non_nullable
              as int?,
      outcomesSubmitted: freezed == outcomesSubmitted
          ? _value.outcomesSubmitted
          : outcomesSubmitted // ignore: cast_nullable_to_non_nullable
              as int?,
      pointsEarned: freezed == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeekRecapModelImpl implements _WeekRecapModel {
  const _$WeekRecapModelImpl(
      {this.from,
      this.to,
      @JsonKey(name: 'patients_added', fromJson: _flexibleIntFromJson)
      this.patientsAdded,
      @JsonKey(name: 'all_patients_added', fromJson: _flexibleIntFromJson)
      this.allPatientsAdded,
      @JsonKey(name: 'outcomes_submitted', fromJson: _flexibleIntFromJson)
      this.outcomesSubmitted,
      @JsonKey(
          name: 'points_earned',
          readValue: _readPointsEarned,
          fromJson: _flexibleIntFromJson)
      this.pointsEarned});

  factory _$WeekRecapModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeekRecapModelImplFromJson(json);

  @override
  final String? from;
  @override
  final String? to;
  @override
  @JsonKey(name: 'patients_added', fromJson: _flexibleIntFromJson)
  final int? patientsAdded;
  @override
  @JsonKey(name: 'all_patients_added', fromJson: _flexibleIntFromJson)
  final int? allPatientsAdded;
  @override
  @JsonKey(name: 'outcomes_submitted', fromJson: _flexibleIntFromJson)
  final int? outcomesSubmitted;
  @override
  @JsonKey(
      name: 'points_earned',
      readValue: _readPointsEarned,
      fromJson: _flexibleIntFromJson)
  final int? pointsEarned;

  @override
  String toString() {
    return 'WeekRecapModel(from: $from, to: $to, patientsAdded: $patientsAdded, allPatientsAdded: $allPatientsAdded, outcomesSubmitted: $outcomesSubmitted, pointsEarned: $pointsEarned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeekRecapModelImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.patientsAdded, patientsAdded) ||
                other.patientsAdded == patientsAdded) &&
            (identical(other.allPatientsAdded, allPatientsAdded) ||
                other.allPatientsAdded == allPatientsAdded) &&
            (identical(other.outcomesSubmitted, outcomesSubmitted) ||
                other.outcomesSubmitted == outcomesSubmitted) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, from, to, patientsAdded,
      allPatientsAdded, outcomesSubmitted, pointsEarned);

  /// Create a copy of WeekRecapModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeekRecapModelImplCopyWith<_$WeekRecapModelImpl> get copyWith =>
      __$$WeekRecapModelImplCopyWithImpl<_$WeekRecapModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeekRecapModelImplToJson(
      this,
    );
  }
}

abstract class _WeekRecapModel implements WeekRecapModel {
  const factory _WeekRecapModel(
      {final String? from,
      final String? to,
      @JsonKey(name: 'patients_added', fromJson: _flexibleIntFromJson)
      final int? patientsAdded,
      @JsonKey(name: 'all_patients_added', fromJson: _flexibleIntFromJson)
      final int? allPatientsAdded,
      @JsonKey(name: 'outcomes_submitted', fromJson: _flexibleIntFromJson)
      final int? outcomesSubmitted,
      @JsonKey(
          name: 'points_earned',
          readValue: _readPointsEarned,
          fromJson: _flexibleIntFromJson)
      final int? pointsEarned}) = _$WeekRecapModelImpl;

  factory _WeekRecapModel.fromJson(Map<String, dynamic> json) =
      _$WeekRecapModelImpl.fromJson;

  @override
  String? get from;
  @override
  String? get to;
  @override
  @JsonKey(name: 'patients_added', fromJson: _flexibleIntFromJson)
  int? get patientsAdded;
  @override
  @JsonKey(name: 'all_patients_added', fromJson: _flexibleIntFromJson)
  int? get allPatientsAdded;
  @override
  @JsonKey(name: 'outcomes_submitted', fromJson: _flexibleIntFromJson)
  int? get outcomesSubmitted;
  @override
  @JsonKey(
      name: 'points_earned',
      readValue: _readPointsEarned,
      fromJson: _flexibleIntFromJson)
  int? get pointsEarned;

  /// Create a copy of WeekRecapModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeekRecapModelImplCopyWith<_$WeekRecapModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PatientHomeDataModel _$PatientHomeDataModelFromJson(Map<String, dynamic> json) {
  return _PatientHomeDataModel.fromJson(json);
}

/// @nodoc
mixin _$PatientHomeDataModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get hospital => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleNumFromJson)
  num? get age => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleNumFromJson)
  num? get egfr => throw _privateConstructorUsedError;
  @JsonKey(name: 'egfr_previous', fromJson: _flexibleNumFromJson)
  num? get egfrPrevious => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _flexibleNumFromJson)
  num? get bmi => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  DoctorModel? get doctor => throw _privateConstructorUsedError;
  SectionHomeDataModel? get sections => throw _privateConstructorUsedError;
  @JsonKey(name: 'sections_completed')
  int? get sectionsCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'sections_total')
  int? get sectionsTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'sections_last_updated_at')
  String? get sectionsLastUpdatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_section')
  NextSectionModel? get nextSection => throw _privateConstructorUsedError;

  /// Serializes this PatientHomeDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatientHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientHomeDataModelCopyWith<PatientHomeDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientHomeDataModelCopyWith<$Res> {
  factory $PatientHomeDataModelCopyWith(PatientHomeDataModel value,
          $Res Function(PatientHomeDataModel) then) =
      _$PatientHomeDataModelCopyWithImpl<$Res, PatientHomeDataModel>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? hospital,
      @JsonKey(fromJson: _flexibleNumFromJson) num? age,
      @JsonKey(fromJson: _flexibleNumFromJson) num? egfr,
      @JsonKey(name: 'egfr_previous', fromJson: _flexibleNumFromJson)
      num? egfrPrevious,
      @JsonKey(fromJson: _flexibleNumFromJson) num? bmi,
      @JsonKey(name: 'updated_at') String? updatedAt,
      DoctorModel? doctor,
      SectionHomeDataModel? sections,
      @JsonKey(name: 'sections_completed') int? sectionsCompleted,
      @JsonKey(name: 'sections_total') int? sectionsTotal,
      @JsonKey(name: 'sections_last_updated_at') String? sectionsLastUpdatedAt,
      @JsonKey(name: 'next_section') NextSectionModel? nextSection});

  $DoctorModelCopyWith<$Res>? get doctor;
  $SectionHomeDataModelCopyWith<$Res>? get sections;
  $NextSectionModelCopyWith<$Res>? get nextSection;
}

/// @nodoc
class _$PatientHomeDataModelCopyWithImpl<$Res,
        $Val extends PatientHomeDataModel>
    implements $PatientHomeDataModelCopyWith<$Res> {
  _$PatientHomeDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? hospital = freezed,
    Object? age = freezed,
    Object? egfr = freezed,
    Object? egfrPrevious = freezed,
    Object? bmi = freezed,
    Object? updatedAt = freezed,
    Object? doctor = freezed,
    Object? sections = freezed,
    Object? sectionsCompleted = freezed,
    Object? sectionsTotal = freezed,
    Object? sectionsLastUpdatedAt = freezed,
    Object? nextSection = freezed,
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
      hospital: freezed == hospital
          ? _value.hospital
          : hospital // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as num?,
      egfr: freezed == egfr
          ? _value.egfr
          : egfr // ignore: cast_nullable_to_non_nullable
              as num?,
      egfrPrevious: freezed == egfrPrevious
          ? _value.egfrPrevious
          : egfrPrevious // ignore: cast_nullable_to_non_nullable
              as num?,
      bmi: freezed == bmi
          ? _value.bmi
          : bmi // ignore: cast_nullable_to_non_nullable
              as num?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      sections: freezed == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as SectionHomeDataModel?,
      sectionsCompleted: freezed == sectionsCompleted
          ? _value.sectionsCompleted
          : sectionsCompleted // ignore: cast_nullable_to_non_nullable
              as int?,
      sectionsTotal: freezed == sectionsTotal
          ? _value.sectionsTotal
          : sectionsTotal // ignore: cast_nullable_to_non_nullable
              as int?,
      sectionsLastUpdatedAt: freezed == sectionsLastUpdatedAt
          ? _value.sectionsLastUpdatedAt
          : sectionsLastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      nextSection: freezed == nextSection
          ? _value.nextSection
          : nextSection // ignore: cast_nullable_to_non_nullable
              as NextSectionModel?,
    ) as $Val);
  }

  /// Create a copy of PatientHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DoctorModelCopyWith<$Res>? get doctor {
    if (_value.doctor == null) {
      return null;
    }

    return $DoctorModelCopyWith<$Res>(_value.doctor!, (value) {
      return _then(_value.copyWith(doctor: value) as $Val);
    });
  }

  /// Create a copy of PatientHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SectionHomeDataModelCopyWith<$Res>? get sections {
    if (_value.sections == null) {
      return null;
    }

    return $SectionHomeDataModelCopyWith<$Res>(_value.sections!, (value) {
      return _then(_value.copyWith(sections: value) as $Val);
    });
  }

  /// Create a copy of PatientHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NextSectionModelCopyWith<$Res>? get nextSection {
    if (_value.nextSection == null) {
      return null;
    }

    return $NextSectionModelCopyWith<$Res>(_value.nextSection!, (value) {
      return _then(_value.copyWith(nextSection: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PatientHomeDataModelImplCopyWith<$Res>
    implements $PatientHomeDataModelCopyWith<$Res> {
  factory _$$PatientHomeDataModelImplCopyWith(_$PatientHomeDataModelImpl value,
          $Res Function(_$PatientHomeDataModelImpl) then) =
      __$$PatientHomeDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? hospital,
      @JsonKey(fromJson: _flexibleNumFromJson) num? age,
      @JsonKey(fromJson: _flexibleNumFromJson) num? egfr,
      @JsonKey(name: 'egfr_previous', fromJson: _flexibleNumFromJson)
      num? egfrPrevious,
      @JsonKey(fromJson: _flexibleNumFromJson) num? bmi,
      @JsonKey(name: 'updated_at') String? updatedAt,
      DoctorModel? doctor,
      SectionHomeDataModel? sections,
      @JsonKey(name: 'sections_completed') int? sectionsCompleted,
      @JsonKey(name: 'sections_total') int? sectionsTotal,
      @JsonKey(name: 'sections_last_updated_at') String? sectionsLastUpdatedAt,
      @JsonKey(name: 'next_section') NextSectionModel? nextSection});

  @override
  $DoctorModelCopyWith<$Res>? get doctor;
  @override
  $SectionHomeDataModelCopyWith<$Res>? get sections;
  @override
  $NextSectionModelCopyWith<$Res>? get nextSection;
}

/// @nodoc
class __$$PatientHomeDataModelImplCopyWithImpl<$Res>
    extends _$PatientHomeDataModelCopyWithImpl<$Res, _$PatientHomeDataModelImpl>
    implements _$$PatientHomeDataModelImplCopyWith<$Res> {
  __$$PatientHomeDataModelImplCopyWithImpl(_$PatientHomeDataModelImpl _value,
      $Res Function(_$PatientHomeDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? hospital = freezed,
    Object? age = freezed,
    Object? egfr = freezed,
    Object? egfrPrevious = freezed,
    Object? bmi = freezed,
    Object? updatedAt = freezed,
    Object? doctor = freezed,
    Object? sections = freezed,
    Object? sectionsCompleted = freezed,
    Object? sectionsTotal = freezed,
    Object? sectionsLastUpdatedAt = freezed,
    Object? nextSection = freezed,
  }) {
    return _then(_$PatientHomeDataModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      hospital: freezed == hospital
          ? _value.hospital
          : hospital // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as num?,
      egfr: freezed == egfr
          ? _value.egfr
          : egfr // ignore: cast_nullable_to_non_nullable
              as num?,
      egfrPrevious: freezed == egfrPrevious
          ? _value.egfrPrevious
          : egfrPrevious // ignore: cast_nullable_to_non_nullable
              as num?,
      bmi: freezed == bmi
          ? _value.bmi
          : bmi // ignore: cast_nullable_to_non_nullable
              as num?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      sections: freezed == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as SectionHomeDataModel?,
      sectionsCompleted: freezed == sectionsCompleted
          ? _value.sectionsCompleted
          : sectionsCompleted // ignore: cast_nullable_to_non_nullable
              as int?,
      sectionsTotal: freezed == sectionsTotal
          ? _value.sectionsTotal
          : sectionsTotal // ignore: cast_nullable_to_non_nullable
              as int?,
      sectionsLastUpdatedAt: freezed == sectionsLastUpdatedAt
          ? _value.sectionsLastUpdatedAt
          : sectionsLastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      nextSection: freezed == nextSection
          ? _value.nextSection
          : nextSection // ignore: cast_nullable_to_non_nullable
              as NextSectionModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientHomeDataModelImpl implements _PatientHomeDataModel {
  const _$PatientHomeDataModelImpl(
      {this.id,
      this.name,
      this.hospital,
      @JsonKey(fromJson: _flexibleNumFromJson) this.age,
      @JsonKey(fromJson: _flexibleNumFromJson) this.egfr,
      @JsonKey(name: 'egfr_previous', fromJson: _flexibleNumFromJson)
      this.egfrPrevious,
      @JsonKey(fromJson: _flexibleNumFromJson) this.bmi,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.doctor,
      this.sections,
      @JsonKey(name: 'sections_completed') this.sectionsCompleted,
      @JsonKey(name: 'sections_total') this.sectionsTotal,
      @JsonKey(name: 'sections_last_updated_at') this.sectionsLastUpdatedAt,
      @JsonKey(name: 'next_section') this.nextSection});

  factory _$PatientHomeDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientHomeDataModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? hospital;
  @override
  @JsonKey(fromJson: _flexibleNumFromJson)
  final num? age;
  @override
  @JsonKey(fromJson: _flexibleNumFromJson)
  final num? egfr;
  @override
  @JsonKey(name: 'egfr_previous', fromJson: _flexibleNumFromJson)
  final num? egfrPrevious;
  @override
  @JsonKey(fromJson: _flexibleNumFromJson)
  final num? bmi;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  final DoctorModel? doctor;
  @override
  final SectionHomeDataModel? sections;
  @override
  @JsonKey(name: 'sections_completed')
  final int? sectionsCompleted;
  @override
  @JsonKey(name: 'sections_total')
  final int? sectionsTotal;
  @override
  @JsonKey(name: 'sections_last_updated_at')
  final String? sectionsLastUpdatedAt;
  @override
  @JsonKey(name: 'next_section')
  final NextSectionModel? nextSection;

  @override
  String toString() {
    return 'PatientHomeDataModel(id: $id, name: $name, hospital: $hospital, age: $age, egfr: $egfr, egfrPrevious: $egfrPrevious, bmi: $bmi, updatedAt: $updatedAt, doctor: $doctor, sections: $sections, sectionsCompleted: $sectionsCompleted, sectionsTotal: $sectionsTotal, sectionsLastUpdatedAt: $sectionsLastUpdatedAt, nextSection: $nextSection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientHomeDataModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.hospital, hospital) ||
                other.hospital == hospital) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.egfr, egfr) || other.egfr == egfr) &&
            (identical(other.egfrPrevious, egfrPrevious) ||
                other.egfrPrevious == egfrPrevious) &&
            (identical(other.bmi, bmi) || other.bmi == bmi) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.doctor, doctor) || other.doctor == doctor) &&
            (identical(other.sections, sections) ||
                other.sections == sections) &&
            (identical(other.sectionsCompleted, sectionsCompleted) ||
                other.sectionsCompleted == sectionsCompleted) &&
            (identical(other.sectionsTotal, sectionsTotal) ||
                other.sectionsTotal == sectionsTotal) &&
            (identical(other.sectionsLastUpdatedAt, sectionsLastUpdatedAt) ||
                other.sectionsLastUpdatedAt == sectionsLastUpdatedAt) &&
            (identical(other.nextSection, nextSection) ||
                other.nextSection == nextSection));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      hospital,
      age,
      egfr,
      egfrPrevious,
      bmi,
      updatedAt,
      doctor,
      sections,
      sectionsCompleted,
      sectionsTotal,
      sectionsLastUpdatedAt,
      nextSection);

  /// Create a copy of PatientHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientHomeDataModelImplCopyWith<_$PatientHomeDataModelImpl>
      get copyWith =>
          __$$PatientHomeDataModelImplCopyWithImpl<_$PatientHomeDataModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientHomeDataModelImplToJson(
      this,
    );
  }
}

abstract class _PatientHomeDataModel implements PatientHomeDataModel {
  const factory _PatientHomeDataModel(
          {final int? id,
          final String? name,
          final String? hospital,
          @JsonKey(fromJson: _flexibleNumFromJson) final num? age,
          @JsonKey(fromJson: _flexibleNumFromJson) final num? egfr,
          @JsonKey(name: 'egfr_previous', fromJson: _flexibleNumFromJson)
          final num? egfrPrevious,
          @JsonKey(fromJson: _flexibleNumFromJson) final num? bmi,
          @JsonKey(name: 'updated_at') final String? updatedAt,
          final DoctorModel? doctor,
          final SectionHomeDataModel? sections,
          @JsonKey(name: 'sections_completed') final int? sectionsCompleted,
          @JsonKey(name: 'sections_total') final int? sectionsTotal,
          @JsonKey(name: 'sections_last_updated_at')
          final String? sectionsLastUpdatedAt,
          @JsonKey(name: 'next_section') final NextSectionModel? nextSection}) =
      _$PatientHomeDataModelImpl;

  factory _PatientHomeDataModel.fromJson(Map<String, dynamic> json) =
      _$PatientHomeDataModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get hospital;
  @override
  @JsonKey(fromJson: _flexibleNumFromJson)
  num? get age;
  @override
  @JsonKey(fromJson: _flexibleNumFromJson)
  num? get egfr;
  @override
  @JsonKey(name: 'egfr_previous', fromJson: _flexibleNumFromJson)
  num? get egfrPrevious;
  @override
  @JsonKey(fromJson: _flexibleNumFromJson)
  num? get bmi;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  DoctorModel? get doctor;
  @override
  SectionHomeDataModel? get sections;
  @override
  @JsonKey(name: 'sections_completed')
  int? get sectionsCompleted;
  @override
  @JsonKey(name: 'sections_total')
  int? get sectionsTotal;
  @override
  @JsonKey(name: 'sections_last_updated_at')
  String? get sectionsLastUpdatedAt;
  @override
  @JsonKey(name: 'next_section')
  NextSectionModel? get nextSection;

  /// Create a copy of PatientHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientHomeDataModelImplCopyWith<_$PatientHomeDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NextSectionModel _$NextSectionModelFromJson(Map<String, dynamic> json) {
  return _NextSectionModel.fromJson(json);
}

/// @nodoc
mixin _$NextSectionModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this NextSectionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NextSectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NextSectionModelCopyWith<NextSectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NextSectionModelCopyWith<$Res> {
  factory $NextSectionModelCopyWith(
          NextSectionModel value, $Res Function(NextSectionModel) then) =
      _$NextSectionModelCopyWithImpl<$Res, NextSectionModel>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$NextSectionModelCopyWithImpl<$Res, $Val extends NextSectionModel>
    implements $NextSectionModelCopyWith<$Res> {
  _$NextSectionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NextSectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NextSectionModelImplCopyWith<$Res>
    implements $NextSectionModelCopyWith<$Res> {
  factory _$$NextSectionModelImplCopyWith(_$NextSectionModelImpl value,
          $Res Function(_$NextSectionModelImpl) then) =
      __$$NextSectionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$NextSectionModelImplCopyWithImpl<$Res>
    extends _$NextSectionModelCopyWithImpl<$Res, _$NextSectionModelImpl>
    implements _$$NextSectionModelImplCopyWith<$Res> {
  __$$NextSectionModelImplCopyWithImpl(_$NextSectionModelImpl _value,
      $Res Function(_$NextSectionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NextSectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$NextSectionModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NextSectionModelImpl implements _NextSectionModel {
  const _$NextSectionModelImpl({this.id, this.name});

  factory _$NextSectionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NextSectionModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'NextSectionModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NextSectionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of NextSectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NextSectionModelImplCopyWith<_$NextSectionModelImpl> get copyWith =>
      __$$NextSectionModelImplCopyWithImpl<_$NextSectionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NextSectionModelImplToJson(
      this,
    );
  }
}

abstract class _NextSectionModel implements NextSectionModel {
  const factory _NextSectionModel({final int? id, final String? name}) =
      _$NextSectionModelImpl;

  factory _NextSectionModel.fromJson(Map<String, dynamic> json) =
      _$NextSectionModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of NextSectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NextSectionModelImplCopyWith<_$NextSectionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SectionHomeDataModel _$SectionHomeDataModelFromJson(Map<String, dynamic> json) {
  return _SectionHomeDataModel.fromJson(json);
}

/// @nodoc
mixin _$SectionHomeDataModel {
  @JsonKey(name: 'patient_id')
  int? get patientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'submit_status', fromJson: _flexibleBoolFromJson)
  bool? get submitStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'outcome_status', fromJson: _flexibleBoolFromJson)
  bool? get outcomeStatus => throw _privateConstructorUsedError;

  /// Serializes this SectionHomeDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SectionHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SectionHomeDataModelCopyWith<SectionHomeDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionHomeDataModelCopyWith<$Res> {
  factory $SectionHomeDataModelCopyWith(SectionHomeDataModel value,
          $Res Function(SectionHomeDataModel) then) =
      _$SectionHomeDataModelCopyWithImpl<$Res, SectionHomeDataModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'patient_id') int? patientId,
      @JsonKey(name: 'submit_status', fromJson: _flexibleBoolFromJson)
      bool? submitStatus,
      @JsonKey(name: 'outcome_status', fromJson: _flexibleBoolFromJson)
      bool? outcomeStatus});
}

/// @nodoc
class _$SectionHomeDataModelCopyWithImpl<$Res,
        $Val extends SectionHomeDataModel>
    implements $SectionHomeDataModelCopyWith<$Res> {
  _$SectionHomeDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SectionHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientId = freezed,
    Object? submitStatus = freezed,
    Object? outcomeStatus = freezed,
  }) {
    return _then(_value.copyWith(
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int?,
      submitStatus: freezed == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      outcomeStatus: freezed == outcomeStatus
          ? _value.outcomeStatus
          : outcomeStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SectionHomeDataModelImplCopyWith<$Res>
    implements $SectionHomeDataModelCopyWith<$Res> {
  factory _$$SectionHomeDataModelImplCopyWith(_$SectionHomeDataModelImpl value,
          $Res Function(_$SectionHomeDataModelImpl) then) =
      __$$SectionHomeDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'patient_id') int? patientId,
      @JsonKey(name: 'submit_status', fromJson: _flexibleBoolFromJson)
      bool? submitStatus,
      @JsonKey(name: 'outcome_status', fromJson: _flexibleBoolFromJson)
      bool? outcomeStatus});
}

/// @nodoc
class __$$SectionHomeDataModelImplCopyWithImpl<$Res>
    extends _$SectionHomeDataModelCopyWithImpl<$Res, _$SectionHomeDataModelImpl>
    implements _$$SectionHomeDataModelImplCopyWith<$Res> {
  __$$SectionHomeDataModelImplCopyWithImpl(_$SectionHomeDataModelImpl _value,
      $Res Function(_$SectionHomeDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SectionHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientId = freezed,
    Object? submitStatus = freezed,
    Object? outcomeStatus = freezed,
  }) {
    return _then(_$SectionHomeDataModelImpl(
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int?,
      submitStatus: freezed == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      outcomeStatus: freezed == outcomeStatus
          ? _value.outcomeStatus
          : outcomeStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionHomeDataModelImpl implements _SectionHomeDataModel {
  const _$SectionHomeDataModelImpl(
      {@JsonKey(name: 'patient_id') this.patientId,
      @JsonKey(name: 'submit_status', fromJson: _flexibleBoolFromJson)
      this.submitStatus,
      @JsonKey(name: 'outcome_status', fromJson: _flexibleBoolFromJson)
      this.outcomeStatus});

  factory _$SectionHomeDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionHomeDataModelImplFromJson(json);

  @override
  @JsonKey(name: 'patient_id')
  final int? patientId;
  @override
  @JsonKey(name: 'submit_status', fromJson: _flexibleBoolFromJson)
  final bool? submitStatus;
  @override
  @JsonKey(name: 'outcome_status', fromJson: _flexibleBoolFromJson)
  final bool? outcomeStatus;

  @override
  String toString() {
    return 'SectionHomeDataModel(patientId: $patientId, submitStatus: $submitStatus, outcomeStatus: $outcomeStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionHomeDataModelImpl &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.submitStatus, submitStatus) ||
                other.submitStatus == submitStatus) &&
            (identical(other.outcomeStatus, outcomeStatus) ||
                other.outcomeStatus == outcomeStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, patientId, submitStatus, outcomeStatus);

  /// Create a copy of SectionHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionHomeDataModelImplCopyWith<_$SectionHomeDataModelImpl>
      get copyWith =>
          __$$SectionHomeDataModelImplCopyWithImpl<_$SectionHomeDataModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionHomeDataModelImplToJson(
      this,
    );
  }
}

abstract class _SectionHomeDataModel implements SectionHomeDataModel {
  const factory _SectionHomeDataModel(
      {@JsonKey(name: 'patient_id') final int? patientId,
      @JsonKey(name: 'submit_status', fromJson: _flexibleBoolFromJson)
      final bool? submitStatus,
      @JsonKey(name: 'outcome_status', fromJson: _flexibleBoolFromJson)
      final bool? outcomeStatus}) = _$SectionHomeDataModelImpl;

  factory _SectionHomeDataModel.fromJson(Map<String, dynamic> json) =
      _$SectionHomeDataModelImpl.fromJson;

  @override
  @JsonKey(name: 'patient_id')
  int? get patientId;
  @override
  @JsonKey(name: 'submit_status', fromJson: _flexibleBoolFromJson)
  bool? get submitStatus;
  @override
  @JsonKey(name: 'outcome_status', fromJson: _flexibleBoolFromJson)
  bool? get outcomeStatus;

  /// Create a copy of SectionHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectionHomeDataModelImplCopyWith<_$SectionHomeDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HomeActivityModel _$HomeActivityModelFromJson(Map<String, dynamic> json) {
  return _HomeActivityModel.fromJson(json);
}

/// @nodoc
mixin _$HomeActivityModel {
  int? get id => throw _privateConstructorUsedError;
  HomeActivityActorModel? get actor => throw _privateConstructorUsedError;
  String? get verb => throw _privateConstructorUsedError;
  HomeActivityTargetModel? get target => throw _privateConstructorUsedError;
  String? get at => throw _privateConstructorUsedError;
  bool? get read => throw _privateConstructorUsedError;

  /// Serializes this HomeActivityModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeActivityModelCopyWith<HomeActivityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeActivityModelCopyWith<$Res> {
  factory $HomeActivityModelCopyWith(
          HomeActivityModel value, $Res Function(HomeActivityModel) then) =
      _$HomeActivityModelCopyWithImpl<$Res, HomeActivityModel>;
  @useResult
  $Res call(
      {int? id,
      HomeActivityActorModel? actor,
      String? verb,
      HomeActivityTargetModel? target,
      String? at,
      bool? read});

  $HomeActivityActorModelCopyWith<$Res>? get actor;
  $HomeActivityTargetModelCopyWith<$Res>? get target;
}

/// @nodoc
class _$HomeActivityModelCopyWithImpl<$Res, $Val extends HomeActivityModel>
    implements $HomeActivityModelCopyWith<$Res> {
  _$HomeActivityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? actor = freezed,
    Object? verb = freezed,
    Object? target = freezed,
    Object? at = freezed,
    Object? read = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      actor: freezed == actor
          ? _value.actor
          : actor // ignore: cast_nullable_to_non_nullable
              as HomeActivityActorModel?,
      verb: freezed == verb
          ? _value.verb
          : verb // ignore: cast_nullable_to_non_nullable
              as String?,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as HomeActivityTargetModel?,
      at: freezed == at
          ? _value.at
          : at // ignore: cast_nullable_to_non_nullable
              as String?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of HomeActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomeActivityActorModelCopyWith<$Res>? get actor {
    if (_value.actor == null) {
      return null;
    }

    return $HomeActivityActorModelCopyWith<$Res>(_value.actor!, (value) {
      return _then(_value.copyWith(actor: value) as $Val);
    });
  }

  /// Create a copy of HomeActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomeActivityTargetModelCopyWith<$Res>? get target {
    if (_value.target == null) {
      return null;
    }

    return $HomeActivityTargetModelCopyWith<$Res>(_value.target!, (value) {
      return _then(_value.copyWith(target: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeActivityModelImplCopyWith<$Res>
    implements $HomeActivityModelCopyWith<$Res> {
  factory _$$HomeActivityModelImplCopyWith(_$HomeActivityModelImpl value,
          $Res Function(_$HomeActivityModelImpl) then) =
      __$$HomeActivityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      HomeActivityActorModel? actor,
      String? verb,
      HomeActivityTargetModel? target,
      String? at,
      bool? read});

  @override
  $HomeActivityActorModelCopyWith<$Res>? get actor;
  @override
  $HomeActivityTargetModelCopyWith<$Res>? get target;
}

/// @nodoc
class __$$HomeActivityModelImplCopyWithImpl<$Res>
    extends _$HomeActivityModelCopyWithImpl<$Res, _$HomeActivityModelImpl>
    implements _$$HomeActivityModelImplCopyWith<$Res> {
  __$$HomeActivityModelImplCopyWithImpl(_$HomeActivityModelImpl _value,
      $Res Function(_$HomeActivityModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? actor = freezed,
    Object? verb = freezed,
    Object? target = freezed,
    Object? at = freezed,
    Object? read = freezed,
  }) {
    return _then(_$HomeActivityModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      actor: freezed == actor
          ? _value.actor
          : actor // ignore: cast_nullable_to_non_nullable
              as HomeActivityActorModel?,
      verb: freezed == verb
          ? _value.verb
          : verb // ignore: cast_nullable_to_non_nullable
              as String?,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as HomeActivityTargetModel?,
      at: freezed == at
          ? _value.at
          : at // ignore: cast_nullable_to_non_nullable
              as String?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeActivityModelImpl implements _HomeActivityModel {
  const _$HomeActivityModelImpl(
      {this.id, this.actor, this.verb, this.target, this.at, this.read});

  factory _$HomeActivityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeActivityModelImplFromJson(json);

  @override
  final int? id;
  @override
  final HomeActivityActorModel? actor;
  @override
  final String? verb;
  @override
  final HomeActivityTargetModel? target;
  @override
  final String? at;
  @override
  final bool? read;

  @override
  String toString() {
    return 'HomeActivityModel(id: $id, actor: $actor, verb: $verb, target: $target, at: $at, read: $read)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeActivityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.actor, actor) || other.actor == actor) &&
            (identical(other.verb, verb) || other.verb == verb) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.at, at) || other.at == at) &&
            (identical(other.read, read) || other.read == read));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, actor, verb, target, at, read);

  /// Create a copy of HomeActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeActivityModelImplCopyWith<_$HomeActivityModelImpl> get copyWith =>
      __$$HomeActivityModelImplCopyWithImpl<_$HomeActivityModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeActivityModelImplToJson(
      this,
    );
  }
}

abstract class _HomeActivityModel implements HomeActivityModel {
  const factory _HomeActivityModel(
      {final int? id,
      final HomeActivityActorModel? actor,
      final String? verb,
      final HomeActivityTargetModel? target,
      final String? at,
      final bool? read}) = _$HomeActivityModelImpl;

  factory _HomeActivityModel.fromJson(Map<String, dynamic> json) =
      _$HomeActivityModelImpl.fromJson;

  @override
  int? get id;
  @override
  HomeActivityActorModel? get actor;
  @override
  String? get verb;
  @override
  HomeActivityTargetModel? get target;
  @override
  String? get at;
  @override
  bool? get read;

  /// Create a copy of HomeActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeActivityModelImplCopyWith<_$HomeActivityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeActivityActorModel _$HomeActivityActorModelFromJson(
    Map<String, dynamic> json) {
  return _HomeActivityActorModel.fromJson(json);
}

/// @nodoc
mixin _$HomeActivityActorModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lname')
  String? get lastName => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get isSyndicateCardRequired => throw _privateConstructorUsedError;

  /// Serializes this HomeActivityActorModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeActivityActorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeActivityActorModelCopyWith<HomeActivityActorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeActivityActorModelCopyWith<$Res> {
  factory $HomeActivityActorModelCopyWith(HomeActivityActorModel value,
          $Res Function(HomeActivityActorModel) then) =
      _$HomeActivityActorModelCopyWithImpl<$Res, HomeActivityActorModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? image,
      String? avatar,
      String? isSyndicateCardRequired});
}

/// @nodoc
class _$HomeActivityActorModelCopyWithImpl<$Res,
        $Val extends HomeActivityActorModel>
    implements $HomeActivityActorModelCopyWith<$Res> {
  _$HomeActivityActorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeActivityActorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? image = freezed,
    Object? avatar = freezed,
    Object? isSyndicateCardRequired = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeActivityActorModelImplCopyWith<$Res>
    implements $HomeActivityActorModelCopyWith<$Res> {
  factory _$$HomeActivityActorModelImplCopyWith(
          _$HomeActivityActorModelImpl value,
          $Res Function(_$HomeActivityActorModelImpl) then) =
      __$$HomeActivityActorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? image,
      String? avatar,
      String? isSyndicateCardRequired});
}

/// @nodoc
class __$$HomeActivityActorModelImplCopyWithImpl<$Res>
    extends _$HomeActivityActorModelCopyWithImpl<$Res,
        _$HomeActivityActorModelImpl>
    implements _$$HomeActivityActorModelImplCopyWith<$Res> {
  __$$HomeActivityActorModelImplCopyWithImpl(
      _$HomeActivityActorModelImpl _value,
      $Res Function(_$HomeActivityActorModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeActivityActorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? image = freezed,
    Object? avatar = freezed,
    Object? isSyndicateCardRequired = freezed,
  }) {
    return _then(_$HomeActivityActorModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeActivityActorModelImpl implements _HomeActivityActorModel {
  const _$HomeActivityActorModelImpl(
      {this.id,
      @JsonKey(name: 'name') this.firstName,
      @JsonKey(name: 'lname') this.lastName,
      this.image,
      this.avatar,
      this.isSyndicateCardRequired});

  factory _$HomeActivityActorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeActivityActorModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'name')
  final String? firstName;
  @override
  @JsonKey(name: 'lname')
  final String? lastName;
  @override
  final String? image;
  @override
  final String? avatar;
  @override
  final String? isSyndicateCardRequired;

  @override
  String toString() {
    return 'HomeActivityActorModel(id: $id, firstName: $firstName, lastName: $lastName, image: $image, avatar: $avatar, isSyndicateCardRequired: $isSyndicateCardRequired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeActivityActorModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(
                    other.isSyndicateCardRequired, isSyndicateCardRequired) ||
                other.isSyndicateCardRequired == isSyndicateCardRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName, image,
      avatar, isSyndicateCardRequired);

  /// Create a copy of HomeActivityActorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeActivityActorModelImplCopyWith<_$HomeActivityActorModelImpl>
      get copyWith => __$$HomeActivityActorModelImplCopyWithImpl<
          _$HomeActivityActorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeActivityActorModelImplToJson(
      this,
    );
  }
}

abstract class _HomeActivityActorModel implements HomeActivityActorModel {
  const factory _HomeActivityActorModel(
      {final int? id,
      @JsonKey(name: 'name') final String? firstName,
      @JsonKey(name: 'lname') final String? lastName,
      final String? image,
      final String? avatar,
      final String? isSyndicateCardRequired}) = _$HomeActivityActorModelImpl;

  factory _HomeActivityActorModel.fromJson(Map<String, dynamic> json) =
      _$HomeActivityActorModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'name')
  String? get firstName;
  @override
  @JsonKey(name: 'lname')
  String? get lastName;
  @override
  String? get image;
  @override
  String? get avatar;
  @override
  String? get isSyndicateCardRequired;

  /// Create a copy of HomeActivityActorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeActivityActorModelImplCopyWith<_$HomeActivityActorModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HomeActivityTargetModel _$HomeActivityTargetModelFromJson(
    Map<String, dynamic> json) {
  return _HomeActivityTargetModel.fromJson(json);
}

/// @nodoc
mixin _$HomeActivityTargetModel {
  @JsonKey(name: 'patient_id')
  int? get patientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_id')
  int? get typeId => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'localization_key')
  String? get localizationKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'localization_params')
  Map<String, dynamic>? get localizationParams =>
      throw _privateConstructorUsedError;

  /// Serializes this HomeActivityTargetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeActivityTargetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeActivityTargetModelCopyWith<HomeActivityTargetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeActivityTargetModelCopyWith<$Res> {
  factory $HomeActivityTargetModelCopyWith(HomeActivityTargetModel value,
          $Res Function(HomeActivityTargetModel) then) =
      _$HomeActivityTargetModelCopyWithImpl<$Res, HomeActivityTargetModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'patient_id') int? patientId,
      @JsonKey(name: 'type_id') int? typeId,
      String? content,
      @JsonKey(name: 'localization_key') String? localizationKey,
      @JsonKey(name: 'localization_params')
      Map<String, dynamic>? localizationParams});
}

/// @nodoc
class _$HomeActivityTargetModelCopyWithImpl<$Res,
        $Val extends HomeActivityTargetModel>
    implements $HomeActivityTargetModelCopyWith<$Res> {
  _$HomeActivityTargetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeActivityTargetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientId = freezed,
    Object? typeId = freezed,
    Object? content = freezed,
    Object? localizationKey = freezed,
    Object? localizationParams = freezed,
  }) {
    return _then(_value.copyWith(
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int?,
      typeId: freezed == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      localizationKey: freezed == localizationKey
          ? _value.localizationKey
          : localizationKey // ignore: cast_nullable_to_non_nullable
              as String?,
      localizationParams: freezed == localizationParams
          ? _value.localizationParams
          : localizationParams // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeActivityTargetModelImplCopyWith<$Res>
    implements $HomeActivityTargetModelCopyWith<$Res> {
  factory _$$HomeActivityTargetModelImplCopyWith(
          _$HomeActivityTargetModelImpl value,
          $Res Function(_$HomeActivityTargetModelImpl) then) =
      __$$HomeActivityTargetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'patient_id') int? patientId,
      @JsonKey(name: 'type_id') int? typeId,
      String? content,
      @JsonKey(name: 'localization_key') String? localizationKey,
      @JsonKey(name: 'localization_params')
      Map<String, dynamic>? localizationParams});
}

/// @nodoc
class __$$HomeActivityTargetModelImplCopyWithImpl<$Res>
    extends _$HomeActivityTargetModelCopyWithImpl<$Res,
        _$HomeActivityTargetModelImpl>
    implements _$$HomeActivityTargetModelImplCopyWith<$Res> {
  __$$HomeActivityTargetModelImplCopyWithImpl(
      _$HomeActivityTargetModelImpl _value,
      $Res Function(_$HomeActivityTargetModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeActivityTargetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientId = freezed,
    Object? typeId = freezed,
    Object? content = freezed,
    Object? localizationKey = freezed,
    Object? localizationParams = freezed,
  }) {
    return _then(_$HomeActivityTargetModelImpl(
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int?,
      typeId: freezed == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      localizationKey: freezed == localizationKey
          ? _value.localizationKey
          : localizationKey // ignore: cast_nullable_to_non_nullable
              as String?,
      localizationParams: freezed == localizationParams
          ? _value._localizationParams
          : localizationParams // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeActivityTargetModelImpl implements _HomeActivityTargetModel {
  const _$HomeActivityTargetModelImpl(
      {@JsonKey(name: 'patient_id') this.patientId,
      @JsonKey(name: 'type_id') this.typeId,
      this.content,
      @JsonKey(name: 'localization_key') this.localizationKey,
      @JsonKey(name: 'localization_params')
      final Map<String, dynamic>? localizationParams})
      : _localizationParams = localizationParams;

  factory _$HomeActivityTargetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeActivityTargetModelImplFromJson(json);

  @override
  @JsonKey(name: 'patient_id')
  final int? patientId;
  @override
  @JsonKey(name: 'type_id')
  final int? typeId;
  @override
  final String? content;
  @override
  @JsonKey(name: 'localization_key')
  final String? localizationKey;
  final Map<String, dynamic>? _localizationParams;
  @override
  @JsonKey(name: 'localization_params')
  Map<String, dynamic>? get localizationParams {
    final value = _localizationParams;
    if (value == null) return null;
    if (_localizationParams is EqualUnmodifiableMapView)
      return _localizationParams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'HomeActivityTargetModel(patientId: $patientId, typeId: $typeId, content: $content, localizationKey: $localizationKey, localizationParams: $localizationParams)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeActivityTargetModelImpl &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.typeId, typeId) || other.typeId == typeId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.localizationKey, localizationKey) ||
                other.localizationKey == localizationKey) &&
            const DeepCollectionEquality()
                .equals(other._localizationParams, _localizationParams));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      patientId,
      typeId,
      content,
      localizationKey,
      const DeepCollectionEquality().hash(_localizationParams));

  /// Create a copy of HomeActivityTargetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeActivityTargetModelImplCopyWith<_$HomeActivityTargetModelImpl>
      get copyWith => __$$HomeActivityTargetModelImplCopyWithImpl<
          _$HomeActivityTargetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeActivityTargetModelImplToJson(
      this,
    );
  }
}

abstract class _HomeActivityTargetModel implements HomeActivityTargetModel {
  const factory _HomeActivityTargetModel(
          {@JsonKey(name: 'patient_id') final int? patientId,
          @JsonKey(name: 'type_id') final int? typeId,
          final String? content,
          @JsonKey(name: 'localization_key') final String? localizationKey,
          @JsonKey(name: 'localization_params')
          final Map<String, dynamic>? localizationParams}) =
      _$HomeActivityTargetModelImpl;

  factory _HomeActivityTargetModel.fromJson(Map<String, dynamic> json) =
      _$HomeActivityTargetModelImpl.fromJson;

  @override
  @JsonKey(name: 'patient_id')
  int? get patientId;
  @override
  @JsonKey(name: 'type_id')
  int? get typeId;
  @override
  String? get content;
  @override
  @JsonKey(name: 'localization_key')
  String? get localizationKey;
  @override
  @JsonKey(name: 'localization_params')
  Map<String, dynamic>? get localizationParams;

  /// Create a copy of HomeActivityTargetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeActivityTargetModelImplCopyWith<_$HomeActivityTargetModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
