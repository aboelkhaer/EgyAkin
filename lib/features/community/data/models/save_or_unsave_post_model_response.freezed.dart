// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_or_unsave_post_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SaveOrUnsavePostModelResponse _$SaveOrUnsavePostModelResponseFromJson(
    Map<String, dynamic> json) {
  return _SaveOrUnsavePostModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SaveOrUnsavePostModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this SaveOrUnsavePostModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaveOrUnsavePostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaveOrUnsavePostModelResponseCopyWith<SaveOrUnsavePostModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveOrUnsavePostModelResponseCopyWith<$Res> {
  factory $SaveOrUnsavePostModelResponseCopyWith(
          SaveOrUnsavePostModelResponse value,
          $Res Function(SaveOrUnsavePostModelResponse) then) =
      _$SaveOrUnsavePostModelResponseCopyWithImpl<$Res,
          SaveOrUnsavePostModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$SaveOrUnsavePostModelResponseCopyWithImpl<$Res,
        $Val extends SaveOrUnsavePostModelResponse>
    implements $SaveOrUnsavePostModelResponseCopyWith<$Res> {
  _$SaveOrUnsavePostModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaveOrUnsavePostModelResponse
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
abstract class _$$SaveOrUnsavePostModelResponseImplCopyWith<$Res>
    implements $SaveOrUnsavePostModelResponseCopyWith<$Res> {
  factory _$$SaveOrUnsavePostModelResponseImplCopyWith(
          _$SaveOrUnsavePostModelResponseImpl value,
          $Res Function(_$SaveOrUnsavePostModelResponseImpl) then) =
      __$$SaveOrUnsavePostModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$SaveOrUnsavePostModelResponseImplCopyWithImpl<$Res>
    extends _$SaveOrUnsavePostModelResponseCopyWithImpl<$Res,
        _$SaveOrUnsavePostModelResponseImpl>
    implements _$$SaveOrUnsavePostModelResponseImplCopyWith<$Res> {
  __$$SaveOrUnsavePostModelResponseImplCopyWithImpl(
      _$SaveOrUnsavePostModelResponseImpl _value,
      $Res Function(_$SaveOrUnsavePostModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaveOrUnsavePostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$SaveOrUnsavePostModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaveOrUnsavePostModelResponseImpl
    implements _SaveOrUnsavePostModelResponse {
  const _$SaveOrUnsavePostModelResponseImpl({this.message});

  factory _$SaveOrUnsavePostModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SaveOrUnsavePostModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'SaveOrUnsavePostModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveOrUnsavePostModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SaveOrUnsavePostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveOrUnsavePostModelResponseImplCopyWith<
          _$SaveOrUnsavePostModelResponseImpl>
      get copyWith => __$$SaveOrUnsavePostModelResponseImplCopyWithImpl<
          _$SaveOrUnsavePostModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaveOrUnsavePostModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SaveOrUnsavePostModelResponse
    implements SaveOrUnsavePostModelResponse {
  const factory _SaveOrUnsavePostModelResponse({final String? message}) =
      _$SaveOrUnsavePostModelResponseImpl;

  factory _SaveOrUnsavePostModelResponse.fromJson(Map<String, dynamic> json) =
      _$SaveOrUnsavePostModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of SaveOrUnsavePostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveOrUnsavePostModelResponseImplCopyWith<
          _$SaveOrUnsavePostModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
