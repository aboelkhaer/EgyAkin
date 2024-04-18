// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_email_for_verification_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendEmailForVerificationModelResponse
    _$SendEmailForVerificationModelResponseFromJson(Map<String, dynamic> json) {
  return _SendEmailForVerificationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SendEmailForVerificationModelResponse {
  bool? get success => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendEmailForVerificationModelResponseCopyWith<
          SendEmailForVerificationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendEmailForVerificationModelResponseCopyWith<$Res> {
  factory $SendEmailForVerificationModelResponseCopyWith(
          SendEmailForVerificationModelResponse value,
          $Res Function(SendEmailForVerificationModelResponse) then) =
      _$SendEmailForVerificationModelResponseCopyWithImpl<$Res,
          SendEmailForVerificationModelResponse>;
  @useResult
  $Res call({bool? success});
}

/// @nodoc
class _$SendEmailForVerificationModelResponseCopyWithImpl<$Res,
        $Val extends SendEmailForVerificationModelResponse>
    implements $SendEmailForVerificationModelResponseCopyWith<$Res> {
  _$SendEmailForVerificationModelResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$SendEmailForVerificationModelResponseImplCopyWith<$Res>
    implements $SendEmailForVerificationModelResponseCopyWith<$Res> {
  factory _$$SendEmailForVerificationModelResponseImplCopyWith(
          _$SendEmailForVerificationModelResponseImpl value,
          $Res Function(_$SendEmailForVerificationModelResponseImpl) then) =
      __$$SendEmailForVerificationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? success});
}

/// @nodoc
class __$$SendEmailForVerificationModelResponseImplCopyWithImpl<$Res>
    extends _$SendEmailForVerificationModelResponseCopyWithImpl<$Res,
        _$SendEmailForVerificationModelResponseImpl>
    implements _$$SendEmailForVerificationModelResponseImplCopyWith<$Res> {
  __$$SendEmailForVerificationModelResponseImplCopyWithImpl(
      _$SendEmailForVerificationModelResponseImpl _value,
      $Res Function(_$SendEmailForVerificationModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
  }) {
    return _then(_$SendEmailForVerificationModelResponseImpl(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendEmailForVerificationModelResponseImpl
    implements _SendEmailForVerificationModelResponse {
  const _$SendEmailForVerificationModelResponseImpl({this.success});

  factory _$SendEmailForVerificationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SendEmailForVerificationModelResponseImplFromJson(json);

  @override
  final bool? success;

  @override
  String toString() {
    return 'SendEmailForVerificationModelResponse(success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendEmailForVerificationModelResponseImpl &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendEmailForVerificationModelResponseImplCopyWith<
          _$SendEmailForVerificationModelResponseImpl>
      get copyWith => __$$SendEmailForVerificationModelResponseImplCopyWithImpl<
          _$SendEmailForVerificationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendEmailForVerificationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SendEmailForVerificationModelResponse
    implements SendEmailForVerificationModelResponse {
  const factory _SendEmailForVerificationModelResponse({final bool? success}) =
      _$SendEmailForVerificationModelResponseImpl;

  factory _SendEmailForVerificationModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$SendEmailForVerificationModelResponseImpl.fromJson;

  @override
  bool? get success;
  @override
  @JsonKey(ignore: true)
  _$$SendEmailForVerificationModelResponseImplCopyWith<
          _$SendEmailForVerificationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
