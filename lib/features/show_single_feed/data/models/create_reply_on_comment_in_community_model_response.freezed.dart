// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_reply_on_comment_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateReplyOnCommentInCommunityModelResponse
    _$CreateReplyOnCommentInCommunityModelResponseFromJson(
        Map<String, dynamic> json) {
  return _CreateReplyOnCommentInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateReplyOnCommentInCommunityModelResponse {
  String? get message => throw _privateConstructorUsedError;
  CreateCommentOnPostInCommunityDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this CreateReplyOnCommentInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateReplyOnCommentInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateReplyOnCommentInCommunityModelResponseCopyWith<
          CreateReplyOnCommentInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateReplyOnCommentInCommunityModelResponseCopyWith<$Res> {
  factory $CreateReplyOnCommentInCommunityModelResponseCopyWith(
          CreateReplyOnCommentInCommunityModelResponse value,
          $Res Function(CreateReplyOnCommentInCommunityModelResponse) then) =
      _$CreateReplyOnCommentInCommunityModelResponseCopyWithImpl<$Res,
          CreateReplyOnCommentInCommunityModelResponse>;
  @useResult
  $Res call(
      {String? message, CreateCommentOnPostInCommunityDataModelResponse? data});

  $CreateCommentOnPostInCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$CreateReplyOnCommentInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends CreateReplyOnCommentInCommunityModelResponse>
    implements $CreateReplyOnCommentInCommunityModelResponseCopyWith<$Res> {
  _$CreateReplyOnCommentInCommunityModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateReplyOnCommentInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CreateCommentOnPostInCommunityDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of CreateReplyOnCommentInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreateCommentOnPostInCommunityDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $CreateCommentOnPostInCommunityDataModelResponseCopyWith<$Res>(
        _value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateReplyOnCommentInCommunityModelResponseImplCopyWith<$Res>
    implements $CreateReplyOnCommentInCommunityModelResponseCopyWith<$Res> {
  factory _$$CreateReplyOnCommentInCommunityModelResponseImplCopyWith(
          _$CreateReplyOnCommentInCommunityModelResponseImpl value,
          $Res Function(_$CreateReplyOnCommentInCommunityModelResponseImpl)
              then) =
      __$$CreateReplyOnCommentInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message, CreateCommentOnPostInCommunityDataModelResponse? data});

  @override
  $CreateCommentOnPostInCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$CreateReplyOnCommentInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$CreateReplyOnCommentInCommunityModelResponseCopyWithImpl<$Res,
        _$CreateReplyOnCommentInCommunityModelResponseImpl>
    implements
        _$$CreateReplyOnCommentInCommunityModelResponseImplCopyWith<$Res> {
  __$$CreateReplyOnCommentInCommunityModelResponseImplCopyWithImpl(
      _$CreateReplyOnCommentInCommunityModelResponseImpl _value,
      $Res Function(_$CreateReplyOnCommentInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateReplyOnCommentInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$CreateReplyOnCommentInCommunityModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CreateCommentOnPostInCommunityDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateReplyOnCommentInCommunityModelResponseImpl
    implements _CreateReplyOnCommentInCommunityModelResponse {
  const _$CreateReplyOnCommentInCommunityModelResponseImpl(
      {this.message, this.data});

  factory _$CreateReplyOnCommentInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreateReplyOnCommentInCommunityModelResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final CreateCommentOnPostInCommunityDataModelResponse? data;

  @override
  String toString() {
    return 'CreateReplyOnCommentInCommunityModelResponse(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateReplyOnCommentInCommunityModelResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, data);

  /// Create a copy of CreateReplyOnCommentInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateReplyOnCommentInCommunityModelResponseImplCopyWith<
          _$CreateReplyOnCommentInCommunityModelResponseImpl>
      get copyWith =>
          __$$CreateReplyOnCommentInCommunityModelResponseImplCopyWithImpl<
                  _$CreateReplyOnCommentInCommunityModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateReplyOnCommentInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _CreateReplyOnCommentInCommunityModelResponse
    implements CreateReplyOnCommentInCommunityModelResponse {
  const factory _CreateReplyOnCommentInCommunityModelResponse(
          {final String? message,
          final CreateCommentOnPostInCommunityDataModelResponse? data}) =
      _$CreateReplyOnCommentInCommunityModelResponseImpl;

  factory _CreateReplyOnCommentInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$CreateReplyOnCommentInCommunityModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  CreateCommentOnPostInCommunityDataModelResponse? get data;

  /// Create a copy of CreateReplyOnCommentInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateReplyOnCommentInCommunityModelResponseImplCopyWith<
          _$CreateReplyOnCommentInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
