// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_group_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveGroupModelResponse _$LeaveGroupModelResponseFromJson(
    Map<String, dynamic> json) {
  return _LeaveGroupModelResponse.fromJson(json);
}

/// @nodoc
mixin _$LeaveGroupModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this LeaveGroupModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveGroupModelResponseCopyWith<LeaveGroupModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveGroupModelResponseCopyWith<$Res> {
  factory $LeaveGroupModelResponseCopyWith(LeaveGroupModelResponse value,
          $Res Function(LeaveGroupModelResponse) then) =
      _$LeaveGroupModelResponseCopyWithImpl<$Res, LeaveGroupModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$LeaveGroupModelResponseCopyWithImpl<$Res,
        $Val extends LeaveGroupModelResponse>
    implements $LeaveGroupModelResponseCopyWith<$Res> {
  _$LeaveGroupModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveGroupModelResponse
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
abstract class _$$LeaveGroupModelResponseImplCopyWith<$Res>
    implements $LeaveGroupModelResponseCopyWith<$Res> {
  factory _$$LeaveGroupModelResponseImplCopyWith(
          _$LeaveGroupModelResponseImpl value,
          $Res Function(_$LeaveGroupModelResponseImpl) then) =
      __$$LeaveGroupModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$LeaveGroupModelResponseImplCopyWithImpl<$Res>
    extends _$LeaveGroupModelResponseCopyWithImpl<$Res,
        _$LeaveGroupModelResponseImpl>
    implements _$$LeaveGroupModelResponseImplCopyWith<$Res> {
  __$$LeaveGroupModelResponseImplCopyWithImpl(
      _$LeaveGroupModelResponseImpl _value,
      $Res Function(_$LeaveGroupModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$LeaveGroupModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveGroupModelResponseImpl implements _LeaveGroupModelResponse {
  const _$LeaveGroupModelResponseImpl({this.message});

  factory _$LeaveGroupModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveGroupModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'LeaveGroupModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveGroupModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of LeaveGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveGroupModelResponseImplCopyWith<_$LeaveGroupModelResponseImpl>
      get copyWith => __$$LeaveGroupModelResponseImplCopyWithImpl<
          _$LeaveGroupModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveGroupModelResponseImplToJson(
      this,
    );
  }
}

abstract class _LeaveGroupModelResponse implements LeaveGroupModelResponse {
  const factory _LeaveGroupModelResponse({final String? message}) =
      _$LeaveGroupModelResponseImpl;

  factory _LeaveGroupModelResponse.fromJson(Map<String, dynamic> json) =
      _$LeaveGroupModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of LeaveGroupModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveGroupModelResponseImplCopyWith<_$LeaveGroupModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
