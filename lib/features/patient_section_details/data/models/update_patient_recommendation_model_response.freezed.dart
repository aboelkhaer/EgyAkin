// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_patient_recommendation_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdatePatientRecommendationModelResponse
    _$UpdatePatientRecommendationModelResponseFromJson(
        Map<String, dynamic> json) {
  return _UpdatePatientRecommendationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$UpdatePatientRecommendationModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this UpdatePatientRecommendationModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePatientRecommendationModelResponseCopyWith<
          UpdatePatientRecommendationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePatientRecommendationModelResponseCopyWith<$Res> {
  factory $UpdatePatientRecommendationModelResponseCopyWith(
          UpdatePatientRecommendationModelResponse value,
          $Res Function(UpdatePatientRecommendationModelResponse) then) =
      _$UpdatePatientRecommendationModelResponseCopyWithImpl<$Res,
          UpdatePatientRecommendationModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$UpdatePatientRecommendationModelResponseCopyWithImpl<$Res,
        $Val extends UpdatePatientRecommendationModelResponse>
    implements $UpdatePatientRecommendationModelResponseCopyWith<$Res> {
  _$UpdatePatientRecommendationModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePatientRecommendationModelResponse
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
abstract class _$$UpdatePatientRecommendationModelResponseImplCopyWith<$Res>
    implements $UpdatePatientRecommendationModelResponseCopyWith<$Res> {
  factory _$$UpdatePatientRecommendationModelResponseImplCopyWith(
          _$UpdatePatientRecommendationModelResponseImpl value,
          $Res Function(_$UpdatePatientRecommendationModelResponseImpl) then) =
      __$$UpdatePatientRecommendationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UpdatePatientRecommendationModelResponseImplCopyWithImpl<$Res>
    extends _$UpdatePatientRecommendationModelResponseCopyWithImpl<$Res,
        _$UpdatePatientRecommendationModelResponseImpl>
    implements _$$UpdatePatientRecommendationModelResponseImplCopyWith<$Res> {
  __$$UpdatePatientRecommendationModelResponseImplCopyWithImpl(
      _$UpdatePatientRecommendationModelResponseImpl _value,
      $Res Function(_$UpdatePatientRecommendationModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UpdatePatientRecommendationModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePatientRecommendationModelResponseImpl
    implements _UpdatePatientRecommendationModelResponse {
  const _$UpdatePatientRecommendationModelResponseImpl({this.message});

  factory _$UpdatePatientRecommendationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UpdatePatientRecommendationModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'UpdatePatientRecommendationModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePatientRecommendationModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of UpdatePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePatientRecommendationModelResponseImplCopyWith<
          _$UpdatePatientRecommendationModelResponseImpl>
      get copyWith =>
          __$$UpdatePatientRecommendationModelResponseImplCopyWithImpl<
              _$UpdatePatientRecommendationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePatientRecommendationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _UpdatePatientRecommendationModelResponse
    implements UpdatePatientRecommendationModelResponse {
  const factory _UpdatePatientRecommendationModelResponse(
      {final String? message}) = _$UpdatePatientRecommendationModelResponseImpl;

  factory _UpdatePatientRecommendationModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$UpdatePatientRecommendationModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of UpdatePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePatientRecommendationModelResponseImplCopyWith<
          _$UpdatePatientRecommendationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
