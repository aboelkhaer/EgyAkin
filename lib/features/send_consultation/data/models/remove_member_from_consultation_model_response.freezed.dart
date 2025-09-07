// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remove_member_from_consultation_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RemoveMemberFromConsultationModelResponse
    _$RemoveMemberFromConsultationModelResponseFromJson(
        Map<String, dynamic> json) {
  return _RemoveMemberFromConsultationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$RemoveMemberFromConsultationModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this RemoveMemberFromConsultationModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RemoveMemberFromConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RemoveMemberFromConsultationModelResponseCopyWith<
          RemoveMemberFromConsultationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoveMemberFromConsultationModelResponseCopyWith<$Res> {
  factory $RemoveMemberFromConsultationModelResponseCopyWith(
          RemoveMemberFromConsultationModelResponse value,
          $Res Function(RemoveMemberFromConsultationModelResponse) then) =
      _$RemoveMemberFromConsultationModelResponseCopyWithImpl<$Res,
          RemoveMemberFromConsultationModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$RemoveMemberFromConsultationModelResponseCopyWithImpl<$Res,
        $Val extends RemoveMemberFromConsultationModelResponse>
    implements $RemoveMemberFromConsultationModelResponseCopyWith<$Res> {
  _$RemoveMemberFromConsultationModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RemoveMemberFromConsultationModelResponse
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
abstract class _$$RemoveMemberFromConsultationModelResponseImplCopyWith<$Res>
    implements $RemoveMemberFromConsultationModelResponseCopyWith<$Res> {
  factory _$$RemoveMemberFromConsultationModelResponseImplCopyWith(
          _$RemoveMemberFromConsultationModelResponseImpl value,
          $Res Function(_$RemoveMemberFromConsultationModelResponseImpl) then) =
      __$$RemoveMemberFromConsultationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$RemoveMemberFromConsultationModelResponseImplCopyWithImpl<$Res>
    extends _$RemoveMemberFromConsultationModelResponseCopyWithImpl<$Res,
        _$RemoveMemberFromConsultationModelResponseImpl>
    implements _$$RemoveMemberFromConsultationModelResponseImplCopyWith<$Res> {
  __$$RemoveMemberFromConsultationModelResponseImplCopyWithImpl(
      _$RemoveMemberFromConsultationModelResponseImpl _value,
      $Res Function(_$RemoveMemberFromConsultationModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of RemoveMemberFromConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$RemoveMemberFromConsultationModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoveMemberFromConsultationModelResponseImpl
    implements _RemoveMemberFromConsultationModelResponse {
  const _$RemoveMemberFromConsultationModelResponseImpl({this.message});

  factory _$RemoveMemberFromConsultationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$RemoveMemberFromConsultationModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'RemoveMemberFromConsultationModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveMemberFromConsultationModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of RemoveMemberFromConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveMemberFromConsultationModelResponseImplCopyWith<
          _$RemoveMemberFromConsultationModelResponseImpl>
      get copyWith =>
          __$$RemoveMemberFromConsultationModelResponseImplCopyWithImpl<
                  _$RemoveMemberFromConsultationModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoveMemberFromConsultationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _RemoveMemberFromConsultationModelResponse
    implements RemoveMemberFromConsultationModelResponse {
  const factory _RemoveMemberFromConsultationModelResponse(
          {final String? message}) =
      _$RemoveMemberFromConsultationModelResponseImpl;

  factory _RemoveMemberFromConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$RemoveMemberFromConsultationModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of RemoveMemberFromConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveMemberFromConsultationModelResponseImplCopyWith<
          _$RemoveMemberFromConsultationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
