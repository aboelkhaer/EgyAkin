// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResetPasswordModelResponse _$ResetPasswordModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ResetPasswordModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordModelResponse {
  bool? get success => throw _privateConstructorUsedError;

  /// Serializes this ResetPasswordModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResetPasswordModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResetPasswordModelResponseCopyWith<ResetPasswordModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordModelResponseCopyWith<$Res> {
  factory $ResetPasswordModelResponseCopyWith(ResetPasswordModelResponse value,
          $Res Function(ResetPasswordModelResponse) then) =
      _$ResetPasswordModelResponseCopyWithImpl<$Res,
          ResetPasswordModelResponse>;
  @useResult
  $Res call({bool? success});
}

/// @nodoc
class _$ResetPasswordModelResponseCopyWithImpl<$Res,
        $Val extends ResetPasswordModelResponse>
    implements $ResetPasswordModelResponseCopyWith<$Res> {
  _$ResetPasswordModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResetPasswordModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
  }) {
    return _then(_value.copyWith(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResetPasswordModelResponseImplCopyWith<$Res>
    implements $ResetPasswordModelResponseCopyWith<$Res> {
  factory _$$ResetPasswordModelResponseImplCopyWith(
          _$ResetPasswordModelResponseImpl value,
          $Res Function(_$ResetPasswordModelResponseImpl) then) =
      __$$ResetPasswordModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? success});
}

/// @nodoc
class __$$ResetPasswordModelResponseImplCopyWithImpl<$Res>
    extends _$ResetPasswordModelResponseCopyWithImpl<$Res,
        _$ResetPasswordModelResponseImpl>
    implements _$$ResetPasswordModelResponseImplCopyWith<$Res> {
  __$$ResetPasswordModelResponseImplCopyWithImpl(
      _$ResetPasswordModelResponseImpl _value,
      $Res Function(_$ResetPasswordModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResetPasswordModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
  }) {
    return _then(_$ResetPasswordModelResponseImpl(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResetPasswordModelResponseImpl implements _ResetPasswordModelResponse {
  const _$ResetPasswordModelResponseImpl({this.success});

  factory _$ResetPasswordModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ResetPasswordModelResponseImplFromJson(json);

  @override
  final bool? success;

  @override
  String toString() {
    return 'ResetPasswordModelResponse(success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordModelResponseImpl &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success);

  /// Create a copy of ResetPasswordModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordModelResponseImplCopyWith<_$ResetPasswordModelResponseImpl>
      get copyWith => __$$ResetPasswordModelResponseImplCopyWithImpl<
          _$ResetPasswordModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ResetPasswordModelResponse
    implements ResetPasswordModelResponse {
  const factory _ResetPasswordModelResponse({final bool? success}) =
      _$ResetPasswordModelResponseImpl;

  factory _ResetPasswordModelResponse.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordModelResponseImpl.fromJson;

  @override
  bool? get success;

  /// Create a copy of ResetPasswordModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPasswordModelResponseImplCopyWith<_$ResetPasswordModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
