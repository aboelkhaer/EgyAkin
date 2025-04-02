// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accept_or_decline_member_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AcceptOrDeclineMemberModelResponse _$AcceptOrDeclineMemberModelResponseFromJson(
    Map<String, dynamic> json) {
  return _AcceptOrDeclineMemberModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AcceptOrDeclineMemberModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this AcceptOrDeclineMemberModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AcceptOrDeclineMemberModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcceptOrDeclineMemberModelResponseCopyWith<
          AcceptOrDeclineMemberModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcceptOrDeclineMemberModelResponseCopyWith<$Res> {
  factory $AcceptOrDeclineMemberModelResponseCopyWith(
          AcceptOrDeclineMemberModelResponse value,
          $Res Function(AcceptOrDeclineMemberModelResponse) then) =
      _$AcceptOrDeclineMemberModelResponseCopyWithImpl<$Res,
          AcceptOrDeclineMemberModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$AcceptOrDeclineMemberModelResponseCopyWithImpl<$Res,
        $Val extends AcceptOrDeclineMemberModelResponse>
    implements $AcceptOrDeclineMemberModelResponseCopyWith<$Res> {
  _$AcceptOrDeclineMemberModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcceptOrDeclineMemberModelResponse
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
abstract class _$$AcceptOrDeclineMemberModelResponseImplCopyWith<$Res>
    implements $AcceptOrDeclineMemberModelResponseCopyWith<$Res> {
  factory _$$AcceptOrDeclineMemberModelResponseImplCopyWith(
          _$AcceptOrDeclineMemberModelResponseImpl value,
          $Res Function(_$AcceptOrDeclineMemberModelResponseImpl) then) =
      __$$AcceptOrDeclineMemberModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$AcceptOrDeclineMemberModelResponseImplCopyWithImpl<$Res>
    extends _$AcceptOrDeclineMemberModelResponseCopyWithImpl<$Res,
        _$AcceptOrDeclineMemberModelResponseImpl>
    implements _$$AcceptOrDeclineMemberModelResponseImplCopyWith<$Res> {
  __$$AcceptOrDeclineMemberModelResponseImplCopyWithImpl(
      _$AcceptOrDeclineMemberModelResponseImpl _value,
      $Res Function(_$AcceptOrDeclineMemberModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AcceptOrDeclineMemberModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$AcceptOrDeclineMemberModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AcceptOrDeclineMemberModelResponseImpl
    implements _AcceptOrDeclineMemberModelResponse {
  const _$AcceptOrDeclineMemberModelResponseImpl({this.message});

  factory _$AcceptOrDeclineMemberModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AcceptOrDeclineMemberModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'AcceptOrDeclineMemberModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptOrDeclineMemberModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AcceptOrDeclineMemberModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcceptOrDeclineMemberModelResponseImplCopyWith<
          _$AcceptOrDeclineMemberModelResponseImpl>
      get copyWith => __$$AcceptOrDeclineMemberModelResponseImplCopyWithImpl<
          _$AcceptOrDeclineMemberModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AcceptOrDeclineMemberModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AcceptOrDeclineMemberModelResponse
    implements AcceptOrDeclineMemberModelResponse {
  const factory _AcceptOrDeclineMemberModelResponse({final String? message}) =
      _$AcceptOrDeclineMemberModelResponseImpl;

  factory _AcceptOrDeclineMemberModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$AcceptOrDeclineMemberModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of AcceptOrDeclineMemberModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcceptOrDeclineMemberModelResponseImplCopyWith<
          _$AcceptOrDeclineMemberModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
