// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_patient_for_first_time_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddPatientForFirstTimeModelResponse
    _$AddPatientForFirstTimeModelResponseFromJson(Map<String, dynamic> json) {
  return _AddPatientForFirstTimeModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AddPatientForFirstTimeModelResponse {
  int? get id => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddPatientForFirstTimeModelResponseCopyWith<
          AddPatientForFirstTimeModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddPatientForFirstTimeModelResponseCopyWith<$Res> {
  factory $AddPatientForFirstTimeModelResponseCopyWith(
          AddPatientForFirstTimeModelResponse value,
          $Res Function(AddPatientForFirstTimeModelResponse) then) =
      _$AddPatientForFirstTimeModelResponseCopyWithImpl<$Res,
          AddPatientForFirstTimeModelResponse>;
  @useResult
  $Res call({int? id, String? message});
}

/// @nodoc
class _$AddPatientForFirstTimeModelResponseCopyWithImpl<$Res,
        $Val extends AddPatientForFirstTimeModelResponse>
    implements $AddPatientForFirstTimeModelResponseCopyWith<$Res> {
  _$AddPatientForFirstTimeModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddPatientForFirstTimeModelResponseImplCopyWith<$Res>
    implements $AddPatientForFirstTimeModelResponseCopyWith<$Res> {
  factory _$$AddPatientForFirstTimeModelResponseImplCopyWith(
          _$AddPatientForFirstTimeModelResponseImpl value,
          $Res Function(_$AddPatientForFirstTimeModelResponseImpl) then) =
      __$$AddPatientForFirstTimeModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? message});
}

/// @nodoc
class __$$AddPatientForFirstTimeModelResponseImplCopyWithImpl<$Res>
    extends _$AddPatientForFirstTimeModelResponseCopyWithImpl<$Res,
        _$AddPatientForFirstTimeModelResponseImpl>
    implements _$$AddPatientForFirstTimeModelResponseImplCopyWith<$Res> {
  __$$AddPatientForFirstTimeModelResponseImplCopyWithImpl(
      _$AddPatientForFirstTimeModelResponseImpl _value,
      $Res Function(_$AddPatientForFirstTimeModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? message = freezed,
  }) {
    return _then(_$AddPatientForFirstTimeModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddPatientForFirstTimeModelResponseImpl
    implements _AddPatientForFirstTimeModelResponse {
  const _$AddPatientForFirstTimeModelResponseImpl({this.id, this.message});

  factory _$AddPatientForFirstTimeModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddPatientForFirstTimeModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  final String? message;

  @override
  String toString() {
    return 'AddPatientForFirstTimeModelResponse(id: $id, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddPatientForFirstTimeModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddPatientForFirstTimeModelResponseImplCopyWith<
          _$AddPatientForFirstTimeModelResponseImpl>
      get copyWith => __$$AddPatientForFirstTimeModelResponseImplCopyWithImpl<
          _$AddPatientForFirstTimeModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddPatientForFirstTimeModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AddPatientForFirstTimeModelResponse
    implements AddPatientForFirstTimeModelResponse {
  const factory _AddPatientForFirstTimeModelResponse(
      {final int? id,
      final String? message}) = _$AddPatientForFirstTimeModelResponseImpl;

  factory _AddPatientForFirstTimeModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$AddPatientForFirstTimeModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$AddPatientForFirstTimeModelResponseImplCopyWith<
          _$AddPatientForFirstTimeModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
