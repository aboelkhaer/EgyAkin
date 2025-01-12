// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_post_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EditPostInCommunityModelResponse _$EditPostInCommunityModelResponseFromJson(
    Map<String, dynamic> json) {
  return _EditPostInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$EditPostInCommunityModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this EditPostInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EditPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditPostInCommunityModelResponseCopyWith<EditPostInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditPostInCommunityModelResponseCopyWith<$Res> {
  factory $EditPostInCommunityModelResponseCopyWith(
          EditPostInCommunityModelResponse value,
          $Res Function(EditPostInCommunityModelResponse) then) =
      _$EditPostInCommunityModelResponseCopyWithImpl<$Res,
          EditPostInCommunityModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$EditPostInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends EditPostInCommunityModelResponse>
    implements $EditPostInCommunityModelResponseCopyWith<$Res> {
  _$EditPostInCommunityModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditPostInCommunityModelResponse
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
abstract class _$$EditPostInCommunityModelResponseImplCopyWith<$Res>
    implements $EditPostInCommunityModelResponseCopyWith<$Res> {
  factory _$$EditPostInCommunityModelResponseImplCopyWith(
          _$EditPostInCommunityModelResponseImpl value,
          $Res Function(_$EditPostInCommunityModelResponseImpl) then) =
      __$$EditPostInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$EditPostInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$EditPostInCommunityModelResponseCopyWithImpl<$Res,
        _$EditPostInCommunityModelResponseImpl>
    implements _$$EditPostInCommunityModelResponseImplCopyWith<$Res> {
  __$$EditPostInCommunityModelResponseImplCopyWithImpl(
      _$EditPostInCommunityModelResponseImpl _value,
      $Res Function(_$EditPostInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$EditPostInCommunityModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EditPostInCommunityModelResponseImpl
    implements _EditPostInCommunityModelResponse {
  const _$EditPostInCommunityModelResponseImpl({this.message});

  factory _$EditPostInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EditPostInCommunityModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'EditPostInCommunityModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditPostInCommunityModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of EditPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditPostInCommunityModelResponseImplCopyWith<
          _$EditPostInCommunityModelResponseImpl>
      get copyWith => __$$EditPostInCommunityModelResponseImplCopyWithImpl<
          _$EditPostInCommunityModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EditPostInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _EditPostInCommunityModelResponse
    implements EditPostInCommunityModelResponse {
  const factory _EditPostInCommunityModelResponse({final String? message}) =
      _$EditPostInCommunityModelResponseImpl;

  factory _EditPostInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$EditPostInCommunityModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of EditPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditPostInCommunityModelResponseImplCopyWith<
          _$EditPostInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
