// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_post_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreatePostInCommunityModelResponse _$CreatePostInCommunityModelResponseFromJson(
    Map<String, dynamic> json) {
  return _CreatePostInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$CreatePostInCommunityModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this CreatePostInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatePostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePostInCommunityModelResponseCopyWith<
          CreatePostInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePostInCommunityModelResponseCopyWith<$Res> {
  factory $CreatePostInCommunityModelResponseCopyWith(
          CreatePostInCommunityModelResponse value,
          $Res Function(CreatePostInCommunityModelResponse) then) =
      _$CreatePostInCommunityModelResponseCopyWithImpl<$Res,
          CreatePostInCommunityModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$CreatePostInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends CreatePostInCommunityModelResponse>
    implements $CreatePostInCommunityModelResponseCopyWith<$Res> {
  _$CreatePostInCommunityModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePostInCommunityModelResponse
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
abstract class _$$CreatePostInCommunityModelResponseImplCopyWith<$Res>
    implements $CreatePostInCommunityModelResponseCopyWith<$Res> {
  factory _$$CreatePostInCommunityModelResponseImplCopyWith(
          _$CreatePostInCommunityModelResponseImpl value,
          $Res Function(_$CreatePostInCommunityModelResponseImpl) then) =
      __$$CreatePostInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$CreatePostInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$CreatePostInCommunityModelResponseCopyWithImpl<$Res,
        _$CreatePostInCommunityModelResponseImpl>
    implements _$$CreatePostInCommunityModelResponseImplCopyWith<$Res> {
  __$$CreatePostInCommunityModelResponseImplCopyWithImpl(
      _$CreatePostInCommunityModelResponseImpl _value,
      $Res Function(_$CreatePostInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$CreatePostInCommunityModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePostInCommunityModelResponseImpl
    implements _CreatePostInCommunityModelResponse {
  const _$CreatePostInCommunityModelResponseImpl({this.message});

  factory _$CreatePostInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreatePostInCommunityModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'CreatePostInCommunityModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePostInCommunityModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CreatePostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePostInCommunityModelResponseImplCopyWith<
          _$CreatePostInCommunityModelResponseImpl>
      get copyWith => __$$CreatePostInCommunityModelResponseImplCopyWithImpl<
          _$CreatePostInCommunityModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePostInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _CreatePostInCommunityModelResponse
    implements CreatePostInCommunityModelResponse {
  const factory _CreatePostInCommunityModelResponse({final String? message}) =
      _$CreatePostInCommunityModelResponseImpl;

  factory _CreatePostInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$CreatePostInCommunityModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of CreatePostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePostInCommunityModelResponseImplCopyWith<
          _$CreatePostInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
