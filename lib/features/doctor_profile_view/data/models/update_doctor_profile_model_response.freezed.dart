// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_doctor_profile_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateDoctorProfileModelResponse _$UpdateDoctorProfileModelResponseFromJson(
    Map<String, dynamic> json) {
  return _UpdateDoctorProfileModelResponse.fromJson(json);
}

/// @nodoc
mixin _$UpdateDoctorProfileModelResponse {
  DoctorModel? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this UpdateDoctorProfileModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateDoctorProfileModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateDoctorProfileModelResponseCopyWith<UpdateDoctorProfileModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateDoctorProfileModelResponseCopyWith<$Res> {
  factory $UpdateDoctorProfileModelResponseCopyWith(
          UpdateDoctorProfileModelResponse value,
          $Res Function(UpdateDoctorProfileModelResponse) then) =
      _$UpdateDoctorProfileModelResponseCopyWithImpl<$Res,
          UpdateDoctorProfileModelResponse>;
  @useResult
  $Res call({DoctorModel? data, String? message});

  $DoctorModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$UpdateDoctorProfileModelResponseCopyWithImpl<$Res,
        $Val extends UpdateDoctorProfileModelResponse>
    implements $UpdateDoctorProfileModelResponseCopyWith<$Res> {
  _$UpdateDoctorProfileModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateDoctorProfileModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of UpdateDoctorProfileModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DoctorModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $DoctorModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UpdateDoctorProfileModelResponseImplCopyWith<$Res>
    implements $UpdateDoctorProfileModelResponseCopyWith<$Res> {
  factory _$$UpdateDoctorProfileModelResponseImplCopyWith(
          _$UpdateDoctorProfileModelResponseImpl value,
          $Res Function(_$UpdateDoctorProfileModelResponseImpl) then) =
      __$$UpdateDoctorProfileModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DoctorModel? data, String? message});

  @override
  $DoctorModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$UpdateDoctorProfileModelResponseImplCopyWithImpl<$Res>
    extends _$UpdateDoctorProfileModelResponseCopyWithImpl<$Res,
        _$UpdateDoctorProfileModelResponseImpl>
    implements _$$UpdateDoctorProfileModelResponseImplCopyWith<$Res> {
  __$$UpdateDoctorProfileModelResponseImplCopyWithImpl(
      _$UpdateDoctorProfileModelResponseImpl _value,
      $Res Function(_$UpdateDoctorProfileModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateDoctorProfileModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$UpdateDoctorProfileModelResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateDoctorProfileModelResponseImpl
    implements _UpdateDoctorProfileModelResponse {
  const _$UpdateDoctorProfileModelResponseImpl({this.data, this.message});

  factory _$UpdateDoctorProfileModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UpdateDoctorProfileModelResponseImplFromJson(json);

  @override
  final DoctorModel? data;
  @override
  final String? message;

  @override
  String toString() {
    return 'UpdateDoctorProfileModelResponse(data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDoctorProfileModelResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data, message);

  /// Create a copy of UpdateDoctorProfileModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDoctorProfileModelResponseImplCopyWith<
          _$UpdateDoctorProfileModelResponseImpl>
      get copyWith => __$$UpdateDoctorProfileModelResponseImplCopyWithImpl<
          _$UpdateDoctorProfileModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateDoctorProfileModelResponseImplToJson(
      this,
    );
  }
}

abstract class _UpdateDoctorProfileModelResponse
    implements UpdateDoctorProfileModelResponse {
  const factory _UpdateDoctorProfileModelResponse(
      {final DoctorModel? data,
      final String? message}) = _$UpdateDoctorProfileModelResponseImpl;

  factory _UpdateDoctorProfileModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$UpdateDoctorProfileModelResponseImpl.fromJson;

  @override
  DoctorModel? get data;
  @override
  String? get message;

  /// Create a copy of UpdateDoctorProfileModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDoctorProfileModelResponseImplCopyWith<
          _$UpdateDoctorProfileModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
