// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_vote_and_unvote_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddVoteAndUnvoteModelResponse _$AddVoteAndUnvoteModelResponseFromJson(
    Map<String, dynamic> json) {
  return _AddVoteAndUnvoteModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AddVoteAndUnvoteModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this AddVoteAndUnvoteModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddVoteAndUnvoteModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddVoteAndUnvoteModelResponseCopyWith<AddVoteAndUnvoteModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddVoteAndUnvoteModelResponseCopyWith<$Res> {
  factory $AddVoteAndUnvoteModelResponseCopyWith(
          AddVoteAndUnvoteModelResponse value,
          $Res Function(AddVoteAndUnvoteModelResponse) then) =
      _$AddVoteAndUnvoteModelResponseCopyWithImpl<$Res,
          AddVoteAndUnvoteModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$AddVoteAndUnvoteModelResponseCopyWithImpl<$Res,
        $Val extends AddVoteAndUnvoteModelResponse>
    implements $AddVoteAndUnvoteModelResponseCopyWith<$Res> {
  _$AddVoteAndUnvoteModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddVoteAndUnvoteModelResponse
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
abstract class _$$AddVoteAndUnvoteModelResponseImplCopyWith<$Res>
    implements $AddVoteAndUnvoteModelResponseCopyWith<$Res> {
  factory _$$AddVoteAndUnvoteModelResponseImplCopyWith(
          _$AddVoteAndUnvoteModelResponseImpl value,
          $Res Function(_$AddVoteAndUnvoteModelResponseImpl) then) =
      __$$AddVoteAndUnvoteModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$AddVoteAndUnvoteModelResponseImplCopyWithImpl<$Res>
    extends _$AddVoteAndUnvoteModelResponseCopyWithImpl<$Res,
        _$AddVoteAndUnvoteModelResponseImpl>
    implements _$$AddVoteAndUnvoteModelResponseImplCopyWith<$Res> {
  __$$AddVoteAndUnvoteModelResponseImplCopyWithImpl(
      _$AddVoteAndUnvoteModelResponseImpl _value,
      $Res Function(_$AddVoteAndUnvoteModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddVoteAndUnvoteModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$AddVoteAndUnvoteModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddVoteAndUnvoteModelResponseImpl
    implements _AddVoteAndUnvoteModelResponse {
  const _$AddVoteAndUnvoteModelResponseImpl({this.message});

  factory _$AddVoteAndUnvoteModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddVoteAndUnvoteModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'AddVoteAndUnvoteModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddVoteAndUnvoteModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AddVoteAndUnvoteModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddVoteAndUnvoteModelResponseImplCopyWith<
          _$AddVoteAndUnvoteModelResponseImpl>
      get copyWith => __$$AddVoteAndUnvoteModelResponseImplCopyWithImpl<
          _$AddVoteAndUnvoteModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddVoteAndUnvoteModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AddVoteAndUnvoteModelResponse
    implements AddVoteAndUnvoteModelResponse {
  const factory _AddVoteAndUnvoteModelResponse({final String? message}) =
      _$AddVoteAndUnvoteModelResponseImpl;

  factory _AddVoteAndUnvoteModelResponse.fromJson(Map<String, dynamic> json) =
      _$AddVoteAndUnvoteModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of AddVoteAndUnvoteModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddVoteAndUnvoteModelResponseImplCopyWith<
          _$AddVoteAndUnvoteModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
