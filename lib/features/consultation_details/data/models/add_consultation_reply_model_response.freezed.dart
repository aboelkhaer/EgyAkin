// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_consultation_reply_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddConsultationReplyModelResponse _$AddConsultationReplyModelResponseFromJson(
    Map<String, dynamic> json) {
  return _AddConsultationReplyModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AddConsultationReplyModelResponse {
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddConsultationReplyModelResponseCopyWith<AddConsultationReplyModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddConsultationReplyModelResponseCopyWith<$Res> {
  factory $AddConsultationReplyModelResponseCopyWith(
          AddConsultationReplyModelResponse value,
          $Res Function(AddConsultationReplyModelResponse) then) =
      _$AddConsultationReplyModelResponseCopyWithImpl<$Res,
          AddConsultationReplyModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$AddConsultationReplyModelResponseCopyWithImpl<$Res,
        $Val extends AddConsultationReplyModelResponse>
    implements $AddConsultationReplyModelResponseCopyWith<$Res> {
  _$AddConsultationReplyModelResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$AddConsultationReplyModelResponseImplCopyWith<$Res>
    implements $AddConsultationReplyModelResponseCopyWith<$Res> {
  factory _$$AddConsultationReplyModelResponseImplCopyWith(
          _$AddConsultationReplyModelResponseImpl value,
          $Res Function(_$AddConsultationReplyModelResponseImpl) then) =
      __$$AddConsultationReplyModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$AddConsultationReplyModelResponseImplCopyWithImpl<$Res>
    extends _$AddConsultationReplyModelResponseCopyWithImpl<$Res,
        _$AddConsultationReplyModelResponseImpl>
    implements _$$AddConsultationReplyModelResponseImplCopyWith<$Res> {
  __$$AddConsultationReplyModelResponseImplCopyWithImpl(
      _$AddConsultationReplyModelResponseImpl _value,
      $Res Function(_$AddConsultationReplyModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$AddConsultationReplyModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddConsultationReplyModelResponseImpl
    implements _AddConsultationReplyModelResponse {
  const _$AddConsultationReplyModelResponseImpl({this.message});

  factory _$AddConsultationReplyModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddConsultationReplyModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'AddConsultationReplyModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddConsultationReplyModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddConsultationReplyModelResponseImplCopyWith<
          _$AddConsultationReplyModelResponseImpl>
      get copyWith => __$$AddConsultationReplyModelResponseImplCopyWithImpl<
          _$AddConsultationReplyModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddConsultationReplyModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AddConsultationReplyModelResponse
    implements AddConsultationReplyModelResponse {
  const factory _AddConsultationReplyModelResponse({final String? message}) =
      _$AddConsultationReplyModelResponseImpl;

  factory _AddConsultationReplyModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$AddConsultationReplyModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$AddConsultationReplyModelResponseImplCopyWith<
          _$AddConsultationReplyModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
