// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_info_view_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DoctorInfoViewModelResponse _$DoctorInfoViewModelResponseFromJson(
    Map<String, dynamic> json) {
  return _DoctorInfoViewModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DoctorInfoViewModelResponse {
  @JsonKey(name: 'patient_count')
  String? get patientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'score_value')
  String? get scoreValue => throw _privateConstructorUsedError;
  DoctorModel? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoctorInfoViewModelResponseCopyWith<DoctorInfoViewModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorInfoViewModelResponseCopyWith<$Res> {
  factory $DoctorInfoViewModelResponseCopyWith(
          DoctorInfoViewModelResponse value,
          $Res Function(DoctorInfoViewModelResponse) then) =
      _$DoctorInfoViewModelResponseCopyWithImpl<$Res,
          DoctorInfoViewModelResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'patient_count') String? patientCount,
      @JsonKey(name: 'score_value') String? scoreValue,
      DoctorModel? data});

  $DoctorModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$DoctorInfoViewModelResponseCopyWithImpl<$Res,
        $Val extends DoctorInfoViewModelResponse>
    implements $DoctorInfoViewModelResponseCopyWith<$Res> {
  _$DoctorInfoViewModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientCount = freezed,
    Object? scoreValue = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      patientCount: freezed == patientCount
          ? _value.patientCount
          : patientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreValue: freezed == scoreValue
          ? _value.scoreValue
          : scoreValue // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ) as $Val);
  }

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
abstract class _$$DoctorInfoViewModelResponseImplCopyWith<$Res>
    implements $DoctorInfoViewModelResponseCopyWith<$Res> {
  factory _$$DoctorInfoViewModelResponseImplCopyWith(
          _$DoctorInfoViewModelResponseImpl value,
          $Res Function(_$DoctorInfoViewModelResponseImpl) then) =
      __$$DoctorInfoViewModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'patient_count') String? patientCount,
      @JsonKey(name: 'score_value') String? scoreValue,
      DoctorModel? data});

  @override
  $DoctorModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$DoctorInfoViewModelResponseImplCopyWithImpl<$Res>
    extends _$DoctorInfoViewModelResponseCopyWithImpl<$Res,
        _$DoctorInfoViewModelResponseImpl>
    implements _$$DoctorInfoViewModelResponseImplCopyWith<$Res> {
  __$$DoctorInfoViewModelResponseImplCopyWithImpl(
      _$DoctorInfoViewModelResponseImpl _value,
      $Res Function(_$DoctorInfoViewModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientCount = freezed,
    Object? scoreValue = freezed,
    Object? data = freezed,
  }) {
    return _then(_$DoctorInfoViewModelResponseImpl(
      patientCount: freezed == patientCount
          ? _value.patientCount
          : patientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreValue: freezed == scoreValue
          ? _value.scoreValue
          : scoreValue // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorInfoViewModelResponseImpl
    with DiagnosticableTreeMixin
    implements _DoctorInfoViewModelResponse {
  const _$DoctorInfoViewModelResponseImpl(
      {@JsonKey(name: 'patient_count') this.patientCount,
      @JsonKey(name: 'score_value') this.scoreValue,
      this.data});

  factory _$DoctorInfoViewModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DoctorInfoViewModelResponseImplFromJson(json);

  @override
  @JsonKey(name: 'patient_count')
  final String? patientCount;
  @override
  @JsonKey(name: 'score_value')
  final String? scoreValue;
  @override
  final DoctorModel? data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DoctorInfoViewModelResponse(patientCount: $patientCount, scoreValue: $scoreValue, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DoctorInfoViewModelResponse'))
      ..add(DiagnosticsProperty('patientCount', patientCount))
      ..add(DiagnosticsProperty('scoreValue', scoreValue))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorInfoViewModelResponseImpl &&
            (identical(other.patientCount, patientCount) ||
                other.patientCount == patientCount) &&
            (identical(other.scoreValue, scoreValue) ||
                other.scoreValue == scoreValue) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, patientCount, scoreValue, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorInfoViewModelResponseImplCopyWith<_$DoctorInfoViewModelResponseImpl>
      get copyWith => __$$DoctorInfoViewModelResponseImplCopyWithImpl<
          _$DoctorInfoViewModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorInfoViewModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DoctorInfoViewModelResponse
    implements DoctorInfoViewModelResponse {
  const factory _DoctorInfoViewModelResponse(
      {@JsonKey(name: 'patient_count') final String? patientCount,
      @JsonKey(name: 'score_value') final String? scoreValue,
      final DoctorModel? data}) = _$DoctorInfoViewModelResponseImpl;

  factory _DoctorInfoViewModelResponse.fromJson(Map<String, dynamic> json) =
      _$DoctorInfoViewModelResponseImpl.fromJson;

  @override
  @JsonKey(name: 'patient_count')
  String? get patientCount;
  @override
  @JsonKey(name: 'score_value')
  String? get scoreValue;
  @override
  DoctorModel? get data;
  @override
  @JsonKey(ignore: true)
  _$$DoctorInfoViewModelResponseImplCopyWith<_$DoctorInfoViewModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
