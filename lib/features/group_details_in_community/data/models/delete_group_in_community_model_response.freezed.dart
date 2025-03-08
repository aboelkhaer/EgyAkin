// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_group_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeleteGroupInCommunityModelResponse
    _$DeleteGroupInCommunityModelResponseFromJson(Map<String, dynamic> json) {
  return _DeleteGroupInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DeleteGroupInCommunityModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this DeleteGroupInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeleteGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeleteGroupInCommunityModelResponseCopyWith<
          DeleteGroupInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteGroupInCommunityModelResponseCopyWith<$Res> {
  factory $DeleteGroupInCommunityModelResponseCopyWith(
          DeleteGroupInCommunityModelResponse value,
          $Res Function(DeleteGroupInCommunityModelResponse) then) =
      _$DeleteGroupInCommunityModelResponseCopyWithImpl<$Res,
          DeleteGroupInCommunityModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$DeleteGroupInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends DeleteGroupInCommunityModelResponse>
    implements $DeleteGroupInCommunityModelResponseCopyWith<$Res> {
  _$DeleteGroupInCommunityModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeleteGroupInCommunityModelResponse
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
abstract class _$$DeleteGroupInCommunityModelResponseImplCopyWith<$Res>
    implements $DeleteGroupInCommunityModelResponseCopyWith<$Res> {
  factory _$$DeleteGroupInCommunityModelResponseImplCopyWith(
          _$DeleteGroupInCommunityModelResponseImpl value,
          $Res Function(_$DeleteGroupInCommunityModelResponseImpl) then) =
      __$$DeleteGroupInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$DeleteGroupInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$DeleteGroupInCommunityModelResponseCopyWithImpl<$Res,
        _$DeleteGroupInCommunityModelResponseImpl>
    implements _$$DeleteGroupInCommunityModelResponseImplCopyWith<$Res> {
  __$$DeleteGroupInCommunityModelResponseImplCopyWithImpl(
      _$DeleteGroupInCommunityModelResponseImpl _value,
      $Res Function(_$DeleteGroupInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeleteGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$DeleteGroupInCommunityModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteGroupInCommunityModelResponseImpl
    implements _DeleteGroupInCommunityModelResponse {
  const _$DeleteGroupInCommunityModelResponseImpl({this.message});

  factory _$DeleteGroupInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DeleteGroupInCommunityModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'DeleteGroupInCommunityModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteGroupInCommunityModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of DeleteGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteGroupInCommunityModelResponseImplCopyWith<
          _$DeleteGroupInCommunityModelResponseImpl>
      get copyWith => __$$DeleteGroupInCommunityModelResponseImplCopyWithImpl<
          _$DeleteGroupInCommunityModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteGroupInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DeleteGroupInCommunityModelResponse
    implements DeleteGroupInCommunityModelResponse {
  const factory _DeleteGroupInCommunityModelResponse({final String? message}) =
      _$DeleteGroupInCommunityModelResponseImpl;

  factory _DeleteGroupInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$DeleteGroupInCommunityModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of DeleteGroupInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteGroupInCommunityModelResponseImplCopyWith<
          _$DeleteGroupInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
