// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_out_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignOutModelResponse _$SignOutModelResponseFromJson(Map<String, dynamic> json) {
  return _SignOutModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SignOutModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this SignOutModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignOutModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignOutModelResponseCopyWith<SignOutModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignOutModelResponseCopyWith<$Res> {
  factory $SignOutModelResponseCopyWith(SignOutModelResponse value,
          $Res Function(SignOutModelResponse) then) =
      _$SignOutModelResponseCopyWithImpl<$Res, SignOutModelResponse>;
  @useResult
  $Res call({bool? value, String? message});
}

/// @nodoc
class _$SignOutModelResponseCopyWithImpl<$Res,
        $Val extends SignOutModelResponse>
    implements $SignOutModelResponseCopyWith<$Res> {
  _$SignOutModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignOutModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignOutModelResponseImplCopyWith<$Res>
    implements $SignOutModelResponseCopyWith<$Res> {
  factory _$$SignOutModelResponseImplCopyWith(_$SignOutModelResponseImpl value,
          $Res Function(_$SignOutModelResponseImpl) then) =
      __$$SignOutModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message});
}

/// @nodoc
class __$$SignOutModelResponseImplCopyWithImpl<$Res>
    extends _$SignOutModelResponseCopyWithImpl<$Res, _$SignOutModelResponseImpl>
    implements _$$SignOutModelResponseImplCopyWith<$Res> {
  __$$SignOutModelResponseImplCopyWithImpl(_$SignOutModelResponseImpl _value,
      $Res Function(_$SignOutModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignOutModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
  }) {
    return _then(_$SignOutModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignOutModelResponseImpl implements _SignOutModelResponse {
  const _$SignOutModelResponseImpl({this.value, this.message});

  factory _$SignOutModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignOutModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;

  @override
  String toString() {
    return 'SignOutModelResponse(value: $value, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignOutModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, message);

  /// Create a copy of SignOutModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignOutModelResponseImplCopyWith<_$SignOutModelResponseImpl>
      get copyWith =>
          __$$SignOutModelResponseImplCopyWithImpl<_$SignOutModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignOutModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SignOutModelResponse implements SignOutModelResponse {
  const factory _SignOutModelResponse(
      {final bool? value, final String? message}) = _$SignOutModelResponseImpl;

  factory _SignOutModelResponse.fromJson(Map<String, dynamic> json) =
      _$SignOutModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;

  /// Create a copy of SignOutModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignOutModelResponseImplCopyWith<_$SignOutModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
