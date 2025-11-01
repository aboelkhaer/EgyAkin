// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'make_unmark_patient_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MakeUnMarkPatientModelResponse _$MakeUnMarkPatientModelResponseFromJson(
    Map<String, dynamic> json) {
  return _MakeUnMarkPatientModelResponse.fromJson(json);
}

/// @nodoc
mixin _$MakeUnMarkPatientModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this MakeUnMarkPatientModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MakeUnMarkPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MakeUnMarkPatientModelResponseCopyWith<MakeUnMarkPatientModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MakeUnMarkPatientModelResponseCopyWith<$Res> {
  factory $MakeUnMarkPatientModelResponseCopyWith(
          MakeUnMarkPatientModelResponse value,
          $Res Function(MakeUnMarkPatientModelResponse) then) =
      _$MakeUnMarkPatientModelResponseCopyWithImpl<$Res,
          MakeUnMarkPatientModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$MakeUnMarkPatientModelResponseCopyWithImpl<$Res,
        $Val extends MakeUnMarkPatientModelResponse>
    implements $MakeUnMarkPatientModelResponseCopyWith<$Res> {
  _$MakeUnMarkPatientModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MakeUnMarkPatientModelResponse
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
abstract class _$$MakeUnMarkPatientModelResponseImplCopyWith<$Res>
    implements $MakeUnMarkPatientModelResponseCopyWith<$Res> {
  factory _$$MakeUnMarkPatientModelResponseImplCopyWith(
          _$MakeUnMarkPatientModelResponseImpl value,
          $Res Function(_$MakeUnMarkPatientModelResponseImpl) then) =
      __$$MakeUnMarkPatientModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$MakeUnMarkPatientModelResponseImplCopyWithImpl<$Res>
    extends _$MakeUnMarkPatientModelResponseCopyWithImpl<$Res,
        _$MakeUnMarkPatientModelResponseImpl>
    implements _$$MakeUnMarkPatientModelResponseImplCopyWith<$Res> {
  __$$MakeUnMarkPatientModelResponseImplCopyWithImpl(
      _$MakeUnMarkPatientModelResponseImpl _value,
      $Res Function(_$MakeUnMarkPatientModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MakeUnMarkPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$MakeUnMarkPatientModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MakeUnMarkPatientModelResponseImpl
    implements _MakeUnMarkPatientModelResponse {
  const _$MakeUnMarkPatientModelResponseImpl({this.message});

  factory _$MakeUnMarkPatientModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MakeUnMarkPatientModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'MakeUnMarkPatientModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MakeUnMarkPatientModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MakeUnMarkPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MakeUnMarkPatientModelResponseImplCopyWith<
          _$MakeUnMarkPatientModelResponseImpl>
      get copyWith => __$$MakeUnMarkPatientModelResponseImplCopyWithImpl<
          _$MakeUnMarkPatientModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MakeUnMarkPatientModelResponseImplToJson(
      this,
    );
  }
}

abstract class _MakeUnMarkPatientModelResponse
    implements MakeUnMarkPatientModelResponse {
  const factory _MakeUnMarkPatientModelResponse({final String? message}) =
      _$MakeUnMarkPatientModelResponseImpl;

  factory _MakeUnMarkPatientModelResponse.fromJson(Map<String, dynamic> json) =
      _$MakeUnMarkPatientModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of MakeUnMarkPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MakeUnMarkPatientModelResponseImplCopyWith<
          _$MakeUnMarkPatientModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
