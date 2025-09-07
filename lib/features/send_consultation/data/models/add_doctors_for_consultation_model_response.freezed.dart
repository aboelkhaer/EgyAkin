// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_doctors_for_consultation_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddDoctorsForConsultationModelResponse
    _$AddDoctorsForConsultationModelResponseFromJson(
        Map<String, dynamic> json) {
  return _AddDoctorsForConsultationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AddDoctorsForConsultationModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this AddDoctorsForConsultationModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddDoctorsForConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddDoctorsForConsultationModelResponseCopyWith<
          AddDoctorsForConsultationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddDoctorsForConsultationModelResponseCopyWith<$Res> {
  factory $AddDoctorsForConsultationModelResponseCopyWith(
          AddDoctorsForConsultationModelResponse value,
          $Res Function(AddDoctorsForConsultationModelResponse) then) =
      _$AddDoctorsForConsultationModelResponseCopyWithImpl<$Res,
          AddDoctorsForConsultationModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$AddDoctorsForConsultationModelResponseCopyWithImpl<$Res,
        $Val extends AddDoctorsForConsultationModelResponse>
    implements $AddDoctorsForConsultationModelResponseCopyWith<$Res> {
  _$AddDoctorsForConsultationModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddDoctorsForConsultationModelResponse
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
abstract class _$$AddDoctorsForConsultationModelResponseImplCopyWith<$Res>
    implements $AddDoctorsForConsultationModelResponseCopyWith<$Res> {
  factory _$$AddDoctorsForConsultationModelResponseImplCopyWith(
          _$AddDoctorsForConsultationModelResponseImpl value,
          $Res Function(_$AddDoctorsForConsultationModelResponseImpl) then) =
      __$$AddDoctorsForConsultationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$AddDoctorsForConsultationModelResponseImplCopyWithImpl<$Res>
    extends _$AddDoctorsForConsultationModelResponseCopyWithImpl<$Res,
        _$AddDoctorsForConsultationModelResponseImpl>
    implements _$$AddDoctorsForConsultationModelResponseImplCopyWith<$Res> {
  __$$AddDoctorsForConsultationModelResponseImplCopyWithImpl(
      _$AddDoctorsForConsultationModelResponseImpl _value,
      $Res Function(_$AddDoctorsForConsultationModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddDoctorsForConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$AddDoctorsForConsultationModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddDoctorsForConsultationModelResponseImpl
    implements _AddDoctorsForConsultationModelResponse {
  const _$AddDoctorsForConsultationModelResponseImpl({this.message});

  factory _$AddDoctorsForConsultationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddDoctorsForConsultationModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'AddDoctorsForConsultationModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddDoctorsForConsultationModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AddDoctorsForConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddDoctorsForConsultationModelResponseImplCopyWith<
          _$AddDoctorsForConsultationModelResponseImpl>
      get copyWith =>
          __$$AddDoctorsForConsultationModelResponseImplCopyWithImpl<
              _$AddDoctorsForConsultationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddDoctorsForConsultationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AddDoctorsForConsultationModelResponse
    implements AddDoctorsForConsultationModelResponse {
  const factory _AddDoctorsForConsultationModelResponse(
      {final String? message}) = _$AddDoctorsForConsultationModelResponseImpl;

  factory _AddDoctorsForConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$AddDoctorsForConsultationModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of AddDoctorsForConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddDoctorsForConsultationModelResponseImplCopyWith<
          _$AddDoctorsForConsultationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
