// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remove_member_from_group_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RemoveMemberFromGroupModelResponse _$RemoveMemberFromGroupModelResponseFromJson(
    Map<String, dynamic> json) {
  return _RemoveMemberFromGroupModelResponse.fromJson(json);
}

/// @nodoc
mixin _$RemoveMemberFromGroupModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this RemoveMemberFromGroupModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RemoveMemberFromGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RemoveMemberFromGroupModelResponseCopyWith<
          RemoveMemberFromGroupModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoveMemberFromGroupModelResponseCopyWith<$Res> {
  factory $RemoveMemberFromGroupModelResponseCopyWith(
          RemoveMemberFromGroupModelResponse value,
          $Res Function(RemoveMemberFromGroupModelResponse) then) =
      _$RemoveMemberFromGroupModelResponseCopyWithImpl<$Res,
          RemoveMemberFromGroupModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$RemoveMemberFromGroupModelResponseCopyWithImpl<$Res,
        $Val extends RemoveMemberFromGroupModelResponse>
    implements $RemoveMemberFromGroupModelResponseCopyWith<$Res> {
  _$RemoveMemberFromGroupModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RemoveMemberFromGroupModelResponse
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
abstract class _$$RemoveMemberFromGroupModelResponseImplCopyWith<$Res>
    implements $RemoveMemberFromGroupModelResponseCopyWith<$Res> {
  factory _$$RemoveMemberFromGroupModelResponseImplCopyWith(
          _$RemoveMemberFromGroupModelResponseImpl value,
          $Res Function(_$RemoveMemberFromGroupModelResponseImpl) then) =
      __$$RemoveMemberFromGroupModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$RemoveMemberFromGroupModelResponseImplCopyWithImpl<$Res>
    extends _$RemoveMemberFromGroupModelResponseCopyWithImpl<$Res,
        _$RemoveMemberFromGroupModelResponseImpl>
    implements _$$RemoveMemberFromGroupModelResponseImplCopyWith<$Res> {
  __$$RemoveMemberFromGroupModelResponseImplCopyWithImpl(
      _$RemoveMemberFromGroupModelResponseImpl _value,
      $Res Function(_$RemoveMemberFromGroupModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of RemoveMemberFromGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$RemoveMemberFromGroupModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoveMemberFromGroupModelResponseImpl
    implements _RemoveMemberFromGroupModelResponse {
  const _$RemoveMemberFromGroupModelResponseImpl({this.message});

  factory _$RemoveMemberFromGroupModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$RemoveMemberFromGroupModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'RemoveMemberFromGroupModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveMemberFromGroupModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of RemoveMemberFromGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveMemberFromGroupModelResponseImplCopyWith<
          _$RemoveMemberFromGroupModelResponseImpl>
      get copyWith => __$$RemoveMemberFromGroupModelResponseImplCopyWithImpl<
          _$RemoveMemberFromGroupModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoveMemberFromGroupModelResponseImplToJson(
      this,
    );
  }
}

abstract class _RemoveMemberFromGroupModelResponse
    implements RemoveMemberFromGroupModelResponse {
  const factory _RemoveMemberFromGroupModelResponse({final String? message}) =
      _$RemoveMemberFromGroupModelResponseImpl;

  factory _RemoveMemberFromGroupModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$RemoveMemberFromGroupModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of RemoveMemberFromGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveMemberFromGroupModelResponseImplCopyWith<
          _$RemoveMemberFromGroupModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
