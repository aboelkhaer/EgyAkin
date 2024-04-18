// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_post_comment_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeletePostCommentModelResponse _$DeletePostCommentModelResponseFromJson(
    Map<String, dynamic> json) {
  return _DeletePostCommentModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DeletePostCommentModelResponse {
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeletePostCommentModelResponseCopyWith<DeletePostCommentModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletePostCommentModelResponseCopyWith<$Res> {
  factory $DeletePostCommentModelResponseCopyWith(
          DeletePostCommentModelResponse value,
          $Res Function(DeletePostCommentModelResponse) then) =
      _$DeletePostCommentModelResponseCopyWithImpl<$Res,
          DeletePostCommentModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$DeletePostCommentModelResponseCopyWithImpl<$Res,
        $Val extends DeletePostCommentModelResponse>
    implements $DeletePostCommentModelResponseCopyWith<$Res> {
  _$DeletePostCommentModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$DeletePostCommentModelResponseImplCopyWith<$Res>
    implements $DeletePostCommentModelResponseCopyWith<$Res> {
  factory _$$DeletePostCommentModelResponseImplCopyWith(
          _$DeletePostCommentModelResponseImpl value,
          $Res Function(_$DeletePostCommentModelResponseImpl) then) =
      __$$DeletePostCommentModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$DeletePostCommentModelResponseImplCopyWithImpl<$Res>
    extends _$DeletePostCommentModelResponseCopyWithImpl<$Res,
        _$DeletePostCommentModelResponseImpl>
    implements _$$DeletePostCommentModelResponseImplCopyWith<$Res> {
  __$$DeletePostCommentModelResponseImplCopyWithImpl(
      _$DeletePostCommentModelResponseImpl _value,
      $Res Function(_$DeletePostCommentModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$DeletePostCommentModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeletePostCommentModelResponseImpl
    implements _DeletePostCommentModelResponse {
  const _$DeletePostCommentModelResponseImpl({this.message});

  factory _$DeletePostCommentModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DeletePostCommentModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'DeletePostCommentModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePostCommentModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePostCommentModelResponseImplCopyWith<
          _$DeletePostCommentModelResponseImpl>
      get copyWith => __$$DeletePostCommentModelResponseImplCopyWithImpl<
          _$DeletePostCommentModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletePostCommentModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DeletePostCommentModelResponse
    implements DeletePostCommentModelResponse {
  const factory _DeletePostCommentModelResponse({final String? message}) =
      _$DeletePostCommentModelResponseImpl;

  factory _DeletePostCommentModelResponse.fromJson(Map<String, dynamic> json) =
      _$DeletePostCommentModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$DeletePostCommentModelResponseImplCopyWith<
          _$DeletePostCommentModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
