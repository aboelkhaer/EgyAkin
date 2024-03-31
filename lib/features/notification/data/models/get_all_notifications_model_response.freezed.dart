// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_all_notifications_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetAllNotificationsModelResponse _$GetAllNotificationsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetAllNotificationsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAllNotificationsModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get unreadCount => throw _privateConstructorUsedError;
  List<NotificationsModel>? get todayRecords =>
      throw _privateConstructorUsedError;
  List<NotificationsModel>? get recentRecords =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetAllNotificationsModelResponseCopyWith<GetAllNotificationsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAllNotificationsModelResponseCopyWith<$Res> {
  factory $GetAllNotificationsModelResponseCopyWith(
          GetAllNotificationsModelResponse value,
          $Res Function(GetAllNotificationsModelResponse) then) =
      _$GetAllNotificationsModelResponseCopyWithImpl<$Res,
          GetAllNotificationsModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      String? unreadCount,
      List<NotificationsModel>? todayRecords,
      List<NotificationsModel>? recentRecords});
}

/// @nodoc
class _$GetAllNotificationsModelResponseCopyWithImpl<$Res,
        $Val extends GetAllNotificationsModelResponse>
    implements $GetAllNotificationsModelResponseCopyWith<$Res> {
  _$GetAllNotificationsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? unreadCount = freezed,
    Object? todayRecords = freezed,
    Object? recentRecords = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as String?,
      todayRecords: freezed == todayRecords
          ? _value.todayRecords
          : todayRecords // ignore: cast_nullable_to_non_nullable
              as List<NotificationsModel>?,
      recentRecords: freezed == recentRecords
          ? _value.recentRecords
          : recentRecords // ignore: cast_nullable_to_non_nullable
              as List<NotificationsModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetAllNotificationsModelResponseImplCopyWith<$Res>
    implements $GetAllNotificationsModelResponseCopyWith<$Res> {
  factory _$$GetAllNotificationsModelResponseImplCopyWith(
          _$GetAllNotificationsModelResponseImpl value,
          $Res Function(_$GetAllNotificationsModelResponseImpl) then) =
      __$$GetAllNotificationsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      String? unreadCount,
      List<NotificationsModel>? todayRecords,
      List<NotificationsModel>? recentRecords});
}

/// @nodoc
class __$$GetAllNotificationsModelResponseImplCopyWithImpl<$Res>
    extends _$GetAllNotificationsModelResponseCopyWithImpl<$Res,
        _$GetAllNotificationsModelResponseImpl>
    implements _$$GetAllNotificationsModelResponseImplCopyWith<$Res> {
  __$$GetAllNotificationsModelResponseImplCopyWithImpl(
      _$GetAllNotificationsModelResponseImpl _value,
      $Res Function(_$GetAllNotificationsModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? unreadCount = freezed,
    Object? todayRecords = freezed,
    Object? recentRecords = freezed,
  }) {
    return _then(_$GetAllNotificationsModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as String?,
      todayRecords: freezed == todayRecords
          ? _value._todayRecords
          : todayRecords // ignore: cast_nullable_to_non_nullable
              as List<NotificationsModel>?,
      recentRecords: freezed == recentRecords
          ? _value._recentRecords
          : recentRecords // ignore: cast_nullable_to_non_nullable
              as List<NotificationsModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAllNotificationsModelResponseImpl
    implements _GetAllNotificationsModelResponse {
  const _$GetAllNotificationsModelResponseImpl(
      {this.value,
      this.unreadCount,
      final List<NotificationsModel>? todayRecords,
      final List<NotificationsModel>? recentRecords})
      : _todayRecords = todayRecords,
        _recentRecords = recentRecords;

  factory _$GetAllNotificationsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAllNotificationsModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? unreadCount;
  final List<NotificationsModel>? _todayRecords;
  @override
  List<NotificationsModel>? get todayRecords {
    final value = _todayRecords;
    if (value == null) return null;
    if (_todayRecords is EqualUnmodifiableListView) return _todayRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<NotificationsModel>? _recentRecords;
  @override
  List<NotificationsModel>? get recentRecords {
    final value = _recentRecords;
    if (value == null) return null;
    if (_recentRecords is EqualUnmodifiableListView) return _recentRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetAllNotificationsModelResponse(value: $value, unreadCount: $unreadCount, todayRecords: $todayRecords, recentRecords: $recentRecords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAllNotificationsModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            const DeepCollectionEquality()
                .equals(other._todayRecords, _todayRecords) &&
            const DeepCollectionEquality()
                .equals(other._recentRecords, _recentRecords));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      value,
      unreadCount,
      const DeepCollectionEquality().hash(_todayRecords),
      const DeepCollectionEquality().hash(_recentRecords));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAllNotificationsModelResponseImplCopyWith<
          _$GetAllNotificationsModelResponseImpl>
      get copyWith => __$$GetAllNotificationsModelResponseImplCopyWithImpl<
          _$GetAllNotificationsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAllNotificationsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetAllNotificationsModelResponse
    implements GetAllNotificationsModelResponse {
  const factory _GetAllNotificationsModelResponse(
          {final bool? value,
          final String? unreadCount,
          final List<NotificationsModel>? todayRecords,
          final List<NotificationsModel>? recentRecords}) =
      _$GetAllNotificationsModelResponseImpl;

  factory _GetAllNotificationsModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetAllNotificationsModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get unreadCount;
  @override
  List<NotificationsModel>? get todayRecords;
  @override
  List<NotificationsModel>? get recentRecords;
  @override
  @JsonKey(ignore: true)
  _$$GetAllNotificationsModelResponseImplCopyWith<
          _$GetAllNotificationsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationsModel _$NotificationsModelFromJson(Map<String, dynamic> json) {
  return _NotificationsModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationsModel {
  int? get id => throw _privateConstructorUsedError;
  bool? get read => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  PatientNotificationModel? get patient => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationsModelCopyWith<NotificationsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsModelCopyWith<$Res> {
  factory $NotificationsModelCopyWith(
          NotificationsModel value, $Res Function(NotificationsModel) then) =
      _$NotificationsModelCopyWithImpl<$Res, NotificationsModel>;
  @useResult
  $Res call(
      {int? id,
      bool? read,
      String? type,
      @JsonKey(name: 'created_at') String? createdAt,
      PatientNotificationModel? patient});

  $PatientNotificationModelCopyWith<$Res>? get patient;
}

/// @nodoc
class _$NotificationsModelCopyWithImpl<$Res, $Val extends NotificationsModel>
    implements $NotificationsModelCopyWith<$Res> {
  _$NotificationsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? read = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? patient = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as PatientNotificationModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PatientNotificationModelCopyWith<$Res>? get patient {
    if (_value.patient == null) {
      return null;
    }

    return $PatientNotificationModelCopyWith<$Res>(_value.patient!, (value) {
      return _then(_value.copyWith(patient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationsModelImplCopyWith<$Res>
    implements $NotificationsModelCopyWith<$Res> {
  factory _$$NotificationsModelImplCopyWith(_$NotificationsModelImpl value,
          $Res Function(_$NotificationsModelImpl) then) =
      __$$NotificationsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      bool? read,
      String? type,
      @JsonKey(name: 'created_at') String? createdAt,
      PatientNotificationModel? patient});

  @override
  $PatientNotificationModelCopyWith<$Res>? get patient;
}

/// @nodoc
class __$$NotificationsModelImplCopyWithImpl<$Res>
    extends _$NotificationsModelCopyWithImpl<$Res, _$NotificationsModelImpl>
    implements _$$NotificationsModelImplCopyWith<$Res> {
  __$$NotificationsModelImplCopyWithImpl(_$NotificationsModelImpl _value,
      $Res Function(_$NotificationsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? read = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? patient = freezed,
  }) {
    return _then(_$NotificationsModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as PatientNotificationModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationsModelImpl implements _NotificationsModel {
  const _$NotificationsModelImpl(
      {this.id,
      this.read,
      this.type,
      @JsonKey(name: 'created_at') this.createdAt,
      this.patient});

  factory _$NotificationsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationsModelImplFromJson(json);

  @override
  final int? id;
  @override
  final bool? read;
  @override
  final String? type;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  final PatientNotificationModel? patient;

  @override
  String toString() {
    return 'NotificationsModel(id: $id, read: $read, type: $type, createdAt: $createdAt, patient: $patient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.patient, patient) || other.patient == patient));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, read, type, createdAt, patient);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsModelImplCopyWith<_$NotificationsModelImpl> get copyWith =>
      __$$NotificationsModelImplCopyWithImpl<_$NotificationsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationsModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationsModel implements NotificationsModel {
  const factory _NotificationsModel(
      {final int? id,
      final bool? read,
      final String? type,
      @JsonKey(name: 'created_at') final String? createdAt,
      final PatientNotificationModel? patient}) = _$NotificationsModelImpl;

  factory _NotificationsModel.fromJson(Map<String, dynamic> json) =
      _$NotificationsModelImpl.fromJson;

  @override
  int? get id;
  @override
  bool? get read;
  @override
  String? get type;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  PatientNotificationModel? get patient;
  @override
  @JsonKey(ignore: true)
  _$$NotificationsModelImplCopyWith<_$NotificationsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PatientNotificationModel _$PatientNotificationModelFromJson(
    Map<String, dynamic> json) {
  return _PatientNotificationModel.fromJson(json);
}

/// @nodoc
mixin _$PatientNotificationModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get hospital => throw _privateConstructorUsedError;
  String? get governorate => throw _privateConstructorUsedError;
  DoctorNotificationDataModel? get doctor => throw _privateConstructorUsedError;
  SectionsNotificationDataModel? get sections =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PatientNotificationModelCopyWith<PatientNotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientNotificationModelCopyWith<$Res> {
  factory $PatientNotificationModelCopyWith(PatientNotificationModel value,
          $Res Function(PatientNotificationModel) then) =
      _$PatientNotificationModelCopyWithImpl<$Res, PatientNotificationModel>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? hospital,
      String? governorate,
      DoctorNotificationDataModel? doctor,
      SectionsNotificationDataModel? sections});

  $DoctorNotificationDataModelCopyWith<$Res>? get doctor;
  $SectionsNotificationDataModelCopyWith<$Res>? get sections;
}

/// @nodoc
class _$PatientNotificationModelCopyWithImpl<$Res,
        $Val extends PatientNotificationModel>
    implements $PatientNotificationModelCopyWith<$Res> {
  _$PatientNotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? hospital = freezed,
    Object? governorate = freezed,
    Object? doctor = freezed,
    Object? sections = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      hospital: freezed == hospital
          ? _value.hospital
          : hospital // ignore: cast_nullable_to_non_nullable
              as String?,
      governorate: freezed == governorate
          ? _value.governorate
          : governorate // ignore: cast_nullable_to_non_nullable
              as String?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorNotificationDataModel?,
      sections: freezed == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as SectionsNotificationDataModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DoctorNotificationDataModelCopyWith<$Res>? get doctor {
    if (_value.doctor == null) {
      return null;
    }

    return $DoctorNotificationDataModelCopyWith<$Res>(_value.doctor!, (value) {
      return _then(_value.copyWith(doctor: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SectionsNotificationDataModelCopyWith<$Res>? get sections {
    if (_value.sections == null) {
      return null;
    }

    return $SectionsNotificationDataModelCopyWith<$Res>(_value.sections!,
        (value) {
      return _then(_value.copyWith(sections: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PatientNotificationModelImplCopyWith<$Res>
    implements $PatientNotificationModelCopyWith<$Res> {
  factory _$$PatientNotificationModelImplCopyWith(
          _$PatientNotificationModelImpl value,
          $Res Function(_$PatientNotificationModelImpl) then) =
      __$$PatientNotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? hospital,
      String? governorate,
      DoctorNotificationDataModel? doctor,
      SectionsNotificationDataModel? sections});

  @override
  $DoctorNotificationDataModelCopyWith<$Res>? get doctor;
  @override
  $SectionsNotificationDataModelCopyWith<$Res>? get sections;
}

/// @nodoc
class __$$PatientNotificationModelImplCopyWithImpl<$Res>
    extends _$PatientNotificationModelCopyWithImpl<$Res,
        _$PatientNotificationModelImpl>
    implements _$$PatientNotificationModelImplCopyWith<$Res> {
  __$$PatientNotificationModelImplCopyWithImpl(
      _$PatientNotificationModelImpl _value,
      $Res Function(_$PatientNotificationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? hospital = freezed,
    Object? governorate = freezed,
    Object? doctor = freezed,
    Object? sections = freezed,
  }) {
    return _then(_$PatientNotificationModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      hospital: freezed == hospital
          ? _value.hospital
          : hospital // ignore: cast_nullable_to_non_nullable
              as String?,
      governorate: freezed == governorate
          ? _value.governorate
          : governorate // ignore: cast_nullable_to_non_nullable
              as String?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorNotificationDataModel?,
      sections: freezed == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as SectionsNotificationDataModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientNotificationModelImpl implements _PatientNotificationModel {
  const _$PatientNotificationModelImpl(
      {this.id,
      this.name,
      this.hospital,
      this.governorate,
      this.doctor,
      this.sections});

  factory _$PatientNotificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientNotificationModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? hospital;
  @override
  final String? governorate;
  @override
  final DoctorNotificationDataModel? doctor;
  @override
  final SectionsNotificationDataModel? sections;

  @override
  String toString() {
    return 'PatientNotificationModel(id: $id, name: $name, hospital: $hospital, governorate: $governorate, doctor: $doctor, sections: $sections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientNotificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.hospital, hospital) ||
                other.hospital == hospital) &&
            (identical(other.governorate, governorate) ||
                other.governorate == governorate) &&
            (identical(other.doctor, doctor) || other.doctor == doctor) &&
            (identical(other.sections, sections) ||
                other.sections == sections));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, hospital, governorate, doctor, sections);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientNotificationModelImplCopyWith<_$PatientNotificationModelImpl>
      get copyWith => __$$PatientNotificationModelImplCopyWithImpl<
          _$PatientNotificationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientNotificationModelImplToJson(
      this,
    );
  }
}

abstract class _PatientNotificationModel implements PatientNotificationModel {
  const factory _PatientNotificationModel(
          {final int? id,
          final String? name,
          final String? hospital,
          final String? governorate,
          final DoctorNotificationDataModel? doctor,
          final SectionsNotificationDataModel? sections}) =
      _$PatientNotificationModelImpl;

  factory _PatientNotificationModel.fromJson(Map<String, dynamic> json) =
      _$PatientNotificationModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get hospital;
  @override
  String? get governorate;
  @override
  DoctorNotificationDataModel? get doctor;
  @override
  SectionsNotificationDataModel? get sections;
  @override
  @JsonKey(ignore: true)
  _$$PatientNotificationModelImplCopyWith<_$PatientNotificationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DoctorNotificationDataModel _$DoctorNotificationDataModelFromJson(
    Map<String, dynamic> json) {
  return _DoctorNotificationDataModel.fromJson(json);
}

/// @nodoc
mixin _$DoctorNotificationDataModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lname')
  String? get lastName => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoctorNotificationDataModelCopyWith<DoctorNotificationDataModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorNotificationDataModelCopyWith<$Res> {
  factory $DoctorNotificationDataModelCopyWith(
          DoctorNotificationDataModel value,
          $Res Function(DoctorNotificationDataModel) then) =
      _$DoctorNotificationDataModelCopyWithImpl<$Res,
          DoctorNotificationDataModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? workingplace});
}

/// @nodoc
class _$DoctorNotificationDataModelCopyWithImpl<$Res,
        $Val extends DoctorNotificationDataModel>
    implements $DoctorNotificationDataModelCopyWith<$Res> {
  _$DoctorNotificationDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? workingplace = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DoctorNotificationDataModelImplCopyWith<$Res>
    implements $DoctorNotificationDataModelCopyWith<$Res> {
  factory _$$DoctorNotificationDataModelImplCopyWith(
          _$DoctorNotificationDataModelImpl value,
          $Res Function(_$DoctorNotificationDataModelImpl) then) =
      __$$DoctorNotificationDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? workingplace});
}

/// @nodoc
class __$$DoctorNotificationDataModelImplCopyWithImpl<$Res>
    extends _$DoctorNotificationDataModelCopyWithImpl<$Res,
        _$DoctorNotificationDataModelImpl>
    implements _$$DoctorNotificationDataModelImplCopyWith<$Res> {
  __$$DoctorNotificationDataModelImplCopyWithImpl(
      _$DoctorNotificationDataModelImpl _value,
      $Res Function(_$DoctorNotificationDataModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? workingplace = freezed,
  }) {
    return _then(_$DoctorNotificationDataModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorNotificationDataModelImpl
    implements _DoctorNotificationDataModel {
  const _$DoctorNotificationDataModelImpl(
      {this.id,
      @JsonKey(name: 'name') this.firstName,
      @JsonKey(name: 'lname') this.lastName,
      this.workingplace});

  factory _$DoctorNotificationDataModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DoctorNotificationDataModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'name')
  final String? firstName;
  @override
  @JsonKey(name: 'lname')
  final String? lastName;
  @override
  final String? workingplace;

  @override
  String toString() {
    return 'DoctorNotificationDataModel(id: $id, firstName: $firstName, lastName: $lastName, workingplace: $workingplace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorNotificationDataModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.workingplace, workingplace) ||
                other.workingplace == workingplace));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, firstName, lastName, workingplace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorNotificationDataModelImplCopyWith<_$DoctorNotificationDataModelImpl>
      get copyWith => __$$DoctorNotificationDataModelImplCopyWithImpl<
          _$DoctorNotificationDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorNotificationDataModelImplToJson(
      this,
    );
  }
}

abstract class _DoctorNotificationDataModel
    implements DoctorNotificationDataModel {
  const factory _DoctorNotificationDataModel(
      {final int? id,
      @JsonKey(name: 'name') final String? firstName,
      @JsonKey(name: 'lname') final String? lastName,
      final String? workingplace}) = _$DoctorNotificationDataModelImpl;

  factory _DoctorNotificationDataModel.fromJson(Map<String, dynamic> json) =
      _$DoctorNotificationDataModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'name')
  String? get firstName;
  @override
  @JsonKey(name: 'lname')
  String? get lastName;
  @override
  String? get workingplace;
  @override
  @JsonKey(ignore: true)
  _$$DoctorNotificationDataModelImplCopyWith<_$DoctorNotificationDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SectionsNotificationDataModel _$SectionsNotificationDataModelFromJson(
    Map<String, dynamic> json) {
  return _SectionsNotificationDataModel.fromJson(json);
}

/// @nodoc
mixin _$SectionsNotificationDataModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'submit_status')
  bool? get submitStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'outcome_status')
  bool? get outcomeStatus => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SectionsNotificationDataModelCopyWith<SectionsNotificationDataModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionsNotificationDataModelCopyWith<$Res> {
  factory $SectionsNotificationDataModelCopyWith(
          SectionsNotificationDataModel value,
          $Res Function(SectionsNotificationDataModel) then) =
      _$SectionsNotificationDataModelCopyWithImpl<$Res,
          SectionsNotificationDataModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'submit_status') bool? submitStatus,
      @JsonKey(name: 'outcome_status') bool? outcomeStatus,
      String? workingplace});
}

/// @nodoc
class _$SectionsNotificationDataModelCopyWithImpl<$Res,
        $Val extends SectionsNotificationDataModel>
    implements $SectionsNotificationDataModelCopyWith<$Res> {
  _$SectionsNotificationDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? submitStatus = freezed,
    Object? outcomeStatus = freezed,
    Object? workingplace = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      submitStatus: freezed == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      outcomeStatus: freezed == outcomeStatus
          ? _value.outcomeStatus
          : outcomeStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SectionsNotificationDataModelImplCopyWith<$Res>
    implements $SectionsNotificationDataModelCopyWith<$Res> {
  factory _$$SectionsNotificationDataModelImplCopyWith(
          _$SectionsNotificationDataModelImpl value,
          $Res Function(_$SectionsNotificationDataModelImpl) then) =
      __$$SectionsNotificationDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'submit_status') bool? submitStatus,
      @JsonKey(name: 'outcome_status') bool? outcomeStatus,
      String? workingplace});
}

/// @nodoc
class __$$SectionsNotificationDataModelImplCopyWithImpl<$Res>
    extends _$SectionsNotificationDataModelCopyWithImpl<$Res,
        _$SectionsNotificationDataModelImpl>
    implements _$$SectionsNotificationDataModelImplCopyWith<$Res> {
  __$$SectionsNotificationDataModelImplCopyWithImpl(
      _$SectionsNotificationDataModelImpl _value,
      $Res Function(_$SectionsNotificationDataModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? submitStatus = freezed,
    Object? outcomeStatus = freezed,
    Object? workingplace = freezed,
  }) {
    return _then(_$SectionsNotificationDataModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      submitStatus: freezed == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      outcomeStatus: freezed == outcomeStatus
          ? _value.outcomeStatus
          : outcomeStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionsNotificationDataModelImpl
    implements _SectionsNotificationDataModel {
  const _$SectionsNotificationDataModelImpl(
      {this.id,
      @JsonKey(name: 'submit_status') this.submitStatus,
      @JsonKey(name: 'outcome_status') this.outcomeStatus,
      this.workingplace});

  factory _$SectionsNotificationDataModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SectionsNotificationDataModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'submit_status')
  final bool? submitStatus;
  @override
  @JsonKey(name: 'outcome_status')
  final bool? outcomeStatus;
  @override
  final String? workingplace;

  @override
  String toString() {
    return 'SectionsNotificationDataModel(id: $id, submitStatus: $submitStatus, outcomeStatus: $outcomeStatus, workingplace: $workingplace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionsNotificationDataModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.submitStatus, submitStatus) ||
                other.submitStatus == submitStatus) &&
            (identical(other.outcomeStatus, outcomeStatus) ||
                other.outcomeStatus == outcomeStatus) &&
            (identical(other.workingplace, workingplace) ||
                other.workingplace == workingplace));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, submitStatus, outcomeStatus, workingplace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionsNotificationDataModelImplCopyWith<
          _$SectionsNotificationDataModelImpl>
      get copyWith => __$$SectionsNotificationDataModelImplCopyWithImpl<
          _$SectionsNotificationDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionsNotificationDataModelImplToJson(
      this,
    );
  }
}

abstract class _SectionsNotificationDataModel
    implements SectionsNotificationDataModel {
  const factory _SectionsNotificationDataModel(
      {final int? id,
      @JsonKey(name: 'submit_status') final bool? submitStatus,
      @JsonKey(name: 'outcome_status') final bool? outcomeStatus,
      final String? workingplace}) = _$SectionsNotificationDataModelImpl;

  factory _SectionsNotificationDataModel.fromJson(Map<String, dynamic> json) =
      _$SectionsNotificationDataModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'submit_status')
  bool? get submitStatus;
  @override
  @JsonKey(name: 'outcome_status')
  bool? get outcomeStatus;
  @override
  String? get workingplace;
  @override
  @JsonKey(ignore: true)
  _$$SectionsNotificationDataModelImplCopyWith<
          _$SectionsNotificationDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
