// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_patient_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeletePatientModelResponse _$DeletePatientModelResponseFromJson(
    Map<String, dynamic> json) {
  return _DeletePatientModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DeletePatientModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeletePatientModelResponseCopyWith<DeletePatientModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletePatientModelResponseCopyWith<$Res> {
  factory $DeletePatientModelResponseCopyWith(DeletePatientModelResponse value,
          $Res Function(DeletePatientModelResponse) then) =
      _$DeletePatientModelResponseCopyWithImpl<$Res,
          DeletePatientModelResponse>;
  @useResult
  $Res call({bool? value, String? message});
}

/// @nodoc
class _$DeletePatientModelResponseCopyWithImpl<$Res,
        $Val extends DeletePatientModelResponse>
    implements $DeletePatientModelResponseCopyWith<$Res> {
  _$DeletePatientModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeletePatientModelResponseImplCopyWith<$Res>
    implements $DeletePatientModelResponseCopyWith<$Res> {
  factory _$$DeletePatientModelResponseImplCopyWith(
          _$DeletePatientModelResponseImpl value,
          $Res Function(_$DeletePatientModelResponseImpl) then) =
      __$$DeletePatientModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message});
}

/// @nodoc
class __$$DeletePatientModelResponseImplCopyWithImpl<$Res>
    extends _$DeletePatientModelResponseCopyWithImpl<$Res,
        _$DeletePatientModelResponseImpl>
    implements _$$DeletePatientModelResponseImplCopyWith<$Res> {
  __$$DeletePatientModelResponseImplCopyWithImpl(
      _$DeletePatientModelResponseImpl _value,
      $Res Function(_$DeletePatientModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
  }) {
    return _then(_$DeletePatientModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeletePatientModelResponseImpl implements _DeletePatientModelResponse {
  const _$DeletePatientModelResponseImpl({this.value, this.message});

  factory _$DeletePatientModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DeletePatientModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;

  @override
  String toString() {
    return 'DeletePatientModelResponse(value: $value, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePatientModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePatientModelResponseImplCopyWith<_$DeletePatientModelResponseImpl>
      get copyWith => __$$DeletePatientModelResponseImplCopyWithImpl<
          _$DeletePatientModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletePatientModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DeletePatientModelResponse
    implements DeletePatientModelResponse {
  const factory _DeletePatientModelResponse(
      {final bool? value,
      final String? message}) = _$DeletePatientModelResponseImpl;

  factory _DeletePatientModelResponse.fromJson(Map<String, dynamic> json) =
      _$DeletePatientModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$DeletePatientModelResponseImplCopyWith<_$DeletePatientModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
