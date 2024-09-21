// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'block_user_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BlockUserModelResponse _$BlockUserModelResponseFromJson(
    Map<String, dynamic> json) {
  return _BlockUserModelResponse.fromJson(json);
}

/// @nodoc
mixin _$BlockUserModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this BlockUserModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BlockUserModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlockUserModelResponseCopyWith<BlockUserModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockUserModelResponseCopyWith<$Res> {
  factory $BlockUserModelResponseCopyWith(BlockUserModelResponse value,
          $Res Function(BlockUserModelResponse) then) =
      _$BlockUserModelResponseCopyWithImpl<$Res, BlockUserModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$BlockUserModelResponseCopyWithImpl<$Res,
        $Val extends BlockUserModelResponse>
    implements $BlockUserModelResponseCopyWith<$Res> {
  _$BlockUserModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlockUserModelResponse
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
abstract class _$$BlockUserModelResponseImplCopyWith<$Res>
    implements $BlockUserModelResponseCopyWith<$Res> {
  factory _$$BlockUserModelResponseImplCopyWith(
          _$BlockUserModelResponseImpl value,
          $Res Function(_$BlockUserModelResponseImpl) then) =
      __$$BlockUserModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$BlockUserModelResponseImplCopyWithImpl<$Res>
    extends _$BlockUserModelResponseCopyWithImpl<$Res,
        _$BlockUserModelResponseImpl>
    implements _$$BlockUserModelResponseImplCopyWith<$Res> {
  __$$BlockUserModelResponseImplCopyWithImpl(
      _$BlockUserModelResponseImpl _value,
      $Res Function(_$BlockUserModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of BlockUserModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$BlockUserModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BlockUserModelResponseImpl implements _BlockUserModelResponse {
  const _$BlockUserModelResponseImpl({this.message});

  factory _$BlockUserModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlockUserModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'BlockUserModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockUserModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BlockUserModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockUserModelResponseImplCopyWith<_$BlockUserModelResponseImpl>
      get copyWith => __$$BlockUserModelResponseImplCopyWithImpl<
          _$BlockUserModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlockUserModelResponseImplToJson(
      this,
    );
  }
}

abstract class _BlockUserModelResponse implements BlockUserModelResponse {
  const factory _BlockUserModelResponse({final String? message}) =
      _$BlockUserModelResponseImpl;

  factory _BlockUserModelResponse.fromJson(Map<String, dynamic> json) =
      _$BlockUserModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of BlockUserModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlockUserModelResponseImplCopyWith<_$BlockUserModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
