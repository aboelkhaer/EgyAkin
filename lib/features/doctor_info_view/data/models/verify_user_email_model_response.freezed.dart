// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_user_email_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerifyUserEmailModelResponse _$VerifyUserEmailModelResponseFromJson(
    Map<String, dynamic> json) {
  return _VerifyUserEmailModelResponse.fromJson(json);
}

/// @nodoc
mixin _$VerifyUserEmailModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this VerifyUserEmailModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerifyUserEmailModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerifyUserEmailModelResponseCopyWith<VerifyUserEmailModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyUserEmailModelResponseCopyWith<$Res> {
  factory $VerifyUserEmailModelResponseCopyWith(
          VerifyUserEmailModelResponse value,
          $Res Function(VerifyUserEmailModelResponse) then) =
      _$VerifyUserEmailModelResponseCopyWithImpl<$Res,
          VerifyUserEmailModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$VerifyUserEmailModelResponseCopyWithImpl<$Res,
        $Val extends VerifyUserEmailModelResponse>
    implements $VerifyUserEmailModelResponseCopyWith<$Res> {
  _$VerifyUserEmailModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyUserEmailModelResponse
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
abstract class _$$VerifyUserEmailModelResponseImplCopyWith<$Res>
    implements $VerifyUserEmailModelResponseCopyWith<$Res> {
  factory _$$VerifyUserEmailModelResponseImplCopyWith(
          _$VerifyUserEmailModelResponseImpl value,
          $Res Function(_$VerifyUserEmailModelResponseImpl) then) =
      __$$VerifyUserEmailModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$VerifyUserEmailModelResponseImplCopyWithImpl<$Res>
    extends _$VerifyUserEmailModelResponseCopyWithImpl<$Res,
        _$VerifyUserEmailModelResponseImpl>
    implements _$$VerifyUserEmailModelResponseImplCopyWith<$Res> {
  __$$VerifyUserEmailModelResponseImplCopyWithImpl(
      _$VerifyUserEmailModelResponseImpl _value,
      $Res Function(_$VerifyUserEmailModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerifyUserEmailModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$VerifyUserEmailModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyUserEmailModelResponseImpl
    implements _VerifyUserEmailModelResponse {
  const _$VerifyUserEmailModelResponseImpl({this.message});

  factory _$VerifyUserEmailModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$VerifyUserEmailModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'VerifyUserEmailModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyUserEmailModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of VerifyUserEmailModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyUserEmailModelResponseImplCopyWith<
          _$VerifyUserEmailModelResponseImpl>
      get copyWith => __$$VerifyUserEmailModelResponseImplCopyWithImpl<
          _$VerifyUserEmailModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyUserEmailModelResponseImplToJson(
      this,
    );
  }
}

abstract class _VerifyUserEmailModelResponse
    implements VerifyUserEmailModelResponse {
  const factory _VerifyUserEmailModelResponse({final String? message}) =
      _$VerifyUserEmailModelResponseImpl;

  factory _VerifyUserEmailModelResponse.fromJson(Map<String, dynamic> json) =
      _$VerifyUserEmailModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of VerifyUserEmailModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyUserEmailModelResponseImplCopyWith<
          _$VerifyUserEmailModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
