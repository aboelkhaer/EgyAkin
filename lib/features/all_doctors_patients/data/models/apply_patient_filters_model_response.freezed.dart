// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apply_patient_filters_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApplyPatientFiltersModelResponse _$ApplyPatientFiltersModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ApplyPatientFiltersModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ApplyPatientFiltersModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ApplyPatientFiltersModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApplyPatientFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplyPatientFiltersModelResponseCopyWith<ApplyPatientFiltersModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplyPatientFiltersModelResponseCopyWith<$Res> {
  factory $ApplyPatientFiltersModelResponseCopyWith(
          ApplyPatientFiltersModelResponse value,
          $Res Function(ApplyPatientFiltersModelResponse) then) =
      _$ApplyPatientFiltersModelResponseCopyWithImpl<$Res,
          ApplyPatientFiltersModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$ApplyPatientFiltersModelResponseCopyWithImpl<$Res,
        $Val extends ApplyPatientFiltersModelResponse>
    implements $ApplyPatientFiltersModelResponseCopyWith<$Res> {
  _$ApplyPatientFiltersModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApplyPatientFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplyPatientFiltersModelResponseImplCopyWith<$Res>
    implements $ApplyPatientFiltersModelResponseCopyWith<$Res> {
  factory _$$ApplyPatientFiltersModelResponseImplCopyWith(
          _$ApplyPatientFiltersModelResponseImpl value,
          $Res Function(_$ApplyPatientFiltersModelResponseImpl) then) =
      __$$ApplyPatientFiltersModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ApplyPatientFiltersModelResponseImplCopyWithImpl<$Res>
    extends _$ApplyPatientFiltersModelResponseCopyWithImpl<$Res,
        _$ApplyPatientFiltersModelResponseImpl>
    implements _$$ApplyPatientFiltersModelResponseImplCopyWith<$Res> {
  __$$ApplyPatientFiltersModelResponseImplCopyWithImpl(
      _$ApplyPatientFiltersModelResponseImpl _value,
      $Res Function(_$ApplyPatientFiltersModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApplyPatientFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ApplyPatientFiltersModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplyPatientFiltersModelResponseImpl
    implements _ApplyPatientFiltersModelResponse {
  const _$ApplyPatientFiltersModelResponseImpl({this.message});

  factory _$ApplyPatientFiltersModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ApplyPatientFiltersModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'ApplyPatientFiltersModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplyPatientFiltersModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ApplyPatientFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplyPatientFiltersModelResponseImplCopyWith<
          _$ApplyPatientFiltersModelResponseImpl>
      get copyWith => __$$ApplyPatientFiltersModelResponseImplCopyWithImpl<
          _$ApplyPatientFiltersModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplyPatientFiltersModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ApplyPatientFiltersModelResponse
    implements ApplyPatientFiltersModelResponse {
  const factory _ApplyPatientFiltersModelResponse({final String? message}) =
      _$ApplyPatientFiltersModelResponseImpl;

  factory _ApplyPatientFiltersModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$ApplyPatientFiltersModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of ApplyPatientFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplyPatientFiltersModelResponseImplCopyWith<
          _$ApplyPatientFiltersModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
