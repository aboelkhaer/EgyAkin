// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_group_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateGroupInCommunityModelResponse
    _$UpdateGroupInCommunityModelResponseFromJson(Map<String, dynamic> json) {
  return _UpdateGroupInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$UpdateGroupInCommunityModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this UpdateGroupInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateGroupInCommunityModelResponseCopyWith<
          UpdateGroupInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateGroupInCommunityModelResponseCopyWith<$Res> {
  factory $UpdateGroupInCommunityModelResponseCopyWith(
          UpdateGroupInCommunityModelResponse value,
          $Res Function(UpdateGroupInCommunityModelResponse) then) =
      _$UpdateGroupInCommunityModelResponseCopyWithImpl<$Res,
          UpdateGroupInCommunityModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$UpdateGroupInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends UpdateGroupInCommunityModelResponse>
    implements $UpdateGroupInCommunityModelResponseCopyWith<$Res> {
  _$UpdateGroupInCommunityModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateGroupInCommunityModelResponse
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
abstract class _$$UpdateGroupInCommunityModelResponseImplCopyWith<$Res>
    implements $UpdateGroupInCommunityModelResponseCopyWith<$Res> {
  factory _$$UpdateGroupInCommunityModelResponseImplCopyWith(
          _$UpdateGroupInCommunityModelResponseImpl value,
          $Res Function(_$UpdateGroupInCommunityModelResponseImpl) then) =
      __$$UpdateGroupInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UpdateGroupInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$UpdateGroupInCommunityModelResponseCopyWithImpl<$Res,
        _$UpdateGroupInCommunityModelResponseImpl>
    implements _$$UpdateGroupInCommunityModelResponseImplCopyWith<$Res> {
  __$$UpdateGroupInCommunityModelResponseImplCopyWithImpl(
      _$UpdateGroupInCommunityModelResponseImpl _value,
      $Res Function(_$UpdateGroupInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UpdateGroupInCommunityModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateGroupInCommunityModelResponseImpl
    implements _UpdateGroupInCommunityModelResponse {
  const _$UpdateGroupInCommunityModelResponseImpl({this.message});

  factory _$UpdateGroupInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UpdateGroupInCommunityModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'UpdateGroupInCommunityModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateGroupInCommunityModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of UpdateGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateGroupInCommunityModelResponseImplCopyWith<
          _$UpdateGroupInCommunityModelResponseImpl>
      get copyWith => __$$UpdateGroupInCommunityModelResponseImplCopyWithImpl<
          _$UpdateGroupInCommunityModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateGroupInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _UpdateGroupInCommunityModelResponse
    implements UpdateGroupInCommunityModelResponse {
  const factory _UpdateGroupInCommunityModelResponse({final String? message}) =
      _$UpdateGroupInCommunityModelResponseImpl;

  factory _UpdateGroupInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$UpdateGroupInCommunityModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of UpdateGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateGroupInCommunityModelResponseImplCopyWith<
          _$UpdateGroupInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
