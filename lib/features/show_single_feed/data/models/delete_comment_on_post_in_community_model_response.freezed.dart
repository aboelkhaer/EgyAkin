// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_comment_on_post_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeleteCommentOnPostInCommunityModelResponse
    _$DeleteCommentOnPostInCommunityModelResponseFromJson(
        Map<String, dynamic> json) {
  return _DeleteCommentOnPostInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DeleteCommentOnPostInCommunityModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this DeleteCommentOnPostInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeleteCommentOnPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeleteCommentOnPostInCommunityModelResponseCopyWith<
          DeleteCommentOnPostInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteCommentOnPostInCommunityModelResponseCopyWith<$Res> {
  factory $DeleteCommentOnPostInCommunityModelResponseCopyWith(
          DeleteCommentOnPostInCommunityModelResponse value,
          $Res Function(DeleteCommentOnPostInCommunityModelResponse) then) =
      _$DeleteCommentOnPostInCommunityModelResponseCopyWithImpl<$Res,
          DeleteCommentOnPostInCommunityModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$DeleteCommentOnPostInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends DeleteCommentOnPostInCommunityModelResponse>
    implements $DeleteCommentOnPostInCommunityModelResponseCopyWith<$Res> {
  _$DeleteCommentOnPostInCommunityModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeleteCommentOnPostInCommunityModelResponse
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
abstract class _$$DeleteCommentOnPostInCommunityModelResponseImplCopyWith<$Res>
    implements $DeleteCommentOnPostInCommunityModelResponseCopyWith<$Res> {
  factory _$$DeleteCommentOnPostInCommunityModelResponseImplCopyWith(
          _$DeleteCommentOnPostInCommunityModelResponseImpl value,
          $Res Function(_$DeleteCommentOnPostInCommunityModelResponseImpl)
              then) =
      __$$DeleteCommentOnPostInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$DeleteCommentOnPostInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$DeleteCommentOnPostInCommunityModelResponseCopyWithImpl<$Res,
        _$DeleteCommentOnPostInCommunityModelResponseImpl>
    implements
        _$$DeleteCommentOnPostInCommunityModelResponseImplCopyWith<$Res> {
  __$$DeleteCommentOnPostInCommunityModelResponseImplCopyWithImpl(
      _$DeleteCommentOnPostInCommunityModelResponseImpl _value,
      $Res Function(_$DeleteCommentOnPostInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeleteCommentOnPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$DeleteCommentOnPostInCommunityModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteCommentOnPostInCommunityModelResponseImpl
    implements _DeleteCommentOnPostInCommunityModelResponse {
  const _$DeleteCommentOnPostInCommunityModelResponseImpl({this.message});

  factory _$DeleteCommentOnPostInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DeleteCommentOnPostInCommunityModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'DeleteCommentOnPostInCommunityModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCommentOnPostInCommunityModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of DeleteCommentOnPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCommentOnPostInCommunityModelResponseImplCopyWith<
          _$DeleteCommentOnPostInCommunityModelResponseImpl>
      get copyWith =>
          __$$DeleteCommentOnPostInCommunityModelResponseImplCopyWithImpl<
                  _$DeleteCommentOnPostInCommunityModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteCommentOnPostInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DeleteCommentOnPostInCommunityModelResponse
    implements DeleteCommentOnPostInCommunityModelResponse {
  const factory _DeleteCommentOnPostInCommunityModelResponse(
          {final String? message}) =
      _$DeleteCommentOnPostInCommunityModelResponseImpl;

  factory _DeleteCommentOnPostInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$DeleteCommentOnPostInCommunityModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of DeleteCommentOnPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteCommentOnPostInCommunityModelResponseImplCopyWith<
          _$DeleteCommentOnPostInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
