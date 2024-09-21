// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_patient_comment_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddPatientCommentsModelResponse _$AddPatientCommentsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _AddPatientCommentsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AddPatientCommentsModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this AddPatientCommentsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddPatientCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddPatientCommentsModelResponseCopyWith<AddPatientCommentsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddPatientCommentsModelResponseCopyWith<$Res> {
  factory $AddPatientCommentsModelResponseCopyWith(
          AddPatientCommentsModelResponse value,
          $Res Function(AddPatientCommentsModelResponse) then) =
      _$AddPatientCommentsModelResponseCopyWithImpl<$Res,
          AddPatientCommentsModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$AddPatientCommentsModelResponseCopyWithImpl<$Res,
        $Val extends AddPatientCommentsModelResponse>
    implements $AddPatientCommentsModelResponseCopyWith<$Res> {
  _$AddPatientCommentsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddPatientCommentsModelResponse
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
abstract class _$$AddPatientCommentsModelResponseImplCopyWith<$Res>
    implements $AddPatientCommentsModelResponseCopyWith<$Res> {
  factory _$$AddPatientCommentsModelResponseImplCopyWith(
          _$AddPatientCommentsModelResponseImpl value,
          $Res Function(_$AddPatientCommentsModelResponseImpl) then) =
      __$$AddPatientCommentsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$AddPatientCommentsModelResponseImplCopyWithImpl<$Res>
    extends _$AddPatientCommentsModelResponseCopyWithImpl<$Res,
        _$AddPatientCommentsModelResponseImpl>
    implements _$$AddPatientCommentsModelResponseImplCopyWith<$Res> {
  __$$AddPatientCommentsModelResponseImplCopyWithImpl(
      _$AddPatientCommentsModelResponseImpl _value,
      $Res Function(_$AddPatientCommentsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddPatientCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$AddPatientCommentsModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddPatientCommentsModelResponseImpl
    implements _AddPatientCommentsModelResponse {
  const _$AddPatientCommentsModelResponseImpl({this.message});

  factory _$AddPatientCommentsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddPatientCommentsModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'AddPatientCommentsModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddPatientCommentsModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AddPatientCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddPatientCommentsModelResponseImplCopyWith<
          _$AddPatientCommentsModelResponseImpl>
      get copyWith => __$$AddPatientCommentsModelResponseImplCopyWithImpl<
          _$AddPatientCommentsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddPatientCommentsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AddPatientCommentsModelResponse
    implements AddPatientCommentsModelResponse {
  const factory _AddPatientCommentsModelResponse({final String? message}) =
      _$AddPatientCommentsModelResponseImpl;

  factory _AddPatientCommentsModelResponse.fromJson(Map<String, dynamic> json) =
      _$AddPatientCommentsModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of AddPatientCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddPatientCommentsModelResponseImplCopyWith<
          _$AddPatientCommentsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
