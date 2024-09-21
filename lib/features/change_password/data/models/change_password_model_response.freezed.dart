// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_password_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChangePasswordModelResponse _$ChangePasswordModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ChangePasswordModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ChangePasswordModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ChangePasswordModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangePasswordModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangePasswordModelResponseCopyWith<ChangePasswordModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePasswordModelResponseCopyWith<$Res> {
  factory $ChangePasswordModelResponseCopyWith(
          ChangePasswordModelResponse value,
          $Res Function(ChangePasswordModelResponse) then) =
      _$ChangePasswordModelResponseCopyWithImpl<$Res,
          ChangePasswordModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$ChangePasswordModelResponseCopyWithImpl<$Res,
        $Val extends ChangePasswordModelResponse>
    implements $ChangePasswordModelResponseCopyWith<$Res> {
  _$ChangePasswordModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangePasswordModelResponse
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
abstract class _$$ChangePasswordModelResponseImplCopyWith<$Res>
    implements $ChangePasswordModelResponseCopyWith<$Res> {
  factory _$$ChangePasswordModelResponseImplCopyWith(
          _$ChangePasswordModelResponseImpl value,
          $Res Function(_$ChangePasswordModelResponseImpl) then) =
      __$$ChangePasswordModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ChangePasswordModelResponseImplCopyWithImpl<$Res>
    extends _$ChangePasswordModelResponseCopyWithImpl<$Res,
        _$ChangePasswordModelResponseImpl>
    implements _$$ChangePasswordModelResponseImplCopyWith<$Res> {
  __$$ChangePasswordModelResponseImplCopyWithImpl(
      _$ChangePasswordModelResponseImpl _value,
      $Res Function(_$ChangePasswordModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePasswordModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ChangePasswordModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangePasswordModelResponseImpl
    implements _ChangePasswordModelResponse {
  const _$ChangePasswordModelResponseImpl({this.message});

  factory _$ChangePasswordModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChangePasswordModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'ChangePasswordModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ChangePasswordModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordModelResponseImplCopyWith<_$ChangePasswordModelResponseImpl>
      get copyWith => __$$ChangePasswordModelResponseImplCopyWithImpl<
          _$ChangePasswordModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangePasswordModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ChangePasswordModelResponse
    implements ChangePasswordModelResponse {
  const factory _ChangePasswordModelResponse({final String? message}) =
      _$ChangePasswordModelResponseImpl;

  factory _ChangePasswordModelResponse.fromJson(Map<String, dynamic> json) =
      _$ChangePasswordModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of ChangePasswordModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePasswordModelResponseImplCopyWith<_$ChangePasswordModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
