// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_post_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeletePostModelResponse _$DeletePostModelResponseFromJson(
    Map<String, dynamic> json) {
  return _DeletePostModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DeletePostModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this DeletePostModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeletePostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeletePostModelResponseCopyWith<DeletePostModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletePostModelResponseCopyWith<$Res> {
  factory $DeletePostModelResponseCopyWith(DeletePostModelResponse value,
          $Res Function(DeletePostModelResponse) then) =
      _$DeletePostModelResponseCopyWithImpl<$Res, DeletePostModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$DeletePostModelResponseCopyWithImpl<$Res,
        $Val extends DeletePostModelResponse>
    implements $DeletePostModelResponseCopyWith<$Res> {
  _$DeletePostModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeletePostModelResponse
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
abstract class _$$DeletePostModelResponseImplCopyWith<$Res>
    implements $DeletePostModelResponseCopyWith<$Res> {
  factory _$$DeletePostModelResponseImplCopyWith(
          _$DeletePostModelResponseImpl value,
          $Res Function(_$DeletePostModelResponseImpl) then) =
      __$$DeletePostModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$DeletePostModelResponseImplCopyWithImpl<$Res>
    extends _$DeletePostModelResponseCopyWithImpl<$Res,
        _$DeletePostModelResponseImpl>
    implements _$$DeletePostModelResponseImplCopyWith<$Res> {
  __$$DeletePostModelResponseImplCopyWithImpl(
      _$DeletePostModelResponseImpl _value,
      $Res Function(_$DeletePostModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeletePostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$DeletePostModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeletePostModelResponseImpl implements _DeletePostModelResponse {
  const _$DeletePostModelResponseImpl({this.message});

  factory _$DeletePostModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeletePostModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'DeletePostModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePostModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of DeletePostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePostModelResponseImplCopyWith<_$DeletePostModelResponseImpl>
      get copyWith => __$$DeletePostModelResponseImplCopyWithImpl<
          _$DeletePostModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletePostModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DeletePostModelResponse implements DeletePostModelResponse {
  const factory _DeletePostModelResponse({final String? message}) =
      _$DeletePostModelResponseImpl;

  factory _DeletePostModelResponse.fromJson(Map<String, dynamic> json) =
      _$DeletePostModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of DeletePostModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeletePostModelResponseImplCopyWith<_$DeletePostModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
