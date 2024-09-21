// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'download_patient_report_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DownloadPatientReportModelResponse _$DownloadPatientReportModelResponseFromJson(
    Map<String, dynamic> json) {
  return _DownloadPatientReportModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DownloadPatientReportModelResponse {
  @JsonKey(name: 'pdf_url')
  String? get pdfUrl => throw _privateConstructorUsedError;

  /// Serializes this DownloadPatientReportModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DownloadPatientReportModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DownloadPatientReportModelResponseCopyWith<
          DownloadPatientReportModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadPatientReportModelResponseCopyWith<$Res> {
  factory $DownloadPatientReportModelResponseCopyWith(
          DownloadPatientReportModelResponse value,
          $Res Function(DownloadPatientReportModelResponse) then) =
      _$DownloadPatientReportModelResponseCopyWithImpl<$Res,
          DownloadPatientReportModelResponse>;
  @useResult
  $Res call({@JsonKey(name: 'pdf_url') String? pdfUrl});
}

/// @nodoc
class _$DownloadPatientReportModelResponseCopyWithImpl<$Res,
        $Val extends DownloadPatientReportModelResponse>
    implements $DownloadPatientReportModelResponseCopyWith<$Res> {
  _$DownloadPatientReportModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DownloadPatientReportModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pdfUrl = freezed,
  }) {
    return _then(_value.copyWith(
      pdfUrl: freezed == pdfUrl
          ? _value.pdfUrl
          : pdfUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DownloadPatientReportModelResponseImplCopyWith<$Res>
    implements $DownloadPatientReportModelResponseCopyWith<$Res> {
  factory _$$DownloadPatientReportModelResponseImplCopyWith(
          _$DownloadPatientReportModelResponseImpl value,
          $Res Function(_$DownloadPatientReportModelResponseImpl) then) =
      __$$DownloadPatientReportModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'pdf_url') String? pdfUrl});
}

/// @nodoc
class __$$DownloadPatientReportModelResponseImplCopyWithImpl<$Res>
    extends _$DownloadPatientReportModelResponseCopyWithImpl<$Res,
        _$DownloadPatientReportModelResponseImpl>
    implements _$$DownloadPatientReportModelResponseImplCopyWith<$Res> {
  __$$DownloadPatientReportModelResponseImplCopyWithImpl(
      _$DownloadPatientReportModelResponseImpl _value,
      $Res Function(_$DownloadPatientReportModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DownloadPatientReportModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pdfUrl = freezed,
  }) {
    return _then(_$DownloadPatientReportModelResponseImpl(
      pdfUrl: freezed == pdfUrl
          ? _value.pdfUrl
          : pdfUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DownloadPatientReportModelResponseImpl
    implements _DownloadPatientReportModelResponse {
  const _$DownloadPatientReportModelResponseImpl(
      {@JsonKey(name: 'pdf_url') this.pdfUrl});

  factory _$DownloadPatientReportModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DownloadPatientReportModelResponseImplFromJson(json);

  @override
  @JsonKey(name: 'pdf_url')
  final String? pdfUrl;

  @override
  String toString() {
    return 'DownloadPatientReportModelResponse(pdfUrl: $pdfUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadPatientReportModelResponseImpl &&
            (identical(other.pdfUrl, pdfUrl) || other.pdfUrl == pdfUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pdfUrl);

  /// Create a copy of DownloadPatientReportModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DownloadPatientReportModelResponseImplCopyWith<
          _$DownloadPatientReportModelResponseImpl>
      get copyWith => __$$DownloadPatientReportModelResponseImplCopyWithImpl<
          _$DownloadPatientReportModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DownloadPatientReportModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DownloadPatientReportModelResponse
    implements DownloadPatientReportModelResponse {
  const factory _DownloadPatientReportModelResponse(
          {@JsonKey(name: 'pdf_url') final String? pdfUrl}) =
      _$DownloadPatientReportModelResponseImpl;

  factory _DownloadPatientReportModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$DownloadPatientReportModelResponseImpl.fromJson;

  @override
  @JsonKey(name: 'pdf_url')
  String? get pdfUrl;

  /// Create a copy of DownloadPatientReportModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DownloadPatientReportModelResponseImplCopyWith<
          _$DownloadPatientReportModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
