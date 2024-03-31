// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_notification_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateNotificationModelResponse _$UpdateNotificationModelResponseFromJson(
    Map<String, dynamic> json) {
  return _UpdateNotificationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$UpdateNotificationModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateNotificationModelResponseCopyWith<UpdateNotificationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateNotificationModelResponseCopyWith<$Res> {
  factory $UpdateNotificationModelResponseCopyWith(
          UpdateNotificationModelResponse value,
          $Res Function(UpdateNotificationModelResponse) then) =
      _$UpdateNotificationModelResponseCopyWithImpl<$Res,
          UpdateNotificationModelResponse>;
  @useResult
  $Res call({bool? value, String? message});
}

/// @nodoc
class _$UpdateNotificationModelResponseCopyWithImpl<$Res,
        $Val extends UpdateNotificationModelResponse>
    implements $UpdateNotificationModelResponseCopyWith<$Res> {
  _$UpdateNotificationModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$UpdateNotificationModelResponseImplCopyWith<$Res>
    implements $UpdateNotificationModelResponseCopyWith<$Res> {
  factory _$$UpdateNotificationModelResponseImplCopyWith(
          _$UpdateNotificationModelResponseImpl value,
          $Res Function(_$UpdateNotificationModelResponseImpl) then) =
      __$$UpdateNotificationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message});
}

/// @nodoc
class __$$UpdateNotificationModelResponseImplCopyWithImpl<$Res>
    extends _$UpdateNotificationModelResponseCopyWithImpl<$Res,
        _$UpdateNotificationModelResponseImpl>
    implements _$$UpdateNotificationModelResponseImplCopyWith<$Res> {
  __$$UpdateNotificationModelResponseImplCopyWithImpl(
      _$UpdateNotificationModelResponseImpl _value,
      $Res Function(_$UpdateNotificationModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
  }) {
    return _then(_$UpdateNotificationModelResponseImpl(
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
class _$UpdateNotificationModelResponseImpl
    implements _UpdateNotificationModelResponse {
  const _$UpdateNotificationModelResponseImpl({this.value, this.message});

  factory _$UpdateNotificationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UpdateNotificationModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;

  @override
  String toString() {
    return 'UpdateNotificationModelResponse(value: $value, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateNotificationModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateNotificationModelResponseImplCopyWith<
          _$UpdateNotificationModelResponseImpl>
      get copyWith => __$$UpdateNotificationModelResponseImplCopyWithImpl<
          _$UpdateNotificationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateNotificationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _UpdateNotificationModelResponse
    implements UpdateNotificationModelResponse {
  const factory _UpdateNotificationModelResponse(
      {final bool? value,
      final String? message}) = _$UpdateNotificationModelResponseImpl;

  factory _UpdateNotificationModelResponse.fromJson(Map<String, dynamic> json) =
      _$UpdateNotificationModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$UpdateNotificationModelResponseImplCopyWith<
          _$UpdateNotificationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
