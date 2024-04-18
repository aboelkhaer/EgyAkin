// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_otp_for_email_verification_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendOTPForEmailVerificationModelResponse
    _$SendOTPForEmailVerificationModelResponseFromJson(
        Map<String, dynamic> json) {
  return _SendOTPForEmailVerificationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SendOTPForEmailVerificationModelResponse {
  bool? get success => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendOTPForEmailVerificationModelResponseCopyWith<
          SendOTPForEmailVerificationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendOTPForEmailVerificationModelResponseCopyWith<$Res> {
  factory $SendOTPForEmailVerificationModelResponseCopyWith(
          SendOTPForEmailVerificationModelResponse value,
          $Res Function(SendOTPForEmailVerificationModelResponse) then) =
      _$SendOTPForEmailVerificationModelResponseCopyWithImpl<$Res,
          SendOTPForEmailVerificationModelResponse>;
  @useResult
  $Res call({bool? success});
}

/// @nodoc
class _$SendOTPForEmailVerificationModelResponseCopyWithImpl<$Res,
        $Val extends SendOTPForEmailVerificationModelResponse>
    implements $SendOTPForEmailVerificationModelResponseCopyWith<$Res> {
  _$SendOTPForEmailVerificationModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
  }) {
    return _then(_value.copyWith(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendOTPForEmailVerificationModelResponseImplCopyWith<$Res>
    implements $SendOTPForEmailVerificationModelResponseCopyWith<$Res> {
  factory _$$SendOTPForEmailVerificationModelResponseImplCopyWith(
          _$SendOTPForEmailVerificationModelResponseImpl value,
          $Res Function(_$SendOTPForEmailVerificationModelResponseImpl) then) =
      __$$SendOTPForEmailVerificationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? success});
}

/// @nodoc
class __$$SendOTPForEmailVerificationModelResponseImplCopyWithImpl<$Res>
    extends _$SendOTPForEmailVerificationModelResponseCopyWithImpl<$Res,
        _$SendOTPForEmailVerificationModelResponseImpl>
    implements _$$SendOTPForEmailVerificationModelResponseImplCopyWith<$Res> {
  __$$SendOTPForEmailVerificationModelResponseImplCopyWithImpl(
      _$SendOTPForEmailVerificationModelResponseImpl _value,
      $Res Function(_$SendOTPForEmailVerificationModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
  }) {
    return _then(_$SendOTPForEmailVerificationModelResponseImpl(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendOTPForEmailVerificationModelResponseImpl
    implements _SendOTPForEmailVerificationModelResponse {
  const _$SendOTPForEmailVerificationModelResponseImpl({this.success});

  factory _$SendOTPForEmailVerificationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SendOTPForEmailVerificationModelResponseImplFromJson(json);

  @override
  final bool? success;

  @override
  String toString() {
    return 'SendOTPForEmailVerificationModelResponse(success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendOTPForEmailVerificationModelResponseImpl &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendOTPForEmailVerificationModelResponseImplCopyWith<
          _$SendOTPForEmailVerificationModelResponseImpl>
      get copyWith =>
          __$$SendOTPForEmailVerificationModelResponseImplCopyWithImpl<
              _$SendOTPForEmailVerificationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendOTPForEmailVerificationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SendOTPForEmailVerificationModelResponse
    implements SendOTPForEmailVerificationModelResponse {
  const factory _SendOTPForEmailVerificationModelResponse(
      {final bool? success}) = _$SendOTPForEmailVerificationModelResponseImpl;

  factory _SendOTPForEmailVerificationModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$SendOTPForEmailVerificationModelResponseImpl.fromJson;

  @override
  bool? get success;
  @override
  @JsonKey(ignore: true)
  _$$SendOTPForEmailVerificationModelResponseImplCopyWith<
          _$SendOTPForEmailVerificationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
