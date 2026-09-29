// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_sort_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SortOptionModelResponse _$SortOptionModelResponseFromJson(
    Map<String, dynamic> json) {
  return _SortOptionModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SortOptionModelResponse {
  String? get key => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'default_direction')
  String? get defaultDirection => throw _privateConstructorUsedError;

  /// Serializes this SortOptionModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SortOptionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SortOptionModelResponseCopyWith<SortOptionModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SortOptionModelResponseCopyWith<$Res> {
  factory $SortOptionModelResponseCopyWith(SortOptionModelResponse value,
          $Res Function(SortOptionModelResponse) then) =
      _$SortOptionModelResponseCopyWithImpl<$Res, SortOptionModelResponse>;
  @useResult
  $Res call(
      {String? key,
      String? label,
      @JsonKey(name: 'default_direction') String? defaultDirection});
}

/// @nodoc
class _$SortOptionModelResponseCopyWithImpl<$Res,
        $Val extends SortOptionModelResponse>
    implements $SortOptionModelResponseCopyWith<$Res> {
  _$SortOptionModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SortOptionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? label = freezed,
    Object? defaultDirection = freezed,
  }) {
    return _then(_value.copyWith(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultDirection: freezed == defaultDirection
          ? _value.defaultDirection
          : defaultDirection // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SortOptionModelResponseImplCopyWith<$Res>
    implements $SortOptionModelResponseCopyWith<$Res> {
  factory _$$SortOptionModelResponseImplCopyWith(
          _$SortOptionModelResponseImpl value,
          $Res Function(_$SortOptionModelResponseImpl) then) =
      __$$SortOptionModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? key,
      String? label,
      @JsonKey(name: 'default_direction') String? defaultDirection});
}

/// @nodoc
class __$$SortOptionModelResponseImplCopyWithImpl<$Res>
    extends _$SortOptionModelResponseCopyWithImpl<$Res,
        _$SortOptionModelResponseImpl>
    implements _$$SortOptionModelResponseImplCopyWith<$Res> {
  __$$SortOptionModelResponseImplCopyWithImpl(
      _$SortOptionModelResponseImpl _value,
      $Res Function(_$SortOptionModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SortOptionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? label = freezed,
    Object? defaultDirection = freezed,
  }) {
    return _then(_$SortOptionModelResponseImpl(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultDirection: freezed == defaultDirection
          ? _value.defaultDirection
          : defaultDirection // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SortOptionModelResponseImpl implements _SortOptionModelResponse {
  const _$SortOptionModelResponseImpl(
      {this.key,
      this.label,
      @JsonKey(name: 'default_direction') this.defaultDirection});

  factory _$SortOptionModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SortOptionModelResponseImplFromJson(json);

  @override
  final String? key;
  @override
  final String? label;
  @override
  @JsonKey(name: 'default_direction')
  final String? defaultDirection;

  @override
  String toString() {
    return 'SortOptionModelResponse(key: $key, label: $label, defaultDirection: $defaultDirection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SortOptionModelResponseImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.defaultDirection, defaultDirection) ||
                other.defaultDirection == defaultDirection));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key, label, defaultDirection);

  /// Create a copy of SortOptionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SortOptionModelResponseImplCopyWith<_$SortOptionModelResponseImpl>
      get copyWith => __$$SortOptionModelResponseImplCopyWithImpl<
          _$SortOptionModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SortOptionModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SortOptionModelResponse implements SortOptionModelResponse {
  const factory _SortOptionModelResponse(
          {final String? key,
          final String? label,
          @JsonKey(name: 'default_direction') final String? defaultDirection}) =
      _$SortOptionModelResponseImpl;

  factory _SortOptionModelResponse.fromJson(Map<String, dynamic> json) =
      _$SortOptionModelResponseImpl.fromJson;

  @override
  String? get key;
  @override
  String? get label;
  @override
  @JsonKey(name: 'default_direction')
  String? get defaultDirection;

  /// Create a copy of SortOptionModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SortOptionModelResponseImplCopyWith<_$SortOptionModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AppliedSortModelResponse _$AppliedSortModelResponseFromJson(
    Map<String, dynamic> json) {
  return _AppliedSortModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AppliedSortModelResponse {
  String? get key => throw _privateConstructorUsedError;
  String? get direction => throw _privateConstructorUsedError;

  /// Serializes this AppliedSortModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppliedSortModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppliedSortModelResponseCopyWith<AppliedSortModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppliedSortModelResponseCopyWith<$Res> {
  factory $AppliedSortModelResponseCopyWith(AppliedSortModelResponse value,
          $Res Function(AppliedSortModelResponse) then) =
      _$AppliedSortModelResponseCopyWithImpl<$Res, AppliedSortModelResponse>;
  @useResult
  $Res call({String? key, String? direction});
}

/// @nodoc
class _$AppliedSortModelResponseCopyWithImpl<$Res,
        $Val extends AppliedSortModelResponse>
    implements $AppliedSortModelResponseCopyWith<$Res> {
  _$AppliedSortModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppliedSortModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? direction = freezed,
  }) {
    return _then(_value.copyWith(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppliedSortModelResponseImplCopyWith<$Res>
    implements $AppliedSortModelResponseCopyWith<$Res> {
  factory _$$AppliedSortModelResponseImplCopyWith(
          _$AppliedSortModelResponseImpl value,
          $Res Function(_$AppliedSortModelResponseImpl) then) =
      __$$AppliedSortModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? key, String? direction});
}

/// @nodoc
class __$$AppliedSortModelResponseImplCopyWithImpl<$Res>
    extends _$AppliedSortModelResponseCopyWithImpl<$Res,
        _$AppliedSortModelResponseImpl>
    implements _$$AppliedSortModelResponseImplCopyWith<$Res> {
  __$$AppliedSortModelResponseImplCopyWithImpl(
      _$AppliedSortModelResponseImpl _value,
      $Res Function(_$AppliedSortModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppliedSortModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? direction = freezed,
  }) {
    return _then(_$AppliedSortModelResponseImpl(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppliedSortModelResponseImpl implements _AppliedSortModelResponse {
  const _$AppliedSortModelResponseImpl({this.key, this.direction});

  factory _$AppliedSortModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppliedSortModelResponseImplFromJson(json);

  @override
  final String? key;
  @override
  final String? direction;

  @override
  String toString() {
    return 'AppliedSortModelResponse(key: $key, direction: $direction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppliedSortModelResponseImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key, direction);

  /// Create a copy of AppliedSortModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppliedSortModelResponseImplCopyWith<_$AppliedSortModelResponseImpl>
      get copyWith => __$$AppliedSortModelResponseImplCopyWithImpl<
          _$AppliedSortModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppliedSortModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AppliedSortModelResponse implements AppliedSortModelResponse {
  const factory _AppliedSortModelResponse(
      {final String? key,
      final String? direction}) = _$AppliedSortModelResponseImpl;

  factory _AppliedSortModelResponse.fromJson(Map<String, dynamic> json) =
      _$AppliedSortModelResponseImpl.fromJson;

  @override
  String? get key;
  @override
  String? get direction;

  /// Create a copy of AppliedSortModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppliedSortModelResponseImplCopyWith<_$AppliedSortModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
