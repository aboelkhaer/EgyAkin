// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_comment_on_post_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddCommentOnPostModelResponse _$AddCommentOnPostModelResponseFromJson(
    Map<String, dynamic> json) {
  return _AddCommentOnPostModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AddCommentOnPostModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddCommentOnPostModelResponseCopyWith<AddCommentOnPostModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddCommentOnPostModelResponseCopyWith<$Res> {
  factory $AddCommentOnPostModelResponseCopyWith(
          AddCommentOnPostModelResponse value,
          $Res Function(AddCommentOnPostModelResponse) then) =
      _$AddCommentOnPostModelResponseCopyWithImpl<$Res,
          AddCommentOnPostModelResponse>;
  @useResult
  $Res call({bool? value, String? message});
}

/// @nodoc
class _$AddCommentOnPostModelResponseCopyWithImpl<$Res,
        $Val extends AddCommentOnPostModelResponse>
    implements $AddCommentOnPostModelResponseCopyWith<$Res> {
  _$AddCommentOnPostModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddCommentOnPostModelResponseImplCopyWith<$Res>
    implements $AddCommentOnPostModelResponseCopyWith<$Res> {
  factory _$$AddCommentOnPostModelResponseImplCopyWith(
          _$AddCommentOnPostModelResponseImpl value,
          $Res Function(_$AddCommentOnPostModelResponseImpl) then) =
      __$$AddCommentOnPostModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message});
}

/// @nodoc
class __$$AddCommentOnPostModelResponseImplCopyWithImpl<$Res>
    extends _$AddCommentOnPostModelResponseCopyWithImpl<$Res,
        _$AddCommentOnPostModelResponseImpl>
    implements _$$AddCommentOnPostModelResponseImplCopyWith<$Res> {
  __$$AddCommentOnPostModelResponseImplCopyWithImpl(
      _$AddCommentOnPostModelResponseImpl _value,
      $Res Function(_$AddCommentOnPostModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
  }) {
    return _then(_$AddCommentOnPostModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddCommentOnPostModelResponseImpl
    implements _AddCommentOnPostModelResponse {
  const _$AddCommentOnPostModelResponseImpl({this.value, this.message});

  factory _$AddCommentOnPostModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddCommentOnPostModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;

  @override
  String toString() {
    return 'AddCommentOnPostModelResponse(value: $value, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCommentOnPostModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCommentOnPostModelResponseImplCopyWith<
          _$AddCommentOnPostModelResponseImpl>
      get copyWith => __$$AddCommentOnPostModelResponseImplCopyWithImpl<
          _$AddCommentOnPostModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddCommentOnPostModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AddCommentOnPostModelResponse
    implements AddCommentOnPostModelResponse {
  const factory _AddCommentOnPostModelResponse(
      {final bool? value,
      final String? message}) = _$AddCommentOnPostModelResponseImpl;

  factory _AddCommentOnPostModelResponse.fromJson(Map<String, dynamic> json) =
      _$AddCommentOnPostModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$AddCommentOnPostModelResponseImplCopyWith<
          _$AddCommentOnPostModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
