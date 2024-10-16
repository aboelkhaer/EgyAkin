// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_like_on_post_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddLikeOnPostModelResponse _$AddLikeOnPostModelResponseFromJson(
    Map<String, dynamic> json) {
  return _AddLikeOnPostModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AddLikeOnPostModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this AddLikeOnPostModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddLikeOnPostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddLikeOnPostModelResponseCopyWith<AddLikeOnPostModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddLikeOnPostModelResponseCopyWith<$Res> {
  factory $AddLikeOnPostModelResponseCopyWith(AddLikeOnPostModelResponse value,
          $Res Function(AddLikeOnPostModelResponse) then) =
      _$AddLikeOnPostModelResponseCopyWithImpl<$Res,
          AddLikeOnPostModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$AddLikeOnPostModelResponseCopyWithImpl<$Res,
        $Val extends AddLikeOnPostModelResponse>
    implements $AddLikeOnPostModelResponseCopyWith<$Res> {
  _$AddLikeOnPostModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddLikeOnPostModelResponse
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
abstract class _$$AddLikeOnPostModelResponseImplCopyWith<$Res>
    implements $AddLikeOnPostModelResponseCopyWith<$Res> {
  factory _$$AddLikeOnPostModelResponseImplCopyWith(
          _$AddLikeOnPostModelResponseImpl value,
          $Res Function(_$AddLikeOnPostModelResponseImpl) then) =
      __$$AddLikeOnPostModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$AddLikeOnPostModelResponseImplCopyWithImpl<$Res>
    extends _$AddLikeOnPostModelResponseCopyWithImpl<$Res,
        _$AddLikeOnPostModelResponseImpl>
    implements _$$AddLikeOnPostModelResponseImplCopyWith<$Res> {
  __$$AddLikeOnPostModelResponseImplCopyWithImpl(
      _$AddLikeOnPostModelResponseImpl _value,
      $Res Function(_$AddLikeOnPostModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddLikeOnPostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$AddLikeOnPostModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddLikeOnPostModelResponseImpl implements _AddLikeOnPostModelResponse {
  const _$AddLikeOnPostModelResponseImpl({this.message});

  factory _$AddLikeOnPostModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddLikeOnPostModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'AddLikeOnPostModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddLikeOnPostModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AddLikeOnPostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddLikeOnPostModelResponseImplCopyWith<_$AddLikeOnPostModelResponseImpl>
      get copyWith => __$$AddLikeOnPostModelResponseImplCopyWithImpl<
          _$AddLikeOnPostModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddLikeOnPostModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AddLikeOnPostModelResponse
    implements AddLikeOnPostModelResponse {
  const factory _AddLikeOnPostModelResponse({final String? message}) =
      _$AddLikeOnPostModelResponseImpl;

  factory _AddLikeOnPostModelResponse.fromJson(Map<String, dynamic> json) =
      _$AddLikeOnPostModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of AddLikeOnPostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddLikeOnPostModelResponseImplCopyWith<_$AddLikeOnPostModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
