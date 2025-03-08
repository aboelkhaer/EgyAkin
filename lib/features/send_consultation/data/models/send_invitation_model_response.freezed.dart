// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_invitation_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendInvitationModelResponse _$SendInvitationModelResponseFromJson(
    Map<String, dynamic> json) {
  return _SendInvitationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SendInvitationModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this SendInvitationModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendInvitationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendInvitationModelResponseCopyWith<SendInvitationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendInvitationModelResponseCopyWith<$Res> {
  factory $SendInvitationModelResponseCopyWith(
          SendInvitationModelResponse value,
          $Res Function(SendInvitationModelResponse) then) =
      _$SendInvitationModelResponseCopyWithImpl<$Res,
          SendInvitationModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$SendInvitationModelResponseCopyWithImpl<$Res,
        $Val extends SendInvitationModelResponse>
    implements $SendInvitationModelResponseCopyWith<$Res> {
  _$SendInvitationModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendInvitationModelResponse
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
abstract class _$$SendInvitationModelResponseImplCopyWith<$Res>
    implements $SendInvitationModelResponseCopyWith<$Res> {
  factory _$$SendInvitationModelResponseImplCopyWith(
          _$SendInvitationModelResponseImpl value,
          $Res Function(_$SendInvitationModelResponseImpl) then) =
      __$$SendInvitationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$SendInvitationModelResponseImplCopyWithImpl<$Res>
    extends _$SendInvitationModelResponseCopyWithImpl<$Res,
        _$SendInvitationModelResponseImpl>
    implements _$$SendInvitationModelResponseImplCopyWith<$Res> {
  __$$SendInvitationModelResponseImplCopyWithImpl(
      _$SendInvitationModelResponseImpl _value,
      $Res Function(_$SendInvitationModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SendInvitationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$SendInvitationModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendInvitationModelResponseImpl
    implements _SendInvitationModelResponse {
  const _$SendInvitationModelResponseImpl({this.message});

  factory _$SendInvitationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SendInvitationModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'SendInvitationModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendInvitationModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SendInvitationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendInvitationModelResponseImplCopyWith<_$SendInvitationModelResponseImpl>
      get copyWith => __$$SendInvitationModelResponseImplCopyWithImpl<
          _$SendInvitationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendInvitationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SendInvitationModelResponse
    implements SendInvitationModelResponse {
  const factory _SendInvitationModelResponse({final String? message}) =
      _$SendInvitationModelResponseImpl;

  factory _SendInvitationModelResponse.fromJson(Map<String, dynamic> json) =
      _$SendInvitationModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of SendInvitationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendInvitationModelResponseImplCopyWith<_$SendInvitationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
