// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_outcome_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetOutcomeModelResponse _$GetOutcomeModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetOutcomeModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetOutcomeModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  List<QuestionModel>? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'Submitter')
  OutcomeSubmitterModel? get submitter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetOutcomeModelResponseCopyWith<GetOutcomeModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetOutcomeModelResponseCopyWith<$Res> {
  factory $GetOutcomeModelResponseCopyWith(GetOutcomeModelResponse value,
          $Res Function(GetOutcomeModelResponse) then) =
      _$GetOutcomeModelResponseCopyWithImpl<$Res, GetOutcomeModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      List<QuestionModel>? data,
      @JsonKey(name: 'Submitter') OutcomeSubmitterModel? submitter});

  $OutcomeSubmitterModelCopyWith<$Res>? get submitter;
}

/// @nodoc
class _$GetOutcomeModelResponseCopyWithImpl<$Res,
        $Val extends GetOutcomeModelResponse>
    implements $GetOutcomeModelResponseCopyWith<$Res> {
  _$GetOutcomeModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
    Object? submitter = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>?,
      submitter: freezed == submitter
          ? _value.submitter
          : submitter // ignore: cast_nullable_to_non_nullable
              as OutcomeSubmitterModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OutcomeSubmitterModelCopyWith<$Res>? get submitter {
    if (_value.submitter == null) {
      return null;
    }

    return $OutcomeSubmitterModelCopyWith<$Res>(_value.submitter!, (value) {
      return _then(_value.copyWith(submitter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetOutcomeModelResponseImplCopyWith<$Res>
    implements $GetOutcomeModelResponseCopyWith<$Res> {
  factory _$$GetOutcomeModelResponseImplCopyWith(
          _$GetOutcomeModelResponseImpl value,
          $Res Function(_$GetOutcomeModelResponseImpl) then) =
      __$$GetOutcomeModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      List<QuestionModel>? data,
      @JsonKey(name: 'Submitter') OutcomeSubmitterModel? submitter});

  @override
  $OutcomeSubmitterModelCopyWith<$Res>? get submitter;
}

/// @nodoc
class __$$GetOutcomeModelResponseImplCopyWithImpl<$Res>
    extends _$GetOutcomeModelResponseCopyWithImpl<$Res,
        _$GetOutcomeModelResponseImpl>
    implements _$$GetOutcomeModelResponseImplCopyWith<$Res> {
  __$$GetOutcomeModelResponseImplCopyWithImpl(
      _$GetOutcomeModelResponseImpl _value,
      $Res Function(_$GetOutcomeModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
    Object? submitter = freezed,
  }) {
    return _then(_$GetOutcomeModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>?,
      submitter: freezed == submitter
          ? _value.submitter
          : submitter // ignore: cast_nullable_to_non_nullable
              as OutcomeSubmitterModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetOutcomeModelResponseImpl
    with DiagnosticableTreeMixin
    implements _GetOutcomeModelResponse {
  const _$GetOutcomeModelResponseImpl(
      {this.value,
      final List<QuestionModel>? data,
      @JsonKey(name: 'Submitter') this.submitter})
      : _data = data;

  factory _$GetOutcomeModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetOutcomeModelResponseImplFromJson(json);

  @override
  final bool? value;
  final List<QuestionModel>? _data;
  @override
  List<QuestionModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'Submitter')
  final OutcomeSubmitterModel? submitter;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetOutcomeModelResponse(value: $value, data: $data, submitter: $submitter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GetOutcomeModelResponse'))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('submitter', submitter));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOutcomeModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.submitter, submitter) ||
                other.submitter == submitter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value,
      const DeepCollectionEquality().hash(_data), submitter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOutcomeModelResponseImplCopyWith<_$GetOutcomeModelResponseImpl>
      get copyWith => __$$GetOutcomeModelResponseImplCopyWithImpl<
          _$GetOutcomeModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetOutcomeModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetOutcomeModelResponse implements GetOutcomeModelResponse {
  const factory _GetOutcomeModelResponse(
          {final bool? value,
          final List<QuestionModel>? data,
          @JsonKey(name: 'Submitter') final OutcomeSubmitterModel? submitter}) =
      _$GetOutcomeModelResponseImpl;

  factory _GetOutcomeModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetOutcomeModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  List<QuestionModel>? get data;
  @override
  @JsonKey(name: 'Submitter')
  OutcomeSubmitterModel? get submitter;
  @override
  @JsonKey(ignore: true)
  _$$GetOutcomeModelResponseImplCopyWith<_$GetOutcomeModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetOutcomeDataModelResponse _$GetOutcomeDataModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetOutcomeDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetOutcomeDataModelResponse {
  @JsonKey(name: 'outcome_of_the_patient')
  String? get outcomeOfThePatient => throw _privateConstructorUsedError;
  @JsonKey(name: 'creatinine_on_discharge')
  String? get creatinineOnDischarge => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_of_admission')
  String? get duration => throw _privateConstructorUsedError;
  @JsonKey(name: 'final_status')
  String? get finalSubmit => throw _privateConstructorUsedError;
  @JsonKey(name: 'other')
  String? get other => throw _privateConstructorUsedError;
  @JsonKey(name: 'update_at')
  String? get updateAt => throw _privateConstructorUsedError;
  DoctorModel? get doctor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetOutcomeDataModelResponseCopyWith<GetOutcomeDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetOutcomeDataModelResponseCopyWith<$Res> {
  factory $GetOutcomeDataModelResponseCopyWith(
          GetOutcomeDataModelResponse value,
          $Res Function(GetOutcomeDataModelResponse) then) =
      _$GetOutcomeDataModelResponseCopyWithImpl<$Res,
          GetOutcomeDataModelResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'outcome_of_the_patient') String? outcomeOfThePatient,
      @JsonKey(name: 'creatinine_on_discharge') String? creatinineOnDischarge,
      @JsonKey(name: 'duration_of_admission') String? duration,
      @JsonKey(name: 'final_status') String? finalSubmit,
      @JsonKey(name: 'other') String? other,
      @JsonKey(name: 'update_at') String? updateAt,
      DoctorModel? doctor});

  $DoctorModelCopyWith<$Res>? get doctor;
}

/// @nodoc
class _$GetOutcomeDataModelResponseCopyWithImpl<$Res,
        $Val extends GetOutcomeDataModelResponse>
    implements $GetOutcomeDataModelResponseCopyWith<$Res> {
  _$GetOutcomeDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outcomeOfThePatient = freezed,
    Object? creatinineOnDischarge = freezed,
    Object? duration = freezed,
    Object? finalSubmit = freezed,
    Object? other = freezed,
    Object? updateAt = freezed,
    Object? doctor = freezed,
  }) {
    return _then(_value.copyWith(
      outcomeOfThePatient: freezed == outcomeOfThePatient
          ? _value.outcomeOfThePatient
          : outcomeOfThePatient // ignore: cast_nullable_to_non_nullable
              as String?,
      creatinineOnDischarge: freezed == creatinineOnDischarge
          ? _value.creatinineOnDischarge
          : creatinineOnDischarge // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      finalSubmit: freezed == finalSubmit
          ? _value.finalSubmit
          : finalSubmit // ignore: cast_nullable_to_non_nullable
              as String?,
      other: freezed == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as String?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as String?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DoctorModelCopyWith<$Res>? get doctor {
    if (_value.doctor == null) {
      return null;
    }

    return $DoctorModelCopyWith<$Res>(_value.doctor!, (value) {
      return _then(_value.copyWith(doctor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetOutcomeDataModelResponseImplCopyWith<$Res>
    implements $GetOutcomeDataModelResponseCopyWith<$Res> {
  factory _$$GetOutcomeDataModelResponseImplCopyWith(
          _$GetOutcomeDataModelResponseImpl value,
          $Res Function(_$GetOutcomeDataModelResponseImpl) then) =
      __$$GetOutcomeDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'outcome_of_the_patient') String? outcomeOfThePatient,
      @JsonKey(name: 'creatinine_on_discharge') String? creatinineOnDischarge,
      @JsonKey(name: 'duration_of_admission') String? duration,
      @JsonKey(name: 'final_status') String? finalSubmit,
      @JsonKey(name: 'other') String? other,
      @JsonKey(name: 'update_at') String? updateAt,
      DoctorModel? doctor});

  @override
  $DoctorModelCopyWith<$Res>? get doctor;
}

/// @nodoc
class __$$GetOutcomeDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetOutcomeDataModelResponseCopyWithImpl<$Res,
        _$GetOutcomeDataModelResponseImpl>
    implements _$$GetOutcomeDataModelResponseImplCopyWith<$Res> {
  __$$GetOutcomeDataModelResponseImplCopyWithImpl(
      _$GetOutcomeDataModelResponseImpl _value,
      $Res Function(_$GetOutcomeDataModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outcomeOfThePatient = freezed,
    Object? creatinineOnDischarge = freezed,
    Object? duration = freezed,
    Object? finalSubmit = freezed,
    Object? other = freezed,
    Object? updateAt = freezed,
    Object? doctor = freezed,
  }) {
    return _then(_$GetOutcomeDataModelResponseImpl(
      outcomeOfThePatient: freezed == outcomeOfThePatient
          ? _value.outcomeOfThePatient
          : outcomeOfThePatient // ignore: cast_nullable_to_non_nullable
              as String?,
      creatinineOnDischarge: freezed == creatinineOnDischarge
          ? _value.creatinineOnDischarge
          : creatinineOnDischarge // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      finalSubmit: freezed == finalSubmit
          ? _value.finalSubmit
          : finalSubmit // ignore: cast_nullable_to_non_nullable
              as String?,
      other: freezed == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as String?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as String?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetOutcomeDataModelResponseImpl
    with DiagnosticableTreeMixin
    implements _GetOutcomeDataModelResponse {
  const _$GetOutcomeDataModelResponseImpl(
      {@JsonKey(name: 'outcome_of_the_patient') this.outcomeOfThePatient,
      @JsonKey(name: 'creatinine_on_discharge') this.creatinineOnDischarge,
      @JsonKey(name: 'duration_of_admission') this.duration,
      @JsonKey(name: 'final_status') this.finalSubmit,
      @JsonKey(name: 'other') this.other,
      @JsonKey(name: 'update_at') this.updateAt,
      this.doctor});

  factory _$GetOutcomeDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetOutcomeDataModelResponseImplFromJson(json);

  @override
  @JsonKey(name: 'outcome_of_the_patient')
  final String? outcomeOfThePatient;
  @override
  @JsonKey(name: 'creatinine_on_discharge')
  final String? creatinineOnDischarge;
  @override
  @JsonKey(name: 'duration_of_admission')
  final String? duration;
  @override
  @JsonKey(name: 'final_status')
  final String? finalSubmit;
  @override
  @JsonKey(name: 'other')
  final String? other;
  @override
  @JsonKey(name: 'update_at')
  final String? updateAt;
  @override
  final DoctorModel? doctor;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetOutcomeDataModelResponse(outcomeOfThePatient: $outcomeOfThePatient, creatinineOnDischarge: $creatinineOnDischarge, duration: $duration, finalSubmit: $finalSubmit, other: $other, updateAt: $updateAt, doctor: $doctor)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GetOutcomeDataModelResponse'))
      ..add(DiagnosticsProperty('outcomeOfThePatient', outcomeOfThePatient))
      ..add(DiagnosticsProperty('creatinineOnDischarge', creatinineOnDischarge))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('finalSubmit', finalSubmit))
      ..add(DiagnosticsProperty('other', other))
      ..add(DiagnosticsProperty('updateAt', updateAt))
      ..add(DiagnosticsProperty('doctor', doctor));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOutcomeDataModelResponseImpl &&
            (identical(other.outcomeOfThePatient, outcomeOfThePatient) ||
                other.outcomeOfThePatient == outcomeOfThePatient) &&
            (identical(other.creatinineOnDischarge, creatinineOnDischarge) ||
                other.creatinineOnDischarge == creatinineOnDischarge) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.finalSubmit, finalSubmit) ||
                other.finalSubmit == finalSubmit) &&
            (identical(other.other, this.other) || other.other == this.other) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt) &&
            (identical(other.doctor, doctor) || other.doctor == doctor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, outcomeOfThePatient,
      creatinineOnDischarge, duration, finalSubmit, other, updateAt, doctor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOutcomeDataModelResponseImplCopyWith<_$GetOutcomeDataModelResponseImpl>
      get copyWith => __$$GetOutcomeDataModelResponseImplCopyWithImpl<
          _$GetOutcomeDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetOutcomeDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetOutcomeDataModelResponse
    implements GetOutcomeDataModelResponse {
  const factory _GetOutcomeDataModelResponse(
      {@JsonKey(name: 'outcome_of_the_patient')
      final String? outcomeOfThePatient,
      @JsonKey(name: 'creatinine_on_discharge')
      final String? creatinineOnDischarge,
      @JsonKey(name: 'duration_of_admission') final String? duration,
      @JsonKey(name: 'final_status') final String? finalSubmit,
      @JsonKey(name: 'other') final String? other,
      @JsonKey(name: 'update_at') final String? updateAt,
      final DoctorModel? doctor}) = _$GetOutcomeDataModelResponseImpl;

  factory _GetOutcomeDataModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetOutcomeDataModelResponseImpl.fromJson;

  @override
  @JsonKey(name: 'outcome_of_the_patient')
  String? get outcomeOfThePatient;
  @override
  @JsonKey(name: 'creatinine_on_discharge')
  String? get creatinineOnDischarge;
  @override
  @JsonKey(name: 'duration_of_admission')
  String? get duration;
  @override
  @JsonKey(name: 'final_status')
  String? get finalSubmit;
  @override
  @JsonKey(name: 'other')
  String? get other;
  @override
  @JsonKey(name: 'update_at')
  String? get updateAt;
  @override
  DoctorModel? get doctor;
  @override
  @JsonKey(ignore: true)
  _$$GetOutcomeDataModelResponseImplCopyWith<_$GetOutcomeDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OutcomeSubmitterModel _$OutcomeSubmitterModelFromJson(
    Map<String, dynamic> json) {
  return _OutcomeSubmitterModel.fromJson(json);
}

/// @nodoc
mixin _$OutcomeSubmitterModel {
  String? get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutcomeSubmitterModelCopyWith<OutcomeSubmitterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutcomeSubmitterModelCopyWith<$Res> {
  factory $OutcomeSubmitterModelCopyWith(OutcomeSubmitterModel value,
          $Res Function(OutcomeSubmitterModel) then) =
      _$OutcomeSubmitterModelCopyWithImpl<$Res, OutcomeSubmitterModel>;
  @useResult
  $Res call({String? name, String? image});
}

/// @nodoc
class _$OutcomeSubmitterModelCopyWithImpl<$Res,
        $Val extends OutcomeSubmitterModel>
    implements $OutcomeSubmitterModelCopyWith<$Res> {
  _$OutcomeSubmitterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutcomeSubmitterModelImplCopyWith<$Res>
    implements $OutcomeSubmitterModelCopyWith<$Res> {
  factory _$$OutcomeSubmitterModelImplCopyWith(
          _$OutcomeSubmitterModelImpl value,
          $Res Function(_$OutcomeSubmitterModelImpl) then) =
      __$$OutcomeSubmitterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? image});
}

/// @nodoc
class __$$OutcomeSubmitterModelImplCopyWithImpl<$Res>
    extends _$OutcomeSubmitterModelCopyWithImpl<$Res,
        _$OutcomeSubmitterModelImpl>
    implements _$$OutcomeSubmitterModelImplCopyWith<$Res> {
  __$$OutcomeSubmitterModelImplCopyWithImpl(_$OutcomeSubmitterModelImpl _value,
      $Res Function(_$OutcomeSubmitterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? image = freezed,
  }) {
    return _then(_$OutcomeSubmitterModelImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutcomeSubmitterModelImpl
    with DiagnosticableTreeMixin
    implements _OutcomeSubmitterModel {
  const _$OutcomeSubmitterModelImpl({this.name, this.image});

  factory _$OutcomeSubmitterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutcomeSubmitterModelImplFromJson(json);

  @override
  final String? name;
  @override
  final String? image;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OutcomeSubmitterModel(name: $name, image: $image)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OutcomeSubmitterModel'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('image', image));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutcomeSubmitterModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutcomeSubmitterModelImplCopyWith<_$OutcomeSubmitterModelImpl>
      get copyWith => __$$OutcomeSubmitterModelImplCopyWithImpl<
          _$OutcomeSubmitterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutcomeSubmitterModelImplToJson(
      this,
    );
  }
}

abstract class _OutcomeSubmitterModel implements OutcomeSubmitterModel {
  const factory _OutcomeSubmitterModel(
      {final String? name, final String? image}) = _$OutcomeSubmitterModelImpl;

  factory _OutcomeSubmitterModel.fromJson(Map<String, dynamic> json) =
      _$OutcomeSubmitterModelImpl.fromJson;

  @override
  String? get name;
  @override
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$OutcomeSubmitterModelImplCopyWith<_$OutcomeSubmitterModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
