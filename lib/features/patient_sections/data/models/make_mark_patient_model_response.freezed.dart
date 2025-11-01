// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'make_mark_patient_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MakeMarkPatientModelResponse _$MakeMarkPatientModelResponseFromJson(
    Map<String, dynamic> json) {
  return _MakeMarkPatientModelResponse.fromJson(json);
}

/// @nodoc
mixin _$MakeMarkPatientModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this MakeMarkPatientModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MakeMarkPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MakeMarkPatientModelResponseCopyWith<MakeMarkPatientModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MakeMarkPatientModelResponseCopyWith<$Res> {
  factory $MakeMarkPatientModelResponseCopyWith(
          MakeMarkPatientModelResponse value,
          $Res Function(MakeMarkPatientModelResponse) then) =
      _$MakeMarkPatientModelResponseCopyWithImpl<$Res,
          MakeMarkPatientModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$MakeMarkPatientModelResponseCopyWithImpl<$Res,
        $Val extends MakeMarkPatientModelResponse>
    implements $MakeMarkPatientModelResponseCopyWith<$Res> {
  _$MakeMarkPatientModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MakeMarkPatientModelResponse
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
abstract class _$$MakeMarkPatientModelResponseImplCopyWith<$Res>
    implements $MakeMarkPatientModelResponseCopyWith<$Res> {
  factory _$$MakeMarkPatientModelResponseImplCopyWith(
          _$MakeMarkPatientModelResponseImpl value,
          $Res Function(_$MakeMarkPatientModelResponseImpl) then) =
      __$$MakeMarkPatientModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$MakeMarkPatientModelResponseImplCopyWithImpl<$Res>
    extends _$MakeMarkPatientModelResponseCopyWithImpl<$Res,
        _$MakeMarkPatientModelResponseImpl>
    implements _$$MakeMarkPatientModelResponseImplCopyWith<$Res> {
  __$$MakeMarkPatientModelResponseImplCopyWithImpl(
      _$MakeMarkPatientModelResponseImpl _value,
      $Res Function(_$MakeMarkPatientModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MakeMarkPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$MakeMarkPatientModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MakeMarkPatientModelResponseImpl
    implements _MakeMarkPatientModelResponse {
  const _$MakeMarkPatientModelResponseImpl({this.message});

  factory _$MakeMarkPatientModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MakeMarkPatientModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'MakeMarkPatientModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MakeMarkPatientModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MakeMarkPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MakeMarkPatientModelResponseImplCopyWith<
          _$MakeMarkPatientModelResponseImpl>
      get copyWith => __$$MakeMarkPatientModelResponseImplCopyWithImpl<
          _$MakeMarkPatientModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MakeMarkPatientModelResponseImplToJson(
      this,
    );
  }
}

abstract class _MakeMarkPatientModelResponse
    implements MakeMarkPatientModelResponse {
  const factory _MakeMarkPatientModelResponse({final String? message}) =
      _$MakeMarkPatientModelResponseImpl;

  factory _MakeMarkPatientModelResponse.fromJson(Map<String, dynamic> json) =
      _$MakeMarkPatientModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of MakeMarkPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MakeMarkPatientModelResponseImplCopyWith<
          _$MakeMarkPatientModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
