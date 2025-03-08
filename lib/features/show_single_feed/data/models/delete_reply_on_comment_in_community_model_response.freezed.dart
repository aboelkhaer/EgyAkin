// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_reply_on_comment_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeleteReplyOnCommentInCommunityModelResponse
    _$DeleteReplyOnCommentInCommunityModelResponseFromJson(
        Map<String, dynamic> json) {
  return _DeleteReplyOnCommentInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DeleteReplyOnCommentInCommunityModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this DeleteReplyOnCommentInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeleteReplyOnCommentInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeleteReplyOnCommentInCommunityModelResponseCopyWith<
          DeleteReplyOnCommentInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteReplyOnCommentInCommunityModelResponseCopyWith<$Res> {
  factory $DeleteReplyOnCommentInCommunityModelResponseCopyWith(
          DeleteReplyOnCommentInCommunityModelResponse value,
          $Res Function(DeleteReplyOnCommentInCommunityModelResponse) then) =
      _$DeleteReplyOnCommentInCommunityModelResponseCopyWithImpl<$Res,
          DeleteReplyOnCommentInCommunityModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$DeleteReplyOnCommentInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends DeleteReplyOnCommentInCommunityModelResponse>
    implements $DeleteReplyOnCommentInCommunityModelResponseCopyWith<$Res> {
  _$DeleteReplyOnCommentInCommunityModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeleteReplyOnCommentInCommunityModelResponse
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
abstract class _$$DeleteReplyOnCommentInCommunityModelResponseImplCopyWith<$Res>
    implements $DeleteReplyOnCommentInCommunityModelResponseCopyWith<$Res> {
  factory _$$DeleteReplyOnCommentInCommunityModelResponseImplCopyWith(
          _$DeleteReplyOnCommentInCommunityModelResponseImpl value,
          $Res Function(_$DeleteReplyOnCommentInCommunityModelResponseImpl)
              then) =
      __$$DeleteReplyOnCommentInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$DeleteReplyOnCommentInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$DeleteReplyOnCommentInCommunityModelResponseCopyWithImpl<$Res,
        _$DeleteReplyOnCommentInCommunityModelResponseImpl>
    implements
        _$$DeleteReplyOnCommentInCommunityModelResponseImplCopyWith<$Res> {
  __$$DeleteReplyOnCommentInCommunityModelResponseImplCopyWithImpl(
      _$DeleteReplyOnCommentInCommunityModelResponseImpl _value,
      $Res Function(_$DeleteReplyOnCommentInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeleteReplyOnCommentInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$DeleteReplyOnCommentInCommunityModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteReplyOnCommentInCommunityModelResponseImpl
    implements _DeleteReplyOnCommentInCommunityModelResponse {
  const _$DeleteReplyOnCommentInCommunityModelResponseImpl({this.message});

  factory _$DeleteReplyOnCommentInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DeleteReplyOnCommentInCommunityModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'DeleteReplyOnCommentInCommunityModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteReplyOnCommentInCommunityModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of DeleteReplyOnCommentInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteReplyOnCommentInCommunityModelResponseImplCopyWith<
          _$DeleteReplyOnCommentInCommunityModelResponseImpl>
      get copyWith =>
          __$$DeleteReplyOnCommentInCommunityModelResponseImplCopyWithImpl<
                  _$DeleteReplyOnCommentInCommunityModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteReplyOnCommentInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DeleteReplyOnCommentInCommunityModelResponse
    implements DeleteReplyOnCommentInCommunityModelResponse {
  const factory _DeleteReplyOnCommentInCommunityModelResponse(
          {final String? message}) =
      _$DeleteReplyOnCommentInCommunityModelResponseImpl;

  factory _DeleteReplyOnCommentInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$DeleteReplyOnCommentInCommunityModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of DeleteReplyOnCommentInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteReplyOnCommentInCommunityModelResponseImplCopyWith<
          _$DeleteReplyOnCommentInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
