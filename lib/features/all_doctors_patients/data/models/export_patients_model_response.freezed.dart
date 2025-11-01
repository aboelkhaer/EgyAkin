// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_patients_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExportPatientsModelResponse _$ExportPatientsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ExportPatientsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ExportPatientsModelResponse {
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_url')
  String? get fileUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_count')
  int? get patientCount => throw _privateConstructorUsedError;

  /// Serializes this ExportPatientsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExportPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExportPatientsModelResponseCopyWith<ExportPatientsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExportPatientsModelResponseCopyWith<$Res> {
  factory $ExportPatientsModelResponseCopyWith(
          ExportPatientsModelResponse value,
          $Res Function(ExportPatientsModelResponse) then) =
      _$ExportPatientsModelResponseCopyWithImpl<$Res,
          ExportPatientsModelResponse>;
  @useResult
  $Res call(
      {String? message,
      @JsonKey(name: 'file_url') String? fileUrl,
      @JsonKey(name: 'patient_count') int? patientCount});
}

/// @nodoc
class _$ExportPatientsModelResponseCopyWithImpl<$Res,
        $Val extends ExportPatientsModelResponse>
    implements $ExportPatientsModelResponseCopyWith<$Res> {
  _$ExportPatientsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExportPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? fileUrl = freezed,
    Object? patientCount = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      patientCount: freezed == patientCount
          ? _value.patientCount
          : patientCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExportPatientsModelResponseImplCopyWith<$Res>
    implements $ExportPatientsModelResponseCopyWith<$Res> {
  factory _$$ExportPatientsModelResponseImplCopyWith(
          _$ExportPatientsModelResponseImpl value,
          $Res Function(_$ExportPatientsModelResponseImpl) then) =
      __$$ExportPatientsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message,
      @JsonKey(name: 'file_url') String? fileUrl,
      @JsonKey(name: 'patient_count') int? patientCount});
}

/// @nodoc
class __$$ExportPatientsModelResponseImplCopyWithImpl<$Res>
    extends _$ExportPatientsModelResponseCopyWithImpl<$Res,
        _$ExportPatientsModelResponseImpl>
    implements _$$ExportPatientsModelResponseImplCopyWith<$Res> {
  __$$ExportPatientsModelResponseImplCopyWithImpl(
      _$ExportPatientsModelResponseImpl _value,
      $Res Function(_$ExportPatientsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExportPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? fileUrl = freezed,
    Object? patientCount = freezed,
  }) {
    return _then(_$ExportPatientsModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      patientCount: freezed == patientCount
          ? _value.patientCount
          : patientCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportPatientsModelResponseImpl
    implements _ExportPatientsModelResponse {
  const _$ExportPatientsModelResponseImpl(
      {this.message,
      @JsonKey(name: 'file_url') this.fileUrl,
      @JsonKey(name: 'patient_count') this.patientCount});

  factory _$ExportPatientsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExportPatientsModelResponseImplFromJson(json);

  @override
  final String? message;
  @override
  @JsonKey(name: 'file_url')
  final String? fileUrl;
  @override
  @JsonKey(name: 'patient_count')
  final int? patientCount;

  @override
  String toString() {
    return 'ExportPatientsModelResponse(message: $message, fileUrl: $fileUrl, patientCount: $patientCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportPatientsModelResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.patientCount, patientCount) ||
                other.patientCount == patientCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, fileUrl, patientCount);

  /// Create a copy of ExportPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportPatientsModelResponseImplCopyWith<_$ExportPatientsModelResponseImpl>
      get copyWith => __$$ExportPatientsModelResponseImplCopyWithImpl<
          _$ExportPatientsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportPatientsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ExportPatientsModelResponse
    implements ExportPatientsModelResponse {
  const factory _ExportPatientsModelResponse(
          {final String? message,
          @JsonKey(name: 'file_url') final String? fileUrl,
          @JsonKey(name: 'patient_count') final int? patientCount}) =
      _$ExportPatientsModelResponseImpl;

  factory _ExportPatientsModelResponse.fromJson(Map<String, dynamic> json) =
      _$ExportPatientsModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(name: 'file_url')
  String? get fileUrl;
  @override
  @JsonKey(name: 'patient_count')
  int? get patientCount;

  /// Create a copy of ExportPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExportPatientsModelResponseImplCopyWith<_$ExportPatientsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
