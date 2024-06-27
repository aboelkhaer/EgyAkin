// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_fcm_token_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendFCMTokenModelResponse _$SendFCMTokenModelResponseFromJson(
    Map<String, dynamic> json) {
  return _SendFCMTokenModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SendFCMTokenModelResponse {
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendFCMTokenModelResponseCopyWith<SendFCMTokenModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendFCMTokenModelResponseCopyWith<$Res> {
  factory $SendFCMTokenModelResponseCopyWith(SendFCMTokenModelResponse value,
          $Res Function(SendFCMTokenModelResponse) then) =
      _$SendFCMTokenModelResponseCopyWithImpl<$Res, SendFCMTokenModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$SendFCMTokenModelResponseCopyWithImpl<$Res,
        $Val extends SendFCMTokenModelResponse>
    implements $SendFCMTokenModelResponseCopyWith<$Res> {
  _$SendFCMTokenModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$SendFCMTokenModelResponseImplCopyWith<$Res>
    implements $SendFCMTokenModelResponseCopyWith<$Res> {
  factory _$$SendFCMTokenModelResponseImplCopyWith(
          _$SendFCMTokenModelResponseImpl value,
          $Res Function(_$SendFCMTokenModelResponseImpl) then) =
      __$$SendFCMTokenModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$SendFCMTokenModelResponseImplCopyWithImpl<$Res>
    extends _$SendFCMTokenModelResponseCopyWithImpl<$Res,
        _$SendFCMTokenModelResponseImpl>
    implements _$$SendFCMTokenModelResponseImplCopyWith<$Res> {
  __$$SendFCMTokenModelResponseImplCopyWithImpl(
      _$SendFCMTokenModelResponseImpl _value,
      $Res Function(_$SendFCMTokenModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$SendFCMTokenModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendFCMTokenModelResponseImpl implements _SendFCMTokenModelResponse {
  const _$SendFCMTokenModelResponseImpl({this.message});

  factory _$SendFCMTokenModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendFCMTokenModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'SendFCMTokenModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendFCMTokenModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendFCMTokenModelResponseImplCopyWith<_$SendFCMTokenModelResponseImpl>
      get copyWith => __$$SendFCMTokenModelResponseImplCopyWithImpl<
          _$SendFCMTokenModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendFCMTokenModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SendFCMTokenModelResponse implements SendFCMTokenModelResponse {
  const factory _SendFCMTokenModelResponse({final String? message}) =
      _$SendFCMTokenModelResponseImpl;

  factory _SendFCMTokenModelResponse.fromJson(Map<String, dynamic> json) =
      _$SendFCMTokenModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$SendFCMTokenModelResponseImplCopyWith<_$SendFCMTokenModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
