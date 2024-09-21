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
  String? get unreadCount => throw _privateConstructorUsedError;
  String? get isSyndicateCardRequired => throw _privateConstructorUsedError;
  @JsonKey(name: 'app_update_message')
  dynamic get appUpdateMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_patient_count')
  String? get doctorPatientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'all_patient_count')
  String? get allPatientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'score_value')
  String? get scoreValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'role')
  String? get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'isUserBlocked')
  bool? get isUserBlocked => throw _privateConstructorUsedError;
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
      String? unreadCount,
      String? isSyndicateCardRequired,
      @JsonKey(name: 'app_update_message') dynamic appUpdateMessage,
      @JsonKey(name: 'doctor_patient_count') String? doctorPatientCount,
      @JsonKey(name: 'all_patient_count') String? allPatientCount,
      @JsonKey(name: 'score_value') String? scoreValue,
      @JsonKey(name: 'role') String? role,
      @JsonKey(name: 'isUserBlocked') bool? isUserBlocked,
      HomeDataModelResponse? data});

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
    Object? isUserBlocked = freezed,
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
      isUserBlocked: freezed == isUserBlocked
          ? _value.isUserBlocked
          : isUserBlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      String? unreadCount,
      String? isSyndicateCardRequired,
      @JsonKey(name: 'app_update_message') dynamic appUpdateMessage,
      @JsonKey(name: 'doctor_patient_count') String? doctorPatientCount,
      @JsonKey(name: 'all_patient_count') String? allPatientCount,
      @JsonKey(name: 'score_value') String? scoreValue,
      @JsonKey(name: 'role') String? role,
      @JsonKey(name: 'isUserBlocked') bool? isUserBlocked,
      HomeDataModelResponse? data});

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
    Object? isUserBlocked = freezed,
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
      isUserBlocked: freezed == isUserBlocked
          ? _value.isUserBlocked
          : isUserBlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      this.unreadCount,
      this.isSyndicateCardRequired,
      @JsonKey(name: 'app_update_message') this.appUpdateMessage,
      @JsonKey(name: 'doctor_patient_count') this.doctorPatientCount,
      @JsonKey(name: 'all_patient_count') this.allPatientCount,
      @JsonKey(name: 'score_value') this.scoreValue,
      @JsonKey(name: 'role') this.role,
      @JsonKey(name: 'isUserBlocked') this.isUserBlocked,
      this.data});

  factory _$HomeModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final bool? verified;
  @override
  final String? unreadCount;
  @override
  final String? isSyndicateCardRequired;
  @override
  @JsonKey(name: 'app_update_message')
  final dynamic appUpdateMessage;
  @override
  @JsonKey(name: 'doctor_patient_count')
  final String? doctorPatientCount;
  @override
  @JsonKey(name: 'all_patient_count')
  final String? allPatientCount;
  @override
  @JsonKey(name: 'score_value')
  final String? scoreValue;
  @override
  @JsonKey(name: 'role')
  final String? role;
  @override
  @JsonKey(name: 'isUserBlocked')
  final bool? isUserBlocked;
  @override
  final HomeDataModelResponse? data;

  @override
  String toString() {
    return 'HomeModelResponse(value: $value, verified: $verified, unreadCount: $unreadCount, isSyndicateCardRequired: $isSyndicateCardRequired, appUpdateMessage: $appUpdateMessage, doctorPatientCount: $doctorPatientCount, allPatientCount: $allPatientCount, scoreValue: $scoreValue, role: $role, isUserBlocked: $isUserBlocked, data: $data)';
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
            (identical(other.isUserBlocked, isUserBlocked) ||
                other.isUserBlocked == isUserBlocked) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
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
      isUserBlocked,
      data);

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
      final String? unreadCount,
      final String? isSyndicateCardRequired,
      @JsonKey(name: 'app_update_message') final dynamic appUpdateMessage,
      @JsonKey(name: 'doctor_patient_count') final String? doctorPatientCount,
      @JsonKey(name: 'all_patient_count') final String? allPatientCount,
      @JsonKey(name: 'score_value') final String? scoreValue,
      @JsonKey(name: 'role') final String? role,
      @JsonKey(name: 'isUserBlocked') final bool? isUserBlocked,
      final HomeDataModelResponse? data}) = _$HomeModelResponseImpl;

  factory _HomeModelResponse.fromJson(Map<String, dynamic> json) =
      _$HomeModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  bool? get verified;
  @override
  String? get unreadCount;
  @override
  String? get isSyndicateCardRequired;
  @override
  @JsonKey(name: 'app_update_message')
  dynamic get appUpdateMessage;
  @override
  @JsonKey(name: 'doctor_patient_count')
  String? get doctorPatientCount;
  @override
  @JsonKey(name: 'all_patient_count')
  String? get allPatientCount;
  @override
  @JsonKey(name: 'score_value')
  String? get scoreValue;
  @override
  @JsonKey(name: 'role')
  String? get role;
  @override
  @JsonKey(name: 'isUserBlocked')
  bool? get isUserBlocked;
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
  List<PostModel>? get posts => throw _privateConstructorUsedError;

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
      List<PostModel>? posts});
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
    Object? posts = freezed,
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
      posts: freezed == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>?,
    ) as $Val);
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
      List<PostModel>? posts});
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
    Object? posts = freezed,
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
      posts: freezed == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>?,
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
      final List<PostModel>? posts})
      : _allPatients = allPatients,
        _currentPatients = currentPatients,
        _topDoctors = topDoctors,
        _posts = posts;

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

  final List<PostModel>? _posts;
  @override
  List<PostModel>? get posts {
    final value = _posts;
    if (value == null) return null;
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'HomeDataModelResponse(allPatients: $allPatients, currentPatients: $currentPatients, topDoctors: $topDoctors, posts: $posts)';
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
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allPatients),
      const DeepCollectionEquality().hash(_currentPatients),
      const DeepCollectionEquality().hash(_topDoctors),
      const DeepCollectionEquality().hash(_posts));

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
      final List<PostModel>? posts}) = _$HomeDataModelResponseImpl;

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
  List<PostModel>? get posts;

  /// Create a copy of HomeDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeDataModelResponseImplCopyWith<_$HomeDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PatientHomeDataModel _$PatientHomeDataModelFromJson(Map<String, dynamic> json) {
  return _PatientHomeDataModel.fromJson(json);
}

/// @nodoc
mixin _$PatientHomeDataModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get hospital => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  DoctorModel? get doctor => throw _privateConstructorUsedError;
  SectionHomeDataModel? get sections => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'updated_at') String? updatedAt,
      DoctorModel? doctor,
      SectionHomeDataModel? sections});

  $DoctorModelCopyWith<$Res>? get doctor;
  $SectionHomeDataModelCopyWith<$Res>? get sections;
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
    Object? updatedAt = freezed,
    Object? doctor = freezed,
    Object? sections = freezed,
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
      @JsonKey(name: 'updated_at') String? updatedAt,
      DoctorModel? doctor,
      SectionHomeDataModel? sections});

  @override
  $DoctorModelCopyWith<$Res>? get doctor;
  @override
  $SectionHomeDataModelCopyWith<$Res>? get sections;
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
    Object? updatedAt = freezed,
    Object? doctor = freezed,
    Object? sections = freezed,
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
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.doctor,
      this.sections});

  factory _$PatientHomeDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientHomeDataModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? hospital;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  final DoctorModel? doctor;
  @override
  final SectionHomeDataModel? sections;

  @override
  String toString() {
    return 'PatientHomeDataModel(id: $id, name: $name, hospital: $hospital, updatedAt: $updatedAt, doctor: $doctor, sections: $sections)';
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
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.doctor, doctor) || other.doctor == doctor) &&
            (identical(other.sections, sections) ||
                other.sections == sections));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, hospital, updatedAt, doctor, sections);

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
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final DoctorModel? doctor,
      final SectionHomeDataModel? sections}) = _$PatientHomeDataModelImpl;

  factory _PatientHomeDataModel.fromJson(Map<String, dynamic> json) =
      _$PatientHomeDataModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get hospital;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  DoctorModel? get doctor;
  @override
  SectionHomeDataModel? get sections;

  /// Create a copy of PatientHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientHomeDataModelImplCopyWith<_$PatientHomeDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SectionHomeDataModel _$SectionHomeDataModelFromJson(Map<String, dynamic> json) {
  return _SectionHomeDataModel.fromJson(json);
}

/// @nodoc
mixin _$SectionHomeDataModel {
  @JsonKey(name: 'patient_id')
  int? get patientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'submit_status')
  bool? get submitStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'outcome_status')
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
      @JsonKey(name: 'submit_status') bool? submitStatus,
      @JsonKey(name: 'outcome_status') bool? outcomeStatus});
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
      @JsonKey(name: 'submit_status') bool? submitStatus,
      @JsonKey(name: 'outcome_status') bool? outcomeStatus});
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
      @JsonKey(name: 'submit_status') this.submitStatus,
      @JsonKey(name: 'outcome_status') this.outcomeStatus});

  factory _$SectionHomeDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionHomeDataModelImplFromJson(json);

  @override
  @JsonKey(name: 'patient_id')
  final int? patientId;
  @override
  @JsonKey(name: 'submit_status')
  final bool? submitStatus;
  @override
  @JsonKey(name: 'outcome_status')
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
          @JsonKey(name: 'submit_status') final bool? submitStatus,
          @JsonKey(name: 'outcome_status') final bool? outcomeStatus}) =
      _$SectionHomeDataModelImpl;

  factory _SectionHomeDataModel.fromJson(Map<String, dynamic> json) =
      _$SectionHomeDataModelImpl.fromJson;

  @override
  @JsonKey(name: 'patient_id')
  int? get patientId;
  @override
  @JsonKey(name: 'submit_status')
  bool? get submitStatus;
  @override
  @JsonKey(name: 'outcome_status')
  bool? get outcomeStatus;

  /// Create a copy of SectionHomeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectionHomeDataModelImplCopyWith<_$SectionHomeDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
