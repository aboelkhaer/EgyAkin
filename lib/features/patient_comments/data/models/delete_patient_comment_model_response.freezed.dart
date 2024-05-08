// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_patient_comment_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeletePatientCommentsModelResponse _$DeletePatientCommentsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _DeletePatientCommentsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DeletePatientCommentsModelResponse {
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeletePatientCommentsModelResponseCopyWith<
          DeletePatientCommentsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletePatientCommentsModelResponseCopyWith<$Res> {
  factory $DeletePatientCommentsModelResponseCopyWith(
          DeletePatientCommentsModelResponse value,
          $Res Function(DeletePatientCommentsModelResponse) then) =
      _$DeletePatientCommentsModelResponseCopyWithImpl<$Res,
          DeletePatientCommentsModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$DeletePatientCommentsModelResponseCopyWithImpl<$Res,
        $Val extends DeletePatientCommentsModelResponse>
    implements $DeletePatientCommentsModelResponseCopyWith<$Res> {
  _$DeletePatientCommentsModelResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$DeletePatientCommentsModelResponseImplCopyWith<$Res>
    implements $DeletePatientCommentsModelResponseCopyWith<$Res> {
  factory _$$DeletePatientCommentsModelResponseImplCopyWith(
          _$DeletePatientCommentsModelResponseImpl value,
          $Res Function(_$DeletePatientCommentsModelResponseImpl) then) =
      __$$DeletePatientCommentsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$DeletePatientCommentsModelResponseImplCopyWithImpl<$Res>
    extends _$DeletePatientCommentsModelResponseCopyWithImpl<$Res,
        _$DeletePatientCommentsModelResponseImpl>
    implements _$$DeletePatientCommentsModelResponseImplCopyWith<$Res> {
  __$$DeletePatientCommentsModelResponseImplCopyWithImpl(
      _$DeletePatientCommentsModelResponseImpl _value,
      $Res Function(_$DeletePatientCommentsModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$DeletePatientCommentsModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeletePatientCommentsModelResponseImpl
    implements _DeletePatientCommentsModelResponse {
  const _$DeletePatientCommentsModelResponseImpl({this.message});

  factory _$DeletePatientCommentsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DeletePatientCommentsModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'DeletePatientCommentsModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePatientCommentsModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePatientCommentsModelResponseImplCopyWith<
          _$DeletePatientCommentsModelResponseImpl>
      get copyWith => __$$DeletePatientCommentsModelResponseImplCopyWithImpl<
          _$DeletePatientCommentsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletePatientCommentsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DeletePatientCommentsModelResponse
    implements DeletePatientCommentsModelResponse {
  const factory _DeletePatientCommentsModelResponse({final String? message}) =
      _$DeletePatientCommentsModelResponseImpl;

  factory _DeletePatientCommentsModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$DeletePatientCommentsModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$DeletePatientCommentsModelResponseImplCopyWith<
          _$DeletePatientCommentsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
