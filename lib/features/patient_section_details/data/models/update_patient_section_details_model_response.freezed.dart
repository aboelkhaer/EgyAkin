// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_patient_section_details_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdatePatientSectionDetailsModelResponse
    _$UpdatePatientSectionDetailsModelResponseFromJson(
        Map<String, dynamic> json) {
  return _UpdatePatientSectionDetailsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$UpdatePatientSectionDetailsModelResponse {
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdatePatientSectionDetailsModelResponseCopyWith<
          UpdatePatientSectionDetailsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePatientSectionDetailsModelResponseCopyWith<$Res> {
  factory $UpdatePatientSectionDetailsModelResponseCopyWith(
          UpdatePatientSectionDetailsModelResponse value,
          $Res Function(UpdatePatientSectionDetailsModelResponse) then) =
      _$UpdatePatientSectionDetailsModelResponseCopyWithImpl<$Res,
          UpdatePatientSectionDetailsModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$UpdatePatientSectionDetailsModelResponseCopyWithImpl<$Res,
        $Val extends UpdatePatientSectionDetailsModelResponse>
    implements $UpdatePatientSectionDetailsModelResponseCopyWith<$Res> {
  _$UpdatePatientSectionDetailsModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$UpdatePatientSectionDetailsModelResponseImplCopyWith<$Res>
    implements $UpdatePatientSectionDetailsModelResponseCopyWith<$Res> {
  factory _$$UpdatePatientSectionDetailsModelResponseImplCopyWith(
          _$UpdatePatientSectionDetailsModelResponseImpl value,
          $Res Function(_$UpdatePatientSectionDetailsModelResponseImpl) then) =
      __$$UpdatePatientSectionDetailsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UpdatePatientSectionDetailsModelResponseImplCopyWithImpl<$Res>
    extends _$UpdatePatientSectionDetailsModelResponseCopyWithImpl<$Res,
        _$UpdatePatientSectionDetailsModelResponseImpl>
    implements _$$UpdatePatientSectionDetailsModelResponseImplCopyWith<$Res> {
  __$$UpdatePatientSectionDetailsModelResponseImplCopyWithImpl(
      _$UpdatePatientSectionDetailsModelResponseImpl _value,
      $Res Function(_$UpdatePatientSectionDetailsModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UpdatePatientSectionDetailsModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePatientSectionDetailsModelResponseImpl
    implements _UpdatePatientSectionDetailsModelResponse {
  const _$UpdatePatientSectionDetailsModelResponseImpl({this.message});

  factory _$UpdatePatientSectionDetailsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UpdatePatientSectionDetailsModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'UpdatePatientSectionDetailsModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePatientSectionDetailsModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePatientSectionDetailsModelResponseImplCopyWith<
          _$UpdatePatientSectionDetailsModelResponseImpl>
      get copyWith =>
          __$$UpdatePatientSectionDetailsModelResponseImplCopyWithImpl<
              _$UpdatePatientSectionDetailsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePatientSectionDetailsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _UpdatePatientSectionDetailsModelResponse
    implements UpdatePatientSectionDetailsModelResponse {
  const factory _UpdatePatientSectionDetailsModelResponse(
      {final String? message}) = _$UpdatePatientSectionDetailsModelResponseImpl;

  factory _UpdatePatientSectionDetailsModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$UpdatePatientSectionDetailsModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$UpdatePatientSectionDetailsModelResponseImplCopyWith<
          _$UpdatePatientSectionDetailsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
