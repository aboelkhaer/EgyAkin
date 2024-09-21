// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_consultation_details_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetConsultationDetailsModelResponse
    _$GetConsultationDetailsModelResponseFromJson(Map<String, dynamic> json) {
  return _GetConsultationDetailsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetConsultationDetailsModelResponse {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_id')
  String? get doctorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_id')
  String? get patientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_message')
  String? get consultMessage => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_name')
  String? get patientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_fname')
  String? get doctorFirstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_lname')
  String? get doctorLastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_info')
  PatientHomeDataModel? get patientModel => throw _privateConstructorUsedError;
  List<DoctorsConsultationDetailsModelResponse>? get consultationDoctors =>
      throw _privateConstructorUsedError;

  /// Serializes this GetConsultationDetailsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetConsultationDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetConsultationDetailsModelResponseCopyWith<
          GetConsultationDetailsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetConsultationDetailsModelResponseCopyWith<$Res> {
  factory $GetConsultationDetailsModelResponseCopyWith(
          GetConsultationDetailsModelResponse value,
          $Res Function(GetConsultationDetailsModelResponse) then) =
      _$GetConsultationDetailsModelResponseCopyWithImpl<$Res,
          GetConsultationDetailsModelResponse>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'doctor_id') String? doctorId,
      @JsonKey(name: 'patient_id') String? patientId,
      @JsonKey(name: 'consult_message') String? consultMessage,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'patient_name') String? patientName,
      @JsonKey(name: 'doctor_fname') String? doctorFirstName,
      @JsonKey(name: 'doctor_lname') String? doctorLastName,
      @JsonKey(name: 'patient_info') PatientHomeDataModel? patientModel,
      List<DoctorsConsultationDetailsModelResponse>? consultationDoctors});

  $PatientHomeDataModelCopyWith<$Res>? get patientModel;
}

/// @nodoc
class _$GetConsultationDetailsModelResponseCopyWithImpl<$Res,
        $Val extends GetConsultationDetailsModelResponse>
    implements $GetConsultationDetailsModelResponseCopyWith<$Res> {
  _$GetConsultationDetailsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetConsultationDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? doctorId = freezed,
    Object? patientId = freezed,
    Object? consultMessage = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? patientName = freezed,
    Object? doctorFirstName = freezed,
    Object? doctorLastName = freezed,
    Object? patientModel = freezed,
    Object? consultationDoctors = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String?,
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as String?,
      consultMessage: freezed == consultMessage
          ? _value.consultMessage
          : consultMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      patientName: freezed == patientName
          ? _value.patientName
          : patientName // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorFirstName: freezed == doctorFirstName
          ? _value.doctorFirstName
          : doctorFirstName // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorLastName: freezed == doctorLastName
          ? _value.doctorLastName
          : doctorLastName // ignore: cast_nullable_to_non_nullable
              as String?,
      patientModel: freezed == patientModel
          ? _value.patientModel
          : patientModel // ignore: cast_nullable_to_non_nullable
              as PatientHomeDataModel?,
      consultationDoctors: freezed == consultationDoctors
          ? _value.consultationDoctors
          : consultationDoctors // ignore: cast_nullable_to_non_nullable
              as List<DoctorsConsultationDetailsModelResponse>?,
    ) as $Val);
  }

  /// Create a copy of GetConsultationDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PatientHomeDataModelCopyWith<$Res>? get patientModel {
    if (_value.patientModel == null) {
      return null;
    }

    return $PatientHomeDataModelCopyWith<$Res>(_value.patientModel!, (value) {
      return _then(_value.copyWith(patientModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetConsultationDetailsModelResponseImplCopyWith<$Res>
    implements $GetConsultationDetailsModelResponseCopyWith<$Res> {
  factory _$$GetConsultationDetailsModelResponseImplCopyWith(
          _$GetConsultationDetailsModelResponseImpl value,
          $Res Function(_$GetConsultationDetailsModelResponseImpl) then) =
      __$$GetConsultationDetailsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'doctor_id') String? doctorId,
      @JsonKey(name: 'patient_id') String? patientId,
      @JsonKey(name: 'consult_message') String? consultMessage,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'patient_name') String? patientName,
      @JsonKey(name: 'doctor_fname') String? doctorFirstName,
      @JsonKey(name: 'doctor_lname') String? doctorLastName,
      @JsonKey(name: 'patient_info') PatientHomeDataModel? patientModel,
      List<DoctorsConsultationDetailsModelResponse>? consultationDoctors});

  @override
  $PatientHomeDataModelCopyWith<$Res>? get patientModel;
}

/// @nodoc
class __$$GetConsultationDetailsModelResponseImplCopyWithImpl<$Res>
    extends _$GetConsultationDetailsModelResponseCopyWithImpl<$Res,
        _$GetConsultationDetailsModelResponseImpl>
    implements _$$GetConsultationDetailsModelResponseImplCopyWith<$Res> {
  __$$GetConsultationDetailsModelResponseImplCopyWithImpl(
      _$GetConsultationDetailsModelResponseImpl _value,
      $Res Function(_$GetConsultationDetailsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetConsultationDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? doctorId = freezed,
    Object? patientId = freezed,
    Object? consultMessage = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? patientName = freezed,
    Object? doctorFirstName = freezed,
    Object? doctorLastName = freezed,
    Object? patientModel = freezed,
    Object? consultationDoctors = freezed,
  }) {
    return _then(_$GetConsultationDetailsModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String?,
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as String?,
      consultMessage: freezed == consultMessage
          ? _value.consultMessage
          : consultMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      patientName: freezed == patientName
          ? _value.patientName
          : patientName // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorFirstName: freezed == doctorFirstName
          ? _value.doctorFirstName
          : doctorFirstName // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorLastName: freezed == doctorLastName
          ? _value.doctorLastName
          : doctorLastName // ignore: cast_nullable_to_non_nullable
              as String?,
      patientModel: freezed == patientModel
          ? _value.patientModel
          : patientModel // ignore: cast_nullable_to_non_nullable
              as PatientHomeDataModel?,
      consultationDoctors: freezed == consultationDoctors
          ? _value._consultationDoctors
          : consultationDoctors // ignore: cast_nullable_to_non_nullable
              as List<DoctorsConsultationDetailsModelResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetConsultationDetailsModelResponseImpl
    implements _GetConsultationDetailsModelResponse {
  const _$GetConsultationDetailsModelResponseImpl(
      {this.id,
      @JsonKey(name: 'doctor_id') this.doctorId,
      @JsonKey(name: 'patient_id') this.patientId,
      @JsonKey(name: 'consult_message') this.consultMessage,
      this.status,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'patient_name') this.patientName,
      @JsonKey(name: 'doctor_fname') this.doctorFirstName,
      @JsonKey(name: 'doctor_lname') this.doctorLastName,
      @JsonKey(name: 'patient_info') this.patientModel,
      final List<DoctorsConsultationDetailsModelResponse>? consultationDoctors})
      : _consultationDoctors = consultationDoctors;

  factory _$GetConsultationDetailsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetConsultationDetailsModelResponseImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'doctor_id')
  final String? doctorId;
  @override
  @JsonKey(name: 'patient_id')
  final String? patientId;
  @override
  @JsonKey(name: 'consult_message')
  final String? consultMessage;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey(name: 'patient_name')
  final String? patientName;
  @override
  @JsonKey(name: 'doctor_fname')
  final String? doctorFirstName;
  @override
  @JsonKey(name: 'doctor_lname')
  final String? doctorLastName;
  @override
  @JsonKey(name: 'patient_info')
  final PatientHomeDataModel? patientModel;
  final List<DoctorsConsultationDetailsModelResponse>? _consultationDoctors;
  @override
  List<DoctorsConsultationDetailsModelResponse>? get consultationDoctors {
    final value = _consultationDoctors;
    if (value == null) return null;
    if (_consultationDoctors is EqualUnmodifiableListView)
      return _consultationDoctors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetConsultationDetailsModelResponse(id: $id, doctorId: $doctorId, patientId: $patientId, consultMessage: $consultMessage, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, patientName: $patientName, doctorFirstName: $doctorFirstName, doctorLastName: $doctorLastName, patientModel: $patientModel, consultationDoctors: $consultationDoctors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetConsultationDetailsModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.consultMessage, consultMessage) ||
                other.consultMessage == consultMessage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.doctorFirstName, doctorFirstName) ||
                other.doctorFirstName == doctorFirstName) &&
            (identical(other.doctorLastName, doctorLastName) ||
                other.doctorLastName == doctorLastName) &&
            (identical(other.patientModel, patientModel) ||
                other.patientModel == patientModel) &&
            const DeepCollectionEquality()
                .equals(other._consultationDoctors, _consultationDoctors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      doctorId,
      patientId,
      consultMessage,
      status,
      createdAt,
      updatedAt,
      patientName,
      doctorFirstName,
      doctorLastName,
      patientModel,
      const DeepCollectionEquality().hash(_consultationDoctors));

  /// Create a copy of GetConsultationDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetConsultationDetailsModelResponseImplCopyWith<
          _$GetConsultationDetailsModelResponseImpl>
      get copyWith => __$$GetConsultationDetailsModelResponseImplCopyWithImpl<
          _$GetConsultationDetailsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetConsultationDetailsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetConsultationDetailsModelResponse
    implements GetConsultationDetailsModelResponse {
  const factory _GetConsultationDetailsModelResponse(
      {final String? id,
      @JsonKey(name: 'doctor_id') final String? doctorId,
      @JsonKey(name: 'patient_id') final String? patientId,
      @JsonKey(name: 'consult_message') final String? consultMessage,
      final String? status,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      @JsonKey(name: 'patient_name') final String? patientName,
      @JsonKey(name: 'doctor_fname') final String? doctorFirstName,
      @JsonKey(name: 'doctor_lname') final String? doctorLastName,
      @JsonKey(name: 'patient_info') final PatientHomeDataModel? patientModel,
      final List<DoctorsConsultationDetailsModelResponse>?
          consultationDoctors}) = _$GetConsultationDetailsModelResponseImpl;

  factory _GetConsultationDetailsModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetConsultationDetailsModelResponseImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'doctor_id')
  String? get doctorId;
  @override
  @JsonKey(name: 'patient_id')
  String? get patientId;
  @override
  @JsonKey(name: 'consult_message')
  String? get consultMessage;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(name: 'patient_name')
  String? get patientName;
  @override
  @JsonKey(name: 'doctor_fname')
  String? get doctorFirstName;
  @override
  @JsonKey(name: 'doctor_lname')
  String? get doctorLastName;
  @override
  @JsonKey(name: 'patient_info')
  PatientHomeDataModel? get patientModel;
  @override
  List<DoctorsConsultationDetailsModelResponse>? get consultationDoctors;

  /// Create a copy of GetConsultationDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetConsultationDetailsModelResponseImplCopyWith<
          _$GetConsultationDetailsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DoctorsConsultationDetailsModelResponse
    _$DoctorsConsultationDetailsModelResponseFromJson(
        Map<String, dynamic> json) {
  return _DoctorsConsultationDetailsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DoctorsConsultationDetailsModelResponse {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'consultation_id')
  String? get consultationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_doctor_id')
  String? get doctorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_doctor_fname')
  String? get doctorFirstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_doctor_lname')
  String? get doctorLastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'consult_doctor_image')
  String? get doctorImage => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;
  bool? get isVerified => throw _privateConstructorUsedError;
  String? get reply => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DoctorsConsultationDetailsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorsConsultationDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorsConsultationDetailsModelResponseCopyWith<
          DoctorsConsultationDetailsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorsConsultationDetailsModelResponseCopyWith<$Res> {
  factory $DoctorsConsultationDetailsModelResponseCopyWith(
          DoctorsConsultationDetailsModelResponse value,
          $Res Function(DoctorsConsultationDetailsModelResponse) then) =
      _$DoctorsConsultationDetailsModelResponseCopyWithImpl<$Res,
          DoctorsConsultationDetailsModelResponse>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'consultation_id') String? consultationId,
      @JsonKey(name: 'consult_doctor_id') String? doctorId,
      @JsonKey(name: 'consult_doctor_fname') String? doctorFirstName,
      @JsonKey(name: 'consult_doctor_lname') String? doctorLastName,
      @JsonKey(name: 'consult_doctor_image') String? doctorImage,
      String? workingplace,
      bool? isVerified,
      String? reply,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$DoctorsConsultationDetailsModelResponseCopyWithImpl<$Res,
        $Val extends DoctorsConsultationDetailsModelResponse>
    implements $DoctorsConsultationDetailsModelResponseCopyWith<$Res> {
  _$DoctorsConsultationDetailsModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorsConsultationDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? consultationId = freezed,
    Object? doctorId = freezed,
    Object? doctorFirstName = freezed,
    Object? doctorLastName = freezed,
    Object? doctorImage = freezed,
    Object? workingplace = freezed,
    Object? isVerified = freezed,
    Object? reply = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      consultationId: freezed == consultationId
          ? _value.consultationId
          : consultationId // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorFirstName: freezed == doctorFirstName
          ? _value.doctorFirstName
          : doctorFirstName // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorLastName: freezed == doctorLastName
          ? _value.doctorLastName
          : doctorLastName // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorImage: freezed == doctorImage
          ? _value.doctorImage
          : doctorImage // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      reply: freezed == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DoctorsConsultationDetailsModelResponseImplCopyWith<$Res>
    implements $DoctorsConsultationDetailsModelResponseCopyWith<$Res> {
  factory _$$DoctorsConsultationDetailsModelResponseImplCopyWith(
          _$DoctorsConsultationDetailsModelResponseImpl value,
          $Res Function(_$DoctorsConsultationDetailsModelResponseImpl) then) =
      __$$DoctorsConsultationDetailsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'consultation_id') String? consultationId,
      @JsonKey(name: 'consult_doctor_id') String? doctorId,
      @JsonKey(name: 'consult_doctor_fname') String? doctorFirstName,
      @JsonKey(name: 'consult_doctor_lname') String? doctorLastName,
      @JsonKey(name: 'consult_doctor_image') String? doctorImage,
      String? workingplace,
      bool? isVerified,
      String? reply,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$DoctorsConsultationDetailsModelResponseImplCopyWithImpl<$Res>
    extends _$DoctorsConsultationDetailsModelResponseCopyWithImpl<$Res,
        _$DoctorsConsultationDetailsModelResponseImpl>
    implements _$$DoctorsConsultationDetailsModelResponseImplCopyWith<$Res> {
  __$$DoctorsConsultationDetailsModelResponseImplCopyWithImpl(
      _$DoctorsConsultationDetailsModelResponseImpl _value,
      $Res Function(_$DoctorsConsultationDetailsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DoctorsConsultationDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? consultationId = freezed,
    Object? doctorId = freezed,
    Object? doctorFirstName = freezed,
    Object? doctorLastName = freezed,
    Object? doctorImage = freezed,
    Object? workingplace = freezed,
    Object? isVerified = freezed,
    Object? reply = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DoctorsConsultationDetailsModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      consultationId: freezed == consultationId
          ? _value.consultationId
          : consultationId // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorFirstName: freezed == doctorFirstName
          ? _value.doctorFirstName
          : doctorFirstName // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorLastName: freezed == doctorLastName
          ? _value.doctorLastName
          : doctorLastName // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorImage: freezed == doctorImage
          ? _value.doctorImage
          : doctorImage // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      reply: freezed == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorsConsultationDetailsModelResponseImpl
    implements _DoctorsConsultationDetailsModelResponse {
  const _$DoctorsConsultationDetailsModelResponseImpl(
      {this.id,
      @JsonKey(name: 'consultation_id') this.consultationId,
      @JsonKey(name: 'consult_doctor_id') this.doctorId,
      @JsonKey(name: 'consult_doctor_fname') this.doctorFirstName,
      @JsonKey(name: 'consult_doctor_lname') this.doctorLastName,
      @JsonKey(name: 'consult_doctor_image') this.doctorImage,
      this.workingplace,
      this.isVerified,
      this.reply,
      this.status,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$DoctorsConsultationDetailsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DoctorsConsultationDetailsModelResponseImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'consultation_id')
  final String? consultationId;
  @override
  @JsonKey(name: 'consult_doctor_id')
  final String? doctorId;
  @override
  @JsonKey(name: 'consult_doctor_fname')
  final String? doctorFirstName;
  @override
  @JsonKey(name: 'consult_doctor_lname')
  final String? doctorLastName;
  @override
  @JsonKey(name: 'consult_doctor_image')
  final String? doctorImage;
  @override
  final String? workingplace;
  @override
  final bool? isVerified;
  @override
  final String? reply;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'DoctorsConsultationDetailsModelResponse(id: $id, consultationId: $consultationId, doctorId: $doctorId, doctorFirstName: $doctorFirstName, doctorLastName: $doctorLastName, doctorImage: $doctorImage, workingplace: $workingplace, isVerified: $isVerified, reply: $reply, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorsConsultationDetailsModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.consultationId, consultationId) ||
                other.consultationId == consultationId) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.doctorFirstName, doctorFirstName) ||
                other.doctorFirstName == doctorFirstName) &&
            (identical(other.doctorLastName, doctorLastName) ||
                other.doctorLastName == doctorLastName) &&
            (identical(other.doctorImage, doctorImage) ||
                other.doctorImage == doctorImage) &&
            (identical(other.workingplace, workingplace) ||
                other.workingplace == workingplace) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.reply, reply) || other.reply == reply) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      consultationId,
      doctorId,
      doctorFirstName,
      doctorLastName,
      doctorImage,
      workingplace,
      isVerified,
      reply,
      status,
      createdAt,
      updatedAt);

  /// Create a copy of DoctorsConsultationDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorsConsultationDetailsModelResponseImplCopyWith<
          _$DoctorsConsultationDetailsModelResponseImpl>
      get copyWith =>
          __$$DoctorsConsultationDetailsModelResponseImplCopyWithImpl<
              _$DoctorsConsultationDetailsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorsConsultationDetailsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DoctorsConsultationDetailsModelResponse
    implements DoctorsConsultationDetailsModelResponse {
  const factory _DoctorsConsultationDetailsModelResponse(
          {final String? id,
          @JsonKey(name: 'consultation_id') final String? consultationId,
          @JsonKey(name: 'consult_doctor_id') final String? doctorId,
          @JsonKey(name: 'consult_doctor_fname') final String? doctorFirstName,
          @JsonKey(name: 'consult_doctor_lname') final String? doctorLastName,
          @JsonKey(name: 'consult_doctor_image') final String? doctorImage,
          final String? workingplace,
          final bool? isVerified,
          final String? reply,
          final String? status,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt}) =
      _$DoctorsConsultationDetailsModelResponseImpl;

  factory _DoctorsConsultationDetailsModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$DoctorsConsultationDetailsModelResponseImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'consultation_id')
  String? get consultationId;
  @override
  @JsonKey(name: 'consult_doctor_id')
  String? get doctorId;
  @override
  @JsonKey(name: 'consult_doctor_fname')
  String? get doctorFirstName;
  @override
  @JsonKey(name: 'consult_doctor_lname')
  String? get doctorLastName;
  @override
  @JsonKey(name: 'consult_doctor_image')
  String? get doctorImage;
  @override
  String? get workingplace;
  @override
  bool? get isVerified;
  @override
  String? get reply;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of DoctorsConsultationDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorsConsultationDetailsModelResponseImplCopyWith<
          _$DoctorsConsultationDetailsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
