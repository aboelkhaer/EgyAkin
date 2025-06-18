// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_recommendations_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetRecommendationsModelResponse _$GetRecommendationsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetRecommendationsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetRecommendationsModelResponse {
  List<GetRecommendationsDataModelResponse>? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetRecommendationsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetRecommendationsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetRecommendationsModelResponseCopyWith<GetRecommendationsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetRecommendationsModelResponseCopyWith<$Res> {
  factory $GetRecommendationsModelResponseCopyWith(
          GetRecommendationsModelResponse value,
          $Res Function(GetRecommendationsModelResponse) then) =
      _$GetRecommendationsModelResponseCopyWithImpl<$Res,
          GetRecommendationsModelResponse>;
  @useResult
  $Res call({List<GetRecommendationsDataModelResponse>? data});
}

/// @nodoc
class _$GetRecommendationsModelResponseCopyWithImpl<$Res,
        $Val extends GetRecommendationsModelResponse>
    implements $GetRecommendationsModelResponseCopyWith<$Res> {
  _$GetRecommendationsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetRecommendationsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<GetRecommendationsDataModelResponse>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetRecommendationsModelResponseImplCopyWith<$Res>
    implements $GetRecommendationsModelResponseCopyWith<$Res> {
  factory _$$GetRecommendationsModelResponseImplCopyWith(
          _$GetRecommendationsModelResponseImpl value,
          $Res Function(_$GetRecommendationsModelResponseImpl) then) =
      __$$GetRecommendationsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GetRecommendationsDataModelResponse>? data});
}

/// @nodoc
class __$$GetRecommendationsModelResponseImplCopyWithImpl<$Res>
    extends _$GetRecommendationsModelResponseCopyWithImpl<$Res,
        _$GetRecommendationsModelResponseImpl>
    implements _$$GetRecommendationsModelResponseImplCopyWith<$Res> {
  __$$GetRecommendationsModelResponseImplCopyWithImpl(
      _$GetRecommendationsModelResponseImpl _value,
      $Res Function(_$GetRecommendationsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetRecommendationsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$GetRecommendationsModelResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<GetRecommendationsDataModelResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetRecommendationsModelResponseImpl
    implements _GetRecommendationsModelResponse {
  const _$GetRecommendationsModelResponseImpl(
      {final List<GetRecommendationsDataModelResponse>? data})
      : _data = data;

  factory _$GetRecommendationsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetRecommendationsModelResponseImplFromJson(json);

  final List<GetRecommendationsDataModelResponse>? _data;
  @override
  List<GetRecommendationsDataModelResponse>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetRecommendationsModelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRecommendationsModelResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of GetRecommendationsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetRecommendationsModelResponseImplCopyWith<
          _$GetRecommendationsModelResponseImpl>
      get copyWith => __$$GetRecommendationsModelResponseImplCopyWithImpl<
          _$GetRecommendationsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetRecommendationsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetRecommendationsModelResponse
    implements GetRecommendationsModelResponse {
  const factory _GetRecommendationsModelResponse(
          {final List<GetRecommendationsDataModelResponse>? data}) =
      _$GetRecommendationsModelResponseImpl;

  factory _GetRecommendationsModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetRecommendationsModelResponseImpl.fromJson;

  @override
  List<GetRecommendationsDataModelResponse>? get data;

  /// Create a copy of GetRecommendationsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetRecommendationsModelResponseImplCopyWith<
          _$GetRecommendationsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetRecommendationsDataModelResponse
    _$GetRecommendationsDataModelResponseFromJson(Map<String, dynamic> json) {
  return _GetRecommendationsDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetRecommendationsDataModelResponse {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_id')
  int? get patientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'dose_name')
  String? get doseName => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  String? get dose => throw _privateConstructorUsedError;
  String? get route => throw _privateConstructorUsedError;
  String? get frequency => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;

  /// Serializes this GetRecommendationsDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetRecommendationsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetRecommendationsDataModelResponseCopyWith<
          GetRecommendationsDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetRecommendationsDataModelResponseCopyWith<$Res> {
  factory $GetRecommendationsDataModelResponseCopyWith(
          GetRecommendationsDataModelResponse value,
          $Res Function(GetRecommendationsDataModelResponse) then) =
      _$GetRecommendationsDataModelResponseCopyWithImpl<$Res,
          GetRecommendationsDataModelResponse>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'patient_id') int? patientId,
      @JsonKey(name: 'dose_name') String? doseName,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      String? dose,
      String? route,
      String? frequency,
      String? duration});
}

/// @nodoc
class _$GetRecommendationsDataModelResponseCopyWithImpl<$Res,
        $Val extends GetRecommendationsDataModelResponse>
    implements $GetRecommendationsDataModelResponseCopyWith<$Res> {
  _$GetRecommendationsDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetRecommendationsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? patientId = freezed,
    Object? doseName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? dose = freezed,
    Object? route = freezed,
    Object? frequency = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int?,
      doseName: freezed == doseName
          ? _value.doseName
          : doseName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      dose: freezed == dose
          ? _value.dose
          : dose // ignore: cast_nullable_to_non_nullable
              as String?,
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetRecommendationsDataModelResponseImplCopyWith<$Res>
    implements $GetRecommendationsDataModelResponseCopyWith<$Res> {
  factory _$$GetRecommendationsDataModelResponseImplCopyWith(
          _$GetRecommendationsDataModelResponseImpl value,
          $Res Function(_$GetRecommendationsDataModelResponseImpl) then) =
      __$$GetRecommendationsDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'patient_id') int? patientId,
      @JsonKey(name: 'dose_name') String? doseName,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      String? dose,
      String? route,
      String? frequency,
      String? duration});
}

/// @nodoc
class __$$GetRecommendationsDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetRecommendationsDataModelResponseCopyWithImpl<$Res,
        _$GetRecommendationsDataModelResponseImpl>
    implements _$$GetRecommendationsDataModelResponseImplCopyWith<$Res> {
  __$$GetRecommendationsDataModelResponseImplCopyWithImpl(
      _$GetRecommendationsDataModelResponseImpl _value,
      $Res Function(_$GetRecommendationsDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetRecommendationsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? patientId = freezed,
    Object? doseName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? dose = freezed,
    Object? route = freezed,
    Object? frequency = freezed,
    Object? duration = freezed,
  }) {
    return _then(_$GetRecommendationsDataModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int?,
      doseName: freezed == doseName
          ? _value.doseName
          : doseName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      dose: freezed == dose
          ? _value.dose
          : dose // ignore: cast_nullable_to_non_nullable
              as String?,
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetRecommendationsDataModelResponseImpl
    implements _GetRecommendationsDataModelResponse {
  const _$GetRecommendationsDataModelResponseImpl(
      {this.id,
      @JsonKey(name: 'patient_id') this.patientId,
      @JsonKey(name: 'dose_name') this.doseName,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.dose,
      this.route,
      this.frequency,
      this.duration});

  factory _$GetRecommendationsDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetRecommendationsDataModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'patient_id')
  final int? patientId;
  @override
  @JsonKey(name: 'dose_name')
  final String? doseName;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  final String? dose;
  @override
  final String? route;
  @override
  final String? frequency;
  @override
  final String? duration;

  @override
  String toString() {
    return 'GetRecommendationsDataModelResponse(id: $id, patientId: $patientId, doseName: $doseName, createdAt: $createdAt, updatedAt: $updatedAt, dose: $dose, route: $route, frequency: $frequency, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRecommendationsDataModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.doseName, doseName) ||
                other.doseName == doseName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.dose, dose) || other.dose == dose) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, patientId, doseName,
      createdAt, updatedAt, dose, route, frequency, duration);

  /// Create a copy of GetRecommendationsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetRecommendationsDataModelResponseImplCopyWith<
          _$GetRecommendationsDataModelResponseImpl>
      get copyWith => __$$GetRecommendationsDataModelResponseImplCopyWithImpl<
          _$GetRecommendationsDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetRecommendationsDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetRecommendationsDataModelResponse
    implements GetRecommendationsDataModelResponse {
  const factory _GetRecommendationsDataModelResponse(
      {final int? id,
      @JsonKey(name: 'patient_id') final int? patientId,
      @JsonKey(name: 'dose_name') final String? doseName,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final String? dose,
      final String? route,
      final String? frequency,
      final String? duration}) = _$GetRecommendationsDataModelResponseImpl;

  factory _GetRecommendationsDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetRecommendationsDataModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'patient_id')
  int? get patientId;
  @override
  @JsonKey(name: 'dose_name')
  String? get doseName;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  String? get dose;
  @override
  String? get route;
  @override
  String? get frequency;
  @override
  String? get duration;

  /// Create a copy of GetRecommendationsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetRecommendationsDataModelResponseImplCopyWith<
          _$GetRecommendationsDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
