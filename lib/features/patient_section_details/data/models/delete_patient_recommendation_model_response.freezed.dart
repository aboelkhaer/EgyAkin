// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_patient_recommendation_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeletePatientRecommendationModelResponse
    _$DeletePatientRecommendationModelResponseFromJson(
        Map<String, dynamic> json) {
  return _DeletePatientRecommendationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DeletePatientRecommendationModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this DeletePatientRecommendationModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeletePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeletePatientRecommendationModelResponseCopyWith<
          DeletePatientRecommendationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletePatientRecommendationModelResponseCopyWith<$Res> {
  factory $DeletePatientRecommendationModelResponseCopyWith(
          DeletePatientRecommendationModelResponse value,
          $Res Function(DeletePatientRecommendationModelResponse) then) =
      _$DeletePatientRecommendationModelResponseCopyWithImpl<$Res,
          DeletePatientRecommendationModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$DeletePatientRecommendationModelResponseCopyWithImpl<$Res,
        $Val extends DeletePatientRecommendationModelResponse>
    implements $DeletePatientRecommendationModelResponseCopyWith<$Res> {
  _$DeletePatientRecommendationModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeletePatientRecommendationModelResponse
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
abstract class _$$DeletePatientRecommendationModelResponseImplCopyWith<$Res>
    implements $DeletePatientRecommendationModelResponseCopyWith<$Res> {
  factory _$$DeletePatientRecommendationModelResponseImplCopyWith(
          _$DeletePatientRecommendationModelResponseImpl value,
          $Res Function(_$DeletePatientRecommendationModelResponseImpl) then) =
      __$$DeletePatientRecommendationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$DeletePatientRecommendationModelResponseImplCopyWithImpl<$Res>
    extends _$DeletePatientRecommendationModelResponseCopyWithImpl<$Res,
        _$DeletePatientRecommendationModelResponseImpl>
    implements _$$DeletePatientRecommendationModelResponseImplCopyWith<$Res> {
  __$$DeletePatientRecommendationModelResponseImplCopyWithImpl(
      _$DeletePatientRecommendationModelResponseImpl _value,
      $Res Function(_$DeletePatientRecommendationModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeletePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$DeletePatientRecommendationModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeletePatientRecommendationModelResponseImpl
    implements _DeletePatientRecommendationModelResponse {
  const _$DeletePatientRecommendationModelResponseImpl({this.message});

  factory _$DeletePatientRecommendationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DeletePatientRecommendationModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'DeletePatientRecommendationModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePatientRecommendationModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of DeletePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePatientRecommendationModelResponseImplCopyWith<
          _$DeletePatientRecommendationModelResponseImpl>
      get copyWith =>
          __$$DeletePatientRecommendationModelResponseImplCopyWithImpl<
              _$DeletePatientRecommendationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletePatientRecommendationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DeletePatientRecommendationModelResponse
    implements DeletePatientRecommendationModelResponse {
  const factory _DeletePatientRecommendationModelResponse(
      {final String? message}) = _$DeletePatientRecommendationModelResponseImpl;

  factory _DeletePatientRecommendationModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$DeletePatientRecommendationModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of DeletePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeletePatientRecommendationModelResponseImplCopyWith<
          _$DeletePatientRecommendationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
