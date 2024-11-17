// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_ai_consultation_request_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendAIConsultationRequestModelResponse
    _$SendAIConsultationRequestModelResponseFromJson(
        Map<String, dynamic> json) {
  return _SendAIConsultationRequestModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SendAIConsultationRequestModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this SendAIConsultationRequestModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendAIConsultationRequestModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendAIConsultationRequestModelResponseCopyWith<
          SendAIConsultationRequestModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendAIConsultationRequestModelResponseCopyWith<$Res> {
  factory $SendAIConsultationRequestModelResponseCopyWith(
          SendAIConsultationRequestModelResponse value,
          $Res Function(SendAIConsultationRequestModelResponse) then) =
      _$SendAIConsultationRequestModelResponseCopyWithImpl<$Res,
          SendAIConsultationRequestModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$SendAIConsultationRequestModelResponseCopyWithImpl<$Res,
        $Val extends SendAIConsultationRequestModelResponse>
    implements $SendAIConsultationRequestModelResponseCopyWith<$Res> {
  _$SendAIConsultationRequestModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendAIConsultationRequestModelResponse
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
abstract class _$$SendAIConsultationRequestModelResponseImplCopyWith<$Res>
    implements $SendAIConsultationRequestModelResponseCopyWith<$Res> {
  factory _$$SendAIConsultationRequestModelResponseImplCopyWith(
          _$SendAIConsultationRequestModelResponseImpl value,
          $Res Function(_$SendAIConsultationRequestModelResponseImpl) then) =
      __$$SendAIConsultationRequestModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$SendAIConsultationRequestModelResponseImplCopyWithImpl<$Res>
    extends _$SendAIConsultationRequestModelResponseCopyWithImpl<$Res,
        _$SendAIConsultationRequestModelResponseImpl>
    implements _$$SendAIConsultationRequestModelResponseImplCopyWith<$Res> {
  __$$SendAIConsultationRequestModelResponseImplCopyWithImpl(
      _$SendAIConsultationRequestModelResponseImpl _value,
      $Res Function(_$SendAIConsultationRequestModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SendAIConsultationRequestModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$SendAIConsultationRequestModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendAIConsultationRequestModelResponseImpl
    implements _SendAIConsultationRequestModelResponse {
  const _$SendAIConsultationRequestModelResponseImpl({this.message});

  factory _$SendAIConsultationRequestModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SendAIConsultationRequestModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'SendAIConsultationRequestModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendAIConsultationRequestModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SendAIConsultationRequestModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendAIConsultationRequestModelResponseImplCopyWith<
          _$SendAIConsultationRequestModelResponseImpl>
      get copyWith =>
          __$$SendAIConsultationRequestModelResponseImplCopyWithImpl<
              _$SendAIConsultationRequestModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendAIConsultationRequestModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SendAIConsultationRequestModelResponse
    implements SendAIConsultationRequestModelResponse {
  const factory _SendAIConsultationRequestModelResponse(
      {final String? message}) = _$SendAIConsultationRequestModelResponseImpl;

  factory _SendAIConsultationRequestModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$SendAIConsultationRequestModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of SendAIConsultationRequestModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendAIConsultationRequestModelResponseImplCopyWith<
          _$SendAIConsultationRequestModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
