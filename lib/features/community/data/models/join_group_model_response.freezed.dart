// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'join_group_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JoinGroupModelResponse _$JoinGroupModelResponseFromJson(
    Map<String, dynamic> json) {
  return _JoinGroupModelResponse.fromJson(json);
}

/// @nodoc
mixin _$JoinGroupModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this JoinGroupModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JoinGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JoinGroupModelResponseCopyWith<JoinGroupModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinGroupModelResponseCopyWith<$Res> {
  factory $JoinGroupModelResponseCopyWith(JoinGroupModelResponse value,
          $Res Function(JoinGroupModelResponse) then) =
      _$JoinGroupModelResponseCopyWithImpl<$Res, JoinGroupModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$JoinGroupModelResponseCopyWithImpl<$Res,
        $Val extends JoinGroupModelResponse>
    implements $JoinGroupModelResponseCopyWith<$Res> {
  _$JoinGroupModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JoinGroupModelResponse
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
abstract class _$$JoinGroupModelResponseImplCopyWith<$Res>
    implements $JoinGroupModelResponseCopyWith<$Res> {
  factory _$$JoinGroupModelResponseImplCopyWith(
          _$JoinGroupModelResponseImpl value,
          $Res Function(_$JoinGroupModelResponseImpl) then) =
      __$$JoinGroupModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$JoinGroupModelResponseImplCopyWithImpl<$Res>
    extends _$JoinGroupModelResponseCopyWithImpl<$Res,
        _$JoinGroupModelResponseImpl>
    implements _$$JoinGroupModelResponseImplCopyWith<$Res> {
  __$$JoinGroupModelResponseImplCopyWithImpl(
      _$JoinGroupModelResponseImpl _value,
      $Res Function(_$JoinGroupModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of JoinGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$JoinGroupModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JoinGroupModelResponseImpl implements _JoinGroupModelResponse {
  const _$JoinGroupModelResponseImpl({this.message});

  factory _$JoinGroupModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$JoinGroupModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'JoinGroupModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinGroupModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of JoinGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinGroupModelResponseImplCopyWith<_$JoinGroupModelResponseImpl>
      get copyWith => __$$JoinGroupModelResponseImplCopyWithImpl<
          _$JoinGroupModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinGroupModelResponseImplToJson(
      this,
    );
  }
}

abstract class _JoinGroupModelResponse implements JoinGroupModelResponse {
  const factory _JoinGroupModelResponse({final String? message}) =
      _$JoinGroupModelResponseImpl;

  factory _JoinGroupModelResponse.fromJson(Map<String, dynamic> json) =
      _$JoinGroupModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of JoinGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JoinGroupModelResponseImplCopyWith<_$JoinGroupModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
