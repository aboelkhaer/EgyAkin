// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_group_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateGroupInCommunityModelResponse
    _$CreateGroupInCommunityModelResponseFromJson(Map<String, dynamic> json) {
  return _CreateGroupInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateGroupInCommunityModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this CreateGroupInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateGroupInCommunityModelResponseCopyWith<
          CreateGroupInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateGroupInCommunityModelResponseCopyWith<$Res> {
  factory $CreateGroupInCommunityModelResponseCopyWith(
          CreateGroupInCommunityModelResponse value,
          $Res Function(CreateGroupInCommunityModelResponse) then) =
      _$CreateGroupInCommunityModelResponseCopyWithImpl<$Res,
          CreateGroupInCommunityModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$CreateGroupInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends CreateGroupInCommunityModelResponse>
    implements $CreateGroupInCommunityModelResponseCopyWith<$Res> {
  _$CreateGroupInCommunityModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateGroupInCommunityModelResponse
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
abstract class _$$CreateGroupInCommunityModelResponseImplCopyWith<$Res>
    implements $CreateGroupInCommunityModelResponseCopyWith<$Res> {
  factory _$$CreateGroupInCommunityModelResponseImplCopyWith(
          _$CreateGroupInCommunityModelResponseImpl value,
          $Res Function(_$CreateGroupInCommunityModelResponseImpl) then) =
      __$$CreateGroupInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$CreateGroupInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$CreateGroupInCommunityModelResponseCopyWithImpl<$Res,
        _$CreateGroupInCommunityModelResponseImpl>
    implements _$$CreateGroupInCommunityModelResponseImplCopyWith<$Res> {
  __$$CreateGroupInCommunityModelResponseImplCopyWithImpl(
      _$CreateGroupInCommunityModelResponseImpl _value,
      $Res Function(_$CreateGroupInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$CreateGroupInCommunityModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateGroupInCommunityModelResponseImpl
    implements _CreateGroupInCommunityModelResponse {
  const _$CreateGroupInCommunityModelResponseImpl({this.message});

  factory _$CreateGroupInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreateGroupInCommunityModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'CreateGroupInCommunityModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateGroupInCommunityModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CreateGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateGroupInCommunityModelResponseImplCopyWith<
          _$CreateGroupInCommunityModelResponseImpl>
      get copyWith => __$$CreateGroupInCommunityModelResponseImplCopyWithImpl<
          _$CreateGroupInCommunityModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateGroupInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _CreateGroupInCommunityModelResponse
    implements CreateGroupInCommunityModelResponse {
  const factory _CreateGroupInCommunityModelResponse({final String? message}) =
      _$CreateGroupInCommunityModelResponseImpl;

  factory _CreateGroupInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$CreateGroupInCommunityModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of CreateGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateGroupInCommunityModelResponseImplCopyWith<
          _$CreateGroupInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
