// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_consultation_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendConsultationModelResponse _$SendConsultationModelResponseFromJson(
    Map<String, dynamic> json) {
  return _SendConsultationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SendConsultationModelResponse {
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendConsultationModelResponseCopyWith<SendConsultationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendConsultationModelResponseCopyWith<$Res> {
  factory $SendConsultationModelResponseCopyWith(
          SendConsultationModelResponse value,
          $Res Function(SendConsultationModelResponse) then) =
      _$SendConsultationModelResponseCopyWithImpl<$Res,
          SendConsultationModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$SendConsultationModelResponseCopyWithImpl<$Res,
        $Val extends SendConsultationModelResponse>
    implements $SendConsultationModelResponseCopyWith<$Res> {
  _$SendConsultationModelResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$SendConsultationModelResponseImplCopyWith<$Res>
    implements $SendConsultationModelResponseCopyWith<$Res> {
  factory _$$SendConsultationModelResponseImplCopyWith(
          _$SendConsultationModelResponseImpl value,
          $Res Function(_$SendConsultationModelResponseImpl) then) =
      __$$SendConsultationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$SendConsultationModelResponseImplCopyWithImpl<$Res>
    extends _$SendConsultationModelResponseCopyWithImpl<$Res,
        _$SendConsultationModelResponseImpl>
    implements _$$SendConsultationModelResponseImplCopyWith<$Res> {
  __$$SendConsultationModelResponseImplCopyWithImpl(
      _$SendConsultationModelResponseImpl _value,
      $Res Function(_$SendConsultationModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$SendConsultationModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendConsultationModelResponseImpl
    implements _SendConsultationModelResponse {
  const _$SendConsultationModelResponseImpl({this.message});

  factory _$SendConsultationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SendConsultationModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'SendConsultationModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendConsultationModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendConsultationModelResponseImplCopyWith<
          _$SendConsultationModelResponseImpl>
      get copyWith => __$$SendConsultationModelResponseImplCopyWithImpl<
          _$SendConsultationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendConsultationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SendConsultationModelResponse
    implements SendConsultationModelResponse {
  const factory _SendConsultationModelResponse({final String? message}) =
      _$SendConsultationModelResponseImpl;

  factory _SendConsultationModelResponse.fromJson(Map<String, dynamic> json) =
      _$SendConsultationModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$SendConsultationModelResponseImplCopyWith<
          _$SendConsultationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
