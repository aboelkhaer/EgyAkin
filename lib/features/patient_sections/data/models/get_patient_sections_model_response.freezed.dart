// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_patient_sections_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPatientSectionsModelResponse _$GetPatientSectionsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetPatientSectionsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPatientSectionsModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'submit_status')
  bool? get submitStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_name')
  String? get patientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_Id')
  String? get doctorId => throw _privateConstructorUsedError;
  GFRModel? get gfr => throw _privateConstructorUsedError;
  List<SectionModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPatientSectionsModelResponseCopyWith<GetPatientSectionsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPatientSectionsModelResponseCopyWith<$Res> {
  factory $GetPatientSectionsModelResponseCopyWith(
          GetPatientSectionsModelResponse value,
          $Res Function(GetPatientSectionsModelResponse) then) =
      _$GetPatientSectionsModelResponseCopyWithImpl<$Res,
          GetPatientSectionsModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      @JsonKey(name: 'submit_status') bool? submitStatus,
      @JsonKey(name: 'patient_name') String? patientName,
      @JsonKey(name: 'doctor_Id') String? doctorId,
      GFRModel? gfr,
      List<SectionModel>? data});

  $GFRModelCopyWith<$Res>? get gfr;
}

/// @nodoc
class _$GetPatientSectionsModelResponseCopyWithImpl<$Res,
        $Val extends GetPatientSectionsModelResponse>
    implements $GetPatientSectionsModelResponseCopyWith<$Res> {
  _$GetPatientSectionsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? submitStatus = freezed,
    Object? patientName = freezed,
    Object? doctorId = freezed,
    Object? gfr = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      submitStatus: freezed == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      patientName: freezed == patientName
          ? _value.patientName
          : patientName // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String?,
      gfr: freezed == gfr
          ? _value.gfr
          : gfr // ignore: cast_nullable_to_non_nullable
              as GFRModel?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SectionModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GFRModelCopyWith<$Res>? get gfr {
    if (_value.gfr == null) {
      return null;
    }

    return $GFRModelCopyWith<$Res>(_value.gfr!, (value) {
      return _then(_value.copyWith(gfr: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetPatientSectionsModelResponseImplCopyWith<$Res>
    implements $GetPatientSectionsModelResponseCopyWith<$Res> {
  factory _$$GetPatientSectionsModelResponseImplCopyWith(
          _$GetPatientSectionsModelResponseImpl value,
          $Res Function(_$GetPatientSectionsModelResponseImpl) then) =
      __$$GetPatientSectionsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      @JsonKey(name: 'submit_status') bool? submitStatus,
      @JsonKey(name: 'patient_name') String? patientName,
      @JsonKey(name: 'doctor_Id') String? doctorId,
      GFRModel? gfr,
      List<SectionModel>? data});

  @override
  $GFRModelCopyWith<$Res>? get gfr;
}

/// @nodoc
class __$$GetPatientSectionsModelResponseImplCopyWithImpl<$Res>
    extends _$GetPatientSectionsModelResponseCopyWithImpl<$Res,
        _$GetPatientSectionsModelResponseImpl>
    implements _$$GetPatientSectionsModelResponseImplCopyWith<$Res> {
  __$$GetPatientSectionsModelResponseImplCopyWithImpl(
      _$GetPatientSectionsModelResponseImpl _value,
      $Res Function(_$GetPatientSectionsModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? submitStatus = freezed,
    Object? patientName = freezed,
    Object? doctorId = freezed,
    Object? gfr = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetPatientSectionsModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      submitStatus: freezed == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      patientName: freezed == patientName
          ? _value.patientName
          : patientName // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String?,
      gfr: freezed == gfr
          ? _value.gfr
          : gfr // ignore: cast_nullable_to_non_nullable
              as GFRModel?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SectionModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetPatientSectionsModelResponseImpl
    implements _GetPatientSectionsModelResponse {
  const _$GetPatientSectionsModelResponseImpl(
      {this.value,
      @JsonKey(name: 'submit_status') this.submitStatus,
      @JsonKey(name: 'patient_name') this.patientName,
      @JsonKey(name: 'doctor_Id') this.doctorId,
      this.gfr,
      final List<SectionModel>? data})
      : _data = data;

  factory _$GetPatientSectionsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetPatientSectionsModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  @JsonKey(name: 'submit_status')
  final bool? submitStatus;
  @override
  @JsonKey(name: 'patient_name')
  final String? patientName;
  @override
  @JsonKey(name: 'doctor_Id')
  final String? doctorId;
  @override
  final GFRModel? gfr;
  final List<SectionModel>? _data;
  @override
  List<SectionModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetPatientSectionsModelResponse(value: $value, submitStatus: $submitStatus, patientName: $patientName, doctorId: $doctorId, gfr: $gfr, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPatientSectionsModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.submitStatus, submitStatus) ||
                other.submitStatus == submitStatus) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.gfr, gfr) || other.gfr == gfr) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, submitStatus, patientName,
      doctorId, gfr, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPatientSectionsModelResponseImplCopyWith<
          _$GetPatientSectionsModelResponseImpl>
      get copyWith => __$$GetPatientSectionsModelResponseImplCopyWithImpl<
          _$GetPatientSectionsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPatientSectionsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPatientSectionsModelResponse
    implements GetPatientSectionsModelResponse {
  const factory _GetPatientSectionsModelResponse(
      {final bool? value,
      @JsonKey(name: 'submit_status') final bool? submitStatus,
      @JsonKey(name: 'patient_name') final String? patientName,
      @JsonKey(name: 'doctor_Id') final String? doctorId,
      final GFRModel? gfr,
      final List<SectionModel>? data}) = _$GetPatientSectionsModelResponseImpl;

  factory _GetPatientSectionsModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetPatientSectionsModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  @JsonKey(name: 'submit_status')
  bool? get submitStatus;
  @override
  @JsonKey(name: 'patient_name')
  String? get patientName;
  @override
  @JsonKey(name: 'doctor_Id')
  String? get doctorId;
  @override
  GFRModel? get gfr;
  @override
  List<SectionModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$GetPatientSectionsModelResponseImplCopyWith<
          _$GetPatientSectionsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SectionModel _$SectionModelFromJson(Map<String, dynamic> json) {
  return _SectionModel.fromJson(json);
}

/// @nodoc
mixin _$SectionModel {
  @JsonKey(name: 'section_id')
  int? get sectionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_status')
  bool? get sectionStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_name')
  String? get sectionName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SectionModelCopyWith<SectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionModelCopyWith<$Res> {
  factory $SectionModelCopyWith(
          SectionModel value, $Res Function(SectionModel) then) =
      _$SectionModelCopyWithImpl<$Res, SectionModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'section_id') int? sectionId,
      @JsonKey(name: 'section_status') bool? sectionStatus,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'section_name') String? sectionName});
}

/// @nodoc
class _$SectionModelCopyWithImpl<$Res, $Val extends SectionModel>
    implements $SectionModelCopyWith<$Res> {
  _$SectionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sectionId = freezed,
    Object? sectionStatus = freezed,
    Object? updatedAt = freezed,
    Object? sectionName = freezed,
  }) {
    return _then(_value.copyWith(
      sectionId: freezed == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as int?,
      sectionStatus: freezed == sectionStatus
          ? _value.sectionStatus
          : sectionStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionName: freezed == sectionName
          ? _value.sectionName
          : sectionName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SectionModelImplCopyWith<$Res>
    implements $SectionModelCopyWith<$Res> {
  factory _$$SectionModelImplCopyWith(
          _$SectionModelImpl value, $Res Function(_$SectionModelImpl) then) =
      __$$SectionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'section_id') int? sectionId,
      @JsonKey(name: 'section_status') bool? sectionStatus,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'section_name') String? sectionName});
}

/// @nodoc
class __$$SectionModelImplCopyWithImpl<$Res>
    extends _$SectionModelCopyWithImpl<$Res, _$SectionModelImpl>
    implements _$$SectionModelImplCopyWith<$Res> {
  __$$SectionModelImplCopyWithImpl(
      _$SectionModelImpl _value, $Res Function(_$SectionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sectionId = freezed,
    Object? sectionStatus = freezed,
    Object? updatedAt = freezed,
    Object? sectionName = freezed,
  }) {
    return _then(_$SectionModelImpl(
      sectionId: freezed == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as int?,
      sectionStatus: freezed == sectionStatus
          ? _value.sectionStatus
          : sectionStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionName: freezed == sectionName
          ? _value.sectionName
          : sectionName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionModelImpl implements _SectionModel {
  const _$SectionModelImpl(
      {@JsonKey(name: 'section_id') this.sectionId,
      @JsonKey(name: 'section_status') this.sectionStatus,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'section_name') this.sectionName});

  factory _$SectionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionModelImplFromJson(json);

  @override
  @JsonKey(name: 'section_id')
  final int? sectionId;
  @override
  @JsonKey(name: 'section_status')
  final bool? sectionStatus;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey(name: 'section_name')
  final String? sectionName;

  @override
  String toString() {
    return 'SectionModel(sectionId: $sectionId, sectionStatus: $sectionStatus, updatedAt: $updatedAt, sectionName: $sectionName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionModelImpl &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.sectionStatus, sectionStatus) ||
                other.sectionStatus == sectionStatus) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.sectionName, sectionName) ||
                other.sectionName == sectionName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, sectionId, sectionStatus, updatedAt, sectionName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionModelImplCopyWith<_$SectionModelImpl> get copyWith =>
      __$$SectionModelImplCopyWithImpl<_$SectionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionModelImplToJson(
      this,
    );
  }
}

abstract class _SectionModel implements SectionModel {
  const factory _SectionModel(
          {@JsonKey(name: 'section_id') final int? sectionId,
          @JsonKey(name: 'section_status') final bool? sectionStatus,
          @JsonKey(name: 'updated_at') final String? updatedAt,
          @JsonKey(name: 'section_name') final String? sectionName}) =
      _$SectionModelImpl;

  factory _SectionModel.fromJson(Map<String, dynamic> json) =
      _$SectionModelImpl.fromJson;

  @override
  @JsonKey(name: 'section_id')
  int? get sectionId;
  @override
  @JsonKey(name: 'section_status')
  bool? get sectionStatus;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(name: 'section_name')
  String? get sectionName;
  @override
  @JsonKey(ignore: true)
  _$$SectionModelImplCopyWith<_$SectionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GFRModel _$GFRModelFromJson(Map<String, dynamic> json) {
  return _GFRModel.fromJson(json);
}

/// @nodoc
mixin _$GFRModel {
  EquationModel? get ckd => throw _privateConstructorUsedError;
  EquationModel? get sobh => throw _privateConstructorUsedError;
  EquationModel? get mdrd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GFRModelCopyWith<GFRModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GFRModelCopyWith<$Res> {
  factory $GFRModelCopyWith(GFRModel value, $Res Function(GFRModel) then) =
      _$GFRModelCopyWithImpl<$Res, GFRModel>;
  @useResult
  $Res call({EquationModel? ckd, EquationModel? sobh, EquationModel? mdrd});

  $EquationModelCopyWith<$Res>? get ckd;
  $EquationModelCopyWith<$Res>? get sobh;
  $EquationModelCopyWith<$Res>? get mdrd;
}

/// @nodoc
class _$GFRModelCopyWithImpl<$Res, $Val extends GFRModel>
    implements $GFRModelCopyWith<$Res> {
  _$GFRModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ckd = freezed,
    Object? sobh = freezed,
    Object? mdrd = freezed,
  }) {
    return _then(_value.copyWith(
      ckd: freezed == ckd
          ? _value.ckd
          : ckd // ignore: cast_nullable_to_non_nullable
              as EquationModel?,
      sobh: freezed == sobh
          ? _value.sobh
          : sobh // ignore: cast_nullable_to_non_nullable
              as EquationModel?,
      mdrd: freezed == mdrd
          ? _value.mdrd
          : mdrd // ignore: cast_nullable_to_non_nullable
              as EquationModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EquationModelCopyWith<$Res>? get ckd {
    if (_value.ckd == null) {
      return null;
    }

    return $EquationModelCopyWith<$Res>(_value.ckd!, (value) {
      return _then(_value.copyWith(ckd: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EquationModelCopyWith<$Res>? get sobh {
    if (_value.sobh == null) {
      return null;
    }

    return $EquationModelCopyWith<$Res>(_value.sobh!, (value) {
      return _then(_value.copyWith(sobh: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EquationModelCopyWith<$Res>? get mdrd {
    if (_value.mdrd == null) {
      return null;
    }

    return $EquationModelCopyWith<$Res>(_value.mdrd!, (value) {
      return _then(_value.copyWith(mdrd: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GFRModelImplCopyWith<$Res>
    implements $GFRModelCopyWith<$Res> {
  factory _$$GFRModelImplCopyWith(
          _$GFRModelImpl value, $Res Function(_$GFRModelImpl) then) =
      __$$GFRModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EquationModel? ckd, EquationModel? sobh, EquationModel? mdrd});

  @override
  $EquationModelCopyWith<$Res>? get ckd;
  @override
  $EquationModelCopyWith<$Res>? get sobh;
  @override
  $EquationModelCopyWith<$Res>? get mdrd;
}

/// @nodoc
class __$$GFRModelImplCopyWithImpl<$Res>
    extends _$GFRModelCopyWithImpl<$Res, _$GFRModelImpl>
    implements _$$GFRModelImplCopyWith<$Res> {
  __$$GFRModelImplCopyWithImpl(
      _$GFRModelImpl _value, $Res Function(_$GFRModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ckd = freezed,
    Object? sobh = freezed,
    Object? mdrd = freezed,
  }) {
    return _then(_$GFRModelImpl(
      ckd: freezed == ckd
          ? _value.ckd
          : ckd // ignore: cast_nullable_to_non_nullable
              as EquationModel?,
      sobh: freezed == sobh
          ? _value.sobh
          : sobh // ignore: cast_nullable_to_non_nullable
              as EquationModel?,
      mdrd: freezed == mdrd
          ? _value.mdrd
          : mdrd // ignore: cast_nullable_to_non_nullable
              as EquationModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GFRModelImpl implements _GFRModel {
  const _$GFRModelImpl({this.ckd, this.sobh, this.mdrd});

  factory _$GFRModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GFRModelImplFromJson(json);

  @override
  final EquationModel? ckd;
  @override
  final EquationModel? sobh;
  @override
  final EquationModel? mdrd;

  @override
  String toString() {
    return 'GFRModel(ckd: $ckd, sobh: $sobh, mdrd: $mdrd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GFRModelImpl &&
            (identical(other.ckd, ckd) || other.ckd == ckd) &&
            (identical(other.sobh, sobh) || other.sobh == sobh) &&
            (identical(other.mdrd, mdrd) || other.mdrd == mdrd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ckd, sobh, mdrd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GFRModelImplCopyWith<_$GFRModelImpl> get copyWith =>
      __$$GFRModelImplCopyWithImpl<_$GFRModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GFRModelImplToJson(
      this,
    );
  }
}

abstract class _GFRModel implements GFRModel {
  const factory _GFRModel(
      {final EquationModel? ckd,
      final EquationModel? sobh,
      final EquationModel? mdrd}) = _$GFRModelImpl;

  factory _GFRModel.fromJson(Map<String, dynamic> json) =
      _$GFRModelImpl.fromJson;

  @override
  EquationModel? get ckd;
  @override
  EquationModel? get sobh;
  @override
  EquationModel? get mdrd;
  @override
  @JsonKey(ignore: true)
  _$$GFRModelImplCopyWith<_$GFRModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EquationModel _$EquationModelFromJson(Map<String, dynamic> json) {
  return _EquationModel.fromJson(json);
}

/// @nodoc
mixin _$EquationModel {
  @JsonKey(name: 'current_GFR')
  String? get currentGFR => throw _privateConstructorUsedError;
  @JsonKey(name: 'basal_creatinine_GFR')
  String? get basalCreatinine => throw _privateConstructorUsedError;
  @JsonKey(name: 'creatinine_on_discharge_GFR')
  String? get creatinineOnDischarge => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EquationModelCopyWith<EquationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EquationModelCopyWith<$Res> {
  factory $EquationModelCopyWith(
          EquationModel value, $Res Function(EquationModel) then) =
      _$EquationModelCopyWithImpl<$Res, EquationModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'current_GFR') String? currentGFR,
      @JsonKey(name: 'basal_creatinine_GFR') String? basalCreatinine,
      @JsonKey(name: 'creatinine_on_discharge_GFR')
      String? creatinineOnDischarge});
}

/// @nodoc
class _$EquationModelCopyWithImpl<$Res, $Val extends EquationModel>
    implements $EquationModelCopyWith<$Res> {
  _$EquationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentGFR = freezed,
    Object? basalCreatinine = freezed,
    Object? creatinineOnDischarge = freezed,
  }) {
    return _then(_value.copyWith(
      currentGFR: freezed == currentGFR
          ? _value.currentGFR
          : currentGFR // ignore: cast_nullable_to_non_nullable
              as String?,
      basalCreatinine: freezed == basalCreatinine
          ? _value.basalCreatinine
          : basalCreatinine // ignore: cast_nullable_to_non_nullable
              as String?,
      creatinineOnDischarge: freezed == creatinineOnDischarge
          ? _value.creatinineOnDischarge
          : creatinineOnDischarge // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EquationModelImplCopyWith<$Res>
    implements $EquationModelCopyWith<$Res> {
  factory _$$EquationModelImplCopyWith(
          _$EquationModelImpl value, $Res Function(_$EquationModelImpl) then) =
      __$$EquationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'current_GFR') String? currentGFR,
      @JsonKey(name: 'basal_creatinine_GFR') String? basalCreatinine,
      @JsonKey(name: 'creatinine_on_discharge_GFR')
      String? creatinineOnDischarge});
}

/// @nodoc
class __$$EquationModelImplCopyWithImpl<$Res>
    extends _$EquationModelCopyWithImpl<$Res, _$EquationModelImpl>
    implements _$$EquationModelImplCopyWith<$Res> {
  __$$EquationModelImplCopyWithImpl(
      _$EquationModelImpl _value, $Res Function(_$EquationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentGFR = freezed,
    Object? basalCreatinine = freezed,
    Object? creatinineOnDischarge = freezed,
  }) {
    return _then(_$EquationModelImpl(
      currentGFR: freezed == currentGFR
          ? _value.currentGFR
          : currentGFR // ignore: cast_nullable_to_non_nullable
              as String?,
      basalCreatinine: freezed == basalCreatinine
          ? _value.basalCreatinine
          : basalCreatinine // ignore: cast_nullable_to_non_nullable
              as String?,
      creatinineOnDischarge: freezed == creatinineOnDischarge
          ? _value.creatinineOnDischarge
          : creatinineOnDischarge // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EquationModelImpl implements _EquationModel {
  const _$EquationModelImpl(
      {@JsonKey(name: 'current_GFR') this.currentGFR,
      @JsonKey(name: 'basal_creatinine_GFR') this.basalCreatinine,
      @JsonKey(name: 'creatinine_on_discharge_GFR')
      this.creatinineOnDischarge});

  factory _$EquationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EquationModelImplFromJson(json);

  @override
  @JsonKey(name: 'current_GFR')
  final String? currentGFR;
  @override
  @JsonKey(name: 'basal_creatinine_GFR')
  final String? basalCreatinine;
  @override
  @JsonKey(name: 'creatinine_on_discharge_GFR')
  final String? creatinineOnDischarge;

  @override
  String toString() {
    return 'EquationModel(currentGFR: $currentGFR, basalCreatinine: $basalCreatinine, creatinineOnDischarge: $creatinineOnDischarge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EquationModelImpl &&
            (identical(other.currentGFR, currentGFR) ||
                other.currentGFR == currentGFR) &&
            (identical(other.basalCreatinine, basalCreatinine) ||
                other.basalCreatinine == basalCreatinine) &&
            (identical(other.creatinineOnDischarge, creatinineOnDischarge) ||
                other.creatinineOnDischarge == creatinineOnDischarge));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, currentGFR, basalCreatinine, creatinineOnDischarge);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EquationModelImplCopyWith<_$EquationModelImpl> get copyWith =>
      __$$EquationModelImplCopyWithImpl<_$EquationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EquationModelImplToJson(
      this,
    );
  }
}

abstract class _EquationModel implements EquationModel {
  const factory _EquationModel(
      {@JsonKey(name: 'current_GFR') final String? currentGFR,
      @JsonKey(name: 'basal_creatinine_GFR') final String? basalCreatinine,
      @JsonKey(name: 'creatinine_on_discharge_GFR')
      final String? creatinineOnDischarge}) = _$EquationModelImpl;

  factory _EquationModel.fromJson(Map<String, dynamic> json) =
      _$EquationModelImpl.fromJson;

  @override
  @JsonKey(name: 'current_GFR')
  String? get currentGFR;
  @override
  @JsonKey(name: 'basal_creatinine_GFR')
  String? get basalCreatinine;
  @override
  @JsonKey(name: 'creatinine_on_discharge_GFR')
  String? get creatinineOnDischarge;
  @override
  @JsonKey(ignore: true)
  _$$EquationModelImplCopyWith<_$EquationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
