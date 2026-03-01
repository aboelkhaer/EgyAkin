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
  @JsonKey(name: 'is_marked')
  bool? get isMarked => throw _privateConstructorUsedError;
  GFRModel? get gfr => throw _privateConstructorUsedError;
  List<SectionModel>? get data => throw _privateConstructorUsedError;

  /// Serializes this GetPatientSectionsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetPatientSectionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      @JsonKey(name: 'is_marked') bool? isMarked,
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

  /// Create a copy of GetPatientSectionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? submitStatus = freezed,
    Object? patientName = freezed,
    Object? doctorId = freezed,
    Object? isMarked = freezed,
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
      isMarked: freezed == isMarked
          ? _value.isMarked
          : isMarked // ignore: cast_nullable_to_non_nullable
              as bool?,
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

  /// Create a copy of GetPatientSectionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
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
      @JsonKey(name: 'is_marked') bool? isMarked,
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

  /// Create a copy of GetPatientSectionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? submitStatus = freezed,
    Object? patientName = freezed,
    Object? doctorId = freezed,
    Object? isMarked = freezed,
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
      isMarked: freezed == isMarked
          ? _value.isMarked
          : isMarked // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      @JsonKey(name: 'is_marked') this.isMarked,
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
  @JsonKey(name: 'is_marked')
  final bool? isMarked;
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
    return 'GetPatientSectionsModelResponse(value: $value, submitStatus: $submitStatus, patientName: $patientName, doctorId: $doctorId, isMarked: $isMarked, gfr: $gfr, data: $data)';
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
            (identical(other.isMarked, isMarked) ||
                other.isMarked == isMarked) &&
            (identical(other.gfr, gfr) || other.gfr == gfr) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, submitStatus, patientName,
      doctorId, isMarked, gfr, const DeepCollectionEquality().hash(_data));

  /// Create a copy of GetPatientSectionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      @JsonKey(name: 'is_marked') final bool? isMarked,
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
  @JsonKey(name: 'is_marked')
  bool? get isMarked;
  @override
  GFRModel? get gfr;
  @override
  List<SectionModel>? get data;

  /// Create a copy of GetPatientSectionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  dynamic get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_name')
  String? get sectionName => throw _privateConstructorUsedError;

  /// Serializes this SectionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      @JsonKey(name: 'updated_at') dynamic updatedAt,
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

  /// Create a copy of SectionModel
  /// with the given fields replaced by the non-null parameter values.
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
              as dynamic,
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
      @JsonKey(name: 'updated_at') dynamic updatedAt,
      @JsonKey(name: 'section_name') String? sectionName});
}

/// @nodoc
class __$$SectionModelImplCopyWithImpl<$Res>
    extends _$SectionModelCopyWithImpl<$Res, _$SectionModelImpl>
    implements _$$SectionModelImplCopyWith<$Res> {
  __$$SectionModelImplCopyWithImpl(
      _$SectionModelImpl _value, $Res Function(_$SectionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SectionModel
  /// with the given fields replaced by the non-null parameter values.
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
              as dynamic,
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
  final dynamic updatedAt;
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
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            (identical(other.sectionName, sectionName) ||
                other.sectionName == sectionName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sectionId, sectionStatus,
      const DeepCollectionEquality().hash(updatedAt), sectionName);

  /// Create a copy of SectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
          @JsonKey(name: 'updated_at') final dynamic updatedAt,
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
  dynamic get updatedAt;
  @override
  @JsonKey(name: 'section_name')
  String? get sectionName;

  /// Create a copy of SectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this GFRModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GFRModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of GFRModel
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of GFRModel
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of GFRModel
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of GFRModel
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of GFRModel
  /// with the given fields replaced by the non-null parameter values.
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ckd, sobh, mdrd);

  /// Create a copy of GFRModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of GFRModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GFRModelImplCopyWith<_$GFRModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EquationModel _$EquationModelFromJson(Map<String, dynamic> json) {
  return _EquationModel.fromJson(json);
}

/// @nodoc
mixin _$EquationModel {
  @JsonKey(name: 'current_GFR')
  EquationDataModel? get currentGFR => throw _privateConstructorUsedError;
  @JsonKey(name: 'basal_creatinine_GFR')
  EquationDataModel? get basalCreatinine => throw _privateConstructorUsedError;
  @JsonKey(name: 'creatinine_on_discharge_GFR')
  EquationDataModel? get creatinineOnDischarge =>
      throw _privateConstructorUsedError;

  /// Serializes this EquationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EquationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@JsonKey(name: 'current_GFR') EquationDataModel? currentGFR,
      @JsonKey(name: 'basal_creatinine_GFR') EquationDataModel? basalCreatinine,
      @JsonKey(name: 'creatinine_on_discharge_GFR')
      EquationDataModel? creatinineOnDischarge});

  $EquationDataModelCopyWith<$Res>? get currentGFR;
  $EquationDataModelCopyWith<$Res>? get basalCreatinine;
  $EquationDataModelCopyWith<$Res>? get creatinineOnDischarge;
}

/// @nodoc
class _$EquationModelCopyWithImpl<$Res, $Val extends EquationModel>
    implements $EquationModelCopyWith<$Res> {
  _$EquationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EquationModel
  /// with the given fields replaced by the non-null parameter values.
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
              as EquationDataModel?,
      basalCreatinine: freezed == basalCreatinine
          ? _value.basalCreatinine
          : basalCreatinine // ignore: cast_nullable_to_non_nullable
              as EquationDataModel?,
      creatinineOnDischarge: freezed == creatinineOnDischarge
          ? _value.creatinineOnDischarge
          : creatinineOnDischarge // ignore: cast_nullable_to_non_nullable
              as EquationDataModel?,
    ) as $Val);
  }

  /// Create a copy of EquationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EquationDataModelCopyWith<$Res>? get currentGFR {
    if (_value.currentGFR == null) {
      return null;
    }

    return $EquationDataModelCopyWith<$Res>(_value.currentGFR!, (value) {
      return _then(_value.copyWith(currentGFR: value) as $Val);
    });
  }

  /// Create a copy of EquationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EquationDataModelCopyWith<$Res>? get basalCreatinine {
    if (_value.basalCreatinine == null) {
      return null;
    }

    return $EquationDataModelCopyWith<$Res>(_value.basalCreatinine!, (value) {
      return _then(_value.copyWith(basalCreatinine: value) as $Val);
    });
  }

  /// Create a copy of EquationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EquationDataModelCopyWith<$Res>? get creatinineOnDischarge {
    if (_value.creatinineOnDischarge == null) {
      return null;
    }

    return $EquationDataModelCopyWith<$Res>(_value.creatinineOnDischarge!,
        (value) {
      return _then(_value.copyWith(creatinineOnDischarge: value) as $Val);
    });
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
      {@JsonKey(name: 'current_GFR') EquationDataModel? currentGFR,
      @JsonKey(name: 'basal_creatinine_GFR') EquationDataModel? basalCreatinine,
      @JsonKey(name: 'creatinine_on_discharge_GFR')
      EquationDataModel? creatinineOnDischarge});

  @override
  $EquationDataModelCopyWith<$Res>? get currentGFR;
  @override
  $EquationDataModelCopyWith<$Res>? get basalCreatinine;
  @override
  $EquationDataModelCopyWith<$Res>? get creatinineOnDischarge;
}

/// @nodoc
class __$$EquationModelImplCopyWithImpl<$Res>
    extends _$EquationModelCopyWithImpl<$Res, _$EquationModelImpl>
    implements _$$EquationModelImplCopyWith<$Res> {
  __$$EquationModelImplCopyWithImpl(
      _$EquationModelImpl _value, $Res Function(_$EquationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EquationModel
  /// with the given fields replaced by the non-null parameter values.
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
              as EquationDataModel?,
      basalCreatinine: freezed == basalCreatinine
          ? _value.basalCreatinine
          : basalCreatinine // ignore: cast_nullable_to_non_nullable
              as EquationDataModel?,
      creatinineOnDischarge: freezed == creatinineOnDischarge
          ? _value.creatinineOnDischarge
          : creatinineOnDischarge // ignore: cast_nullable_to_non_nullable
              as EquationDataModel?,
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
  final EquationDataModel? currentGFR;
  @override
  @JsonKey(name: 'basal_creatinine_GFR')
  final EquationDataModel? basalCreatinine;
  @override
  @JsonKey(name: 'creatinine_on_discharge_GFR')
  final EquationDataModel? creatinineOnDischarge;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, currentGFR, basalCreatinine, creatinineOnDischarge);

  /// Create a copy of EquationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@JsonKey(name: 'current_GFR') final EquationDataModel? currentGFR,
      @JsonKey(name: 'basal_creatinine_GFR')
      final EquationDataModel? basalCreatinine,
      @JsonKey(name: 'creatinine_on_discharge_GFR')
      final EquationDataModel? creatinineOnDischarge}) = _$EquationModelImpl;

  factory _EquationModel.fromJson(Map<String, dynamic> json) =
      _$EquationModelImpl.fromJson;

  @override
  @JsonKey(name: 'current_GFR')
  EquationDataModel? get currentGFR;
  @override
  @JsonKey(name: 'basal_creatinine_GFR')
  EquationDataModel? get basalCreatinine;
  @override
  @JsonKey(name: 'creatinine_on_discharge_GFR')
  EquationDataModel? get creatinineOnDischarge;

  /// Create a copy of EquationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EquationModelImplCopyWith<_$EquationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EquationDataModel _$EquationDataModelFromJson(Map<String, dynamic> json) {
  return _EquationDataModel.fromJson(json);
}

/// @nodoc
mixin _$EquationDataModel {
  String? get localization => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;

  /// Serializes this EquationDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EquationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EquationDataModelCopyWith<EquationDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EquationDataModelCopyWith<$Res> {
  factory $EquationDataModelCopyWith(
          EquationDataModel value, $Res Function(EquationDataModel) then) =
      _$EquationDataModelCopyWithImpl<$Res, EquationDataModel>;
  @useResult
  $Res call({String? localization, String? value});
}

/// @nodoc
class _$EquationDataModelCopyWithImpl<$Res, $Val extends EquationDataModel>
    implements $EquationDataModelCopyWith<$Res> {
  _$EquationDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EquationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localization = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      localization: freezed == localization
          ? _value.localization
          : localization // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EquationDataModelImplCopyWith<$Res>
    implements $EquationDataModelCopyWith<$Res> {
  factory _$$EquationDataModelImplCopyWith(_$EquationDataModelImpl value,
          $Res Function(_$EquationDataModelImpl) then) =
      __$$EquationDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? localization, String? value});
}

/// @nodoc
class __$$EquationDataModelImplCopyWithImpl<$Res>
    extends _$EquationDataModelCopyWithImpl<$Res, _$EquationDataModelImpl>
    implements _$$EquationDataModelImplCopyWith<$Res> {
  __$$EquationDataModelImplCopyWithImpl(_$EquationDataModelImpl _value,
      $Res Function(_$EquationDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EquationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localization = freezed,
    Object? value = freezed,
  }) {
    return _then(_$EquationDataModelImpl(
      localization: freezed == localization
          ? _value.localization
          : localization // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EquationDataModelImpl implements _EquationDataModel {
  const _$EquationDataModelImpl({this.localization, this.value});

  factory _$EquationDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EquationDataModelImplFromJson(json);

  @override
  final String? localization;
  @override
  final String? value;

  @override
  String toString() {
    return 'EquationDataModel(localization: $localization, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EquationDataModelImpl &&
            (identical(other.localization, localization) ||
                other.localization == localization) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, localization, value);

  /// Create a copy of EquationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EquationDataModelImplCopyWith<_$EquationDataModelImpl> get copyWith =>
      __$$EquationDataModelImplCopyWithImpl<_$EquationDataModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EquationDataModelImplToJson(
      this,
    );
  }
}

abstract class _EquationDataModel implements EquationDataModel {
  const factory _EquationDataModel(
      {final String? localization,
      final String? value}) = _$EquationDataModelImpl;

  factory _EquationDataModel.fromJson(Map<String, dynamic> json) =
      _$EquationDataModelImpl.fromJson;

  @override
  String? get localization;
  @override
  String? get value;

  /// Create a copy of EquationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EquationDataModelImplCopyWith<_$EquationDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
