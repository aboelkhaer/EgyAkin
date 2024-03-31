// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationModelResponse _$NotificationModelResponseFromJson(
    Map<String, dynamic> json) {
  return _NotificationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  int? get unreadCount => throw _privateConstructorUsedError;
  List<NotificationDataModelResponse>? get data =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationModelResponseCopyWith<NotificationModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationModelResponseCopyWith<$Res> {
  factory $NotificationModelResponseCopyWith(NotificationModelResponse value,
          $Res Function(NotificationModelResponse) then) =
      _$NotificationModelResponseCopyWithImpl<$Res, NotificationModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      int? unreadCount,
      List<NotificationDataModelResponse>? data});
}

/// @nodoc
class _$NotificationModelResponseCopyWithImpl<$Res,
        $Val extends NotificationModelResponse>
    implements $NotificationModelResponseCopyWith<$Res> {
  _$NotificationModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? unreadCount = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<NotificationDataModelResponse>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationModelResponseImplCopyWith<$Res>
    implements $NotificationModelResponseCopyWith<$Res> {
  factory _$$NotificationModelResponseImplCopyWith(
          _$NotificationModelResponseImpl value,
          $Res Function(_$NotificationModelResponseImpl) then) =
      __$$NotificationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      int? unreadCount,
      List<NotificationDataModelResponse>? data});
}

/// @nodoc
class __$$NotificationModelResponseImplCopyWithImpl<$Res>
    extends _$NotificationModelResponseCopyWithImpl<$Res,
        _$NotificationModelResponseImpl>
    implements _$$NotificationModelResponseImplCopyWith<$Res> {
  __$$NotificationModelResponseImplCopyWithImpl(
      _$NotificationModelResponseImpl _value,
      $Res Function(_$NotificationModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? unreadCount = freezed,
    Object? data = freezed,
  }) {
    return _then(_$NotificationModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<NotificationDataModelResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationModelResponseImpl
    with DiagnosticableTreeMixin
    implements _NotificationModelResponse {
  const _$NotificationModelResponseImpl(
      {this.value,
      this.unreadCount,
      final List<NotificationDataModelResponse>? data})
      : _data = data;

  factory _$NotificationModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final int? unreadCount;
  final List<NotificationDataModelResponse>? _data;
  @override
  List<NotificationDataModelResponse>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationModelResponse(value: $value, unreadCount: $unreadCount, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationModelResponse'))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('unreadCount', unreadCount))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, unreadCount,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationModelResponseImplCopyWith<_$NotificationModelResponseImpl>
      get copyWith => __$$NotificationModelResponseImplCopyWithImpl<
          _$NotificationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _NotificationModelResponse implements NotificationModelResponse {
  const factory _NotificationModelResponse(
          {final bool? value,
          final int? unreadCount,
          final List<NotificationDataModelResponse>? data}) =
      _$NotificationModelResponseImpl;

  factory _NotificationModelResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  int? get unreadCount;
  @override
  List<NotificationDataModelResponse>? get data;
  @override
  @JsonKey(ignore: true)
  _$$NotificationModelResponseImplCopyWith<_$NotificationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationDataModelResponse _$NotificationDataModelResponseFromJson(
    Map<String, dynamic> json) {
  return _NotificationDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationDataModelResponse {
  int? get id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  bool? get read => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  PatientNotificationDataModelResponse? get patient =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationDataModelResponseCopyWith<NotificationDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationDataModelResponseCopyWith<$Res> {
  factory $NotificationDataModelResponseCopyWith(
          NotificationDataModelResponse value,
          $Res Function(NotificationDataModelResponse) then) =
      _$NotificationDataModelResponseCopyWithImpl<$Res,
          NotificationDataModelResponse>;
  @useResult
  $Res call(
      {int? id,
      String? type,
      bool? read,
      @JsonKey(name: 'created_at') String? createdAt,
      PatientNotificationDataModelResponse? patient});

  $PatientNotificationDataModelResponseCopyWith<$Res>? get patient;
}

/// @nodoc
class _$NotificationDataModelResponseCopyWithImpl<$Res,
        $Val extends NotificationDataModelResponse>
    implements $NotificationDataModelResponseCopyWith<$Res> {
  _$NotificationDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? read = freezed,
    Object? createdAt = freezed,
    Object? patient = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as PatientNotificationDataModelResponse?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PatientNotificationDataModelResponseCopyWith<$Res>? get patient {
    if (_value.patient == null) {
      return null;
    }

    return $PatientNotificationDataModelResponseCopyWith<$Res>(_value.patient!,
        (value) {
      return _then(_value.copyWith(patient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationDataModelResponseImplCopyWith<$Res>
    implements $NotificationDataModelResponseCopyWith<$Res> {
  factory _$$NotificationDataModelResponseImplCopyWith(
          _$NotificationDataModelResponseImpl value,
          $Res Function(_$NotificationDataModelResponseImpl) then) =
      __$$NotificationDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? type,
      bool? read,
      @JsonKey(name: 'created_at') String? createdAt,
      PatientNotificationDataModelResponse? patient});

  @override
  $PatientNotificationDataModelResponseCopyWith<$Res>? get patient;
}

/// @nodoc
class __$$NotificationDataModelResponseImplCopyWithImpl<$Res>
    extends _$NotificationDataModelResponseCopyWithImpl<$Res,
        _$NotificationDataModelResponseImpl>
    implements _$$NotificationDataModelResponseImplCopyWith<$Res> {
  __$$NotificationDataModelResponseImplCopyWithImpl(
      _$NotificationDataModelResponseImpl _value,
      $Res Function(_$NotificationDataModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? read = freezed,
    Object? createdAt = freezed,
    Object? patient = freezed,
  }) {
    return _then(_$NotificationDataModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as PatientNotificationDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationDataModelResponseImpl
    with DiagnosticableTreeMixin
    implements _NotificationDataModelResponse {
  const _$NotificationDataModelResponseImpl(
      {this.id,
      this.type,
      this.read,
      @JsonKey(name: 'created_at') this.createdAt,
      this.patient});

  factory _$NotificationDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationDataModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  final String? type;
  @override
  final bool? read;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  final PatientNotificationDataModelResponse? patient;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationDataModelResponse(id: $id, type: $type, read: $read, createdAt: $createdAt, patient: $patient)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationDataModelResponse'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('read', read))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('patient', patient));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationDataModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.patient, patient) || other.patient == patient));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, read, createdAt, patient);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationDataModelResponseImplCopyWith<
          _$NotificationDataModelResponseImpl>
      get copyWith => __$$NotificationDataModelResponseImplCopyWithImpl<
          _$NotificationDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _NotificationDataModelResponse
    implements NotificationDataModelResponse {
  const factory _NotificationDataModelResponse(
          {final int? id,
          final String? type,
          final bool? read,
          @JsonKey(name: 'created_at') final String? createdAt,
          final PatientNotificationDataModelResponse? patient}) =
      _$NotificationDataModelResponseImpl;

  factory _NotificationDataModelResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationDataModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  String? get type;
  @override
  bool? get read;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  PatientNotificationDataModelResponse? get patient;
  @override
  @JsonKey(ignore: true)
  _$$NotificationDataModelResponseImplCopyWith<
          _$NotificationDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PatientNotificationDataModelResponse
    _$PatientNotificationDataModelResponseFromJson(Map<String, dynamic> json) {
  return _PatientNotificationDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$PatientNotificationDataModelResponse {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get hospital => throw _privateConstructorUsedError;
  String? get governorate => throw _privateConstructorUsedError;
  DoctorNotificationDataModelResponse? get doctor =>
      throw _privateConstructorUsedError;
  SectionsNotificationDataModelResponse? get sections =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PatientNotificationDataModelResponseCopyWith<
          PatientNotificationDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientNotificationDataModelResponseCopyWith<$Res> {
  factory $PatientNotificationDataModelResponseCopyWith(
          PatientNotificationDataModelResponse value,
          $Res Function(PatientNotificationDataModelResponse) then) =
      _$PatientNotificationDataModelResponseCopyWithImpl<$Res,
          PatientNotificationDataModelResponse>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? hospital,
      String? governorate,
      DoctorNotificationDataModelResponse? doctor,
      SectionsNotificationDataModelResponse? sections});

  $DoctorNotificationDataModelResponseCopyWith<$Res>? get doctor;
  $SectionsNotificationDataModelResponseCopyWith<$Res>? get sections;
}

/// @nodoc
class _$PatientNotificationDataModelResponseCopyWithImpl<$Res,
        $Val extends PatientNotificationDataModelResponse>
    implements $PatientNotificationDataModelResponseCopyWith<$Res> {
  _$PatientNotificationDataModelResponseCopyWithImpl(this._value, this._then);

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
              as DoctorNotificationDataModelResponse?,
      sections: freezed == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as SectionsNotificationDataModelResponse?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DoctorNotificationDataModelResponseCopyWith<$Res>? get doctor {
    if (_value.doctor == null) {
      return null;
    }

    return $DoctorNotificationDataModelResponseCopyWith<$Res>(_value.doctor!,
        (value) {
      return _then(_value.copyWith(doctor: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SectionsNotificationDataModelResponseCopyWith<$Res>? get sections {
    if (_value.sections == null) {
      return null;
    }

    return $SectionsNotificationDataModelResponseCopyWith<$Res>(
        _value.sections!, (value) {
      return _then(_value.copyWith(sections: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PatientNotificationDataModelResponseImplCopyWith<$Res>
    implements $PatientNotificationDataModelResponseCopyWith<$Res> {
  factory _$$PatientNotificationDataModelResponseImplCopyWith(
          _$PatientNotificationDataModelResponseImpl value,
          $Res Function(_$PatientNotificationDataModelResponseImpl) then) =
      __$$PatientNotificationDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? hospital,
      String? governorate,
      DoctorNotificationDataModelResponse? doctor,
      SectionsNotificationDataModelResponse? sections});

  @override
  $DoctorNotificationDataModelResponseCopyWith<$Res>? get doctor;
  @override
  $SectionsNotificationDataModelResponseCopyWith<$Res>? get sections;
}

/// @nodoc
class __$$PatientNotificationDataModelResponseImplCopyWithImpl<$Res>
    extends _$PatientNotificationDataModelResponseCopyWithImpl<$Res,
        _$PatientNotificationDataModelResponseImpl>
    implements _$$PatientNotificationDataModelResponseImplCopyWith<$Res> {
  __$$PatientNotificationDataModelResponseImplCopyWithImpl(
      _$PatientNotificationDataModelResponseImpl _value,
      $Res Function(_$PatientNotificationDataModelResponseImpl) _then)
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
    return _then(_$PatientNotificationDataModelResponseImpl(
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
              as DoctorNotificationDataModelResponse?,
      sections: freezed == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as SectionsNotificationDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientNotificationDataModelResponseImpl
    with DiagnosticableTreeMixin
    implements _PatientNotificationDataModelResponse {
  const _$PatientNotificationDataModelResponseImpl(
      {this.id,
      this.name,
      this.hospital,
      this.governorate,
      this.doctor,
      this.sections});

  factory _$PatientNotificationDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PatientNotificationDataModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? hospital;
  @override
  final String? governorate;
  @override
  final DoctorNotificationDataModelResponse? doctor;
  @override
  final SectionsNotificationDataModelResponse? sections;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatientNotificationDataModelResponse(id: $id, name: $name, hospital: $hospital, governorate: $governorate, doctor: $doctor, sections: $sections)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatientNotificationDataModelResponse'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('hospital', hospital))
      ..add(DiagnosticsProperty('governorate', governorate))
      ..add(DiagnosticsProperty('doctor', doctor))
      ..add(DiagnosticsProperty('sections', sections));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientNotificationDataModelResponseImpl &&
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
  _$$PatientNotificationDataModelResponseImplCopyWith<
          _$PatientNotificationDataModelResponseImpl>
      get copyWith => __$$PatientNotificationDataModelResponseImplCopyWithImpl<
          _$PatientNotificationDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientNotificationDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _PatientNotificationDataModelResponse
    implements PatientNotificationDataModelResponse {
  const factory _PatientNotificationDataModelResponse(
          {final int? id,
          final String? name,
          final String? hospital,
          final String? governorate,
          final DoctorNotificationDataModelResponse? doctor,
          final SectionsNotificationDataModelResponse? sections}) =
      _$PatientNotificationDataModelResponseImpl;

  factory _PatientNotificationDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$PatientNotificationDataModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get hospital;
  @override
  String? get governorate;
  @override
  DoctorNotificationDataModelResponse? get doctor;
  @override
  SectionsNotificationDataModelResponse? get sections;
  @override
  @JsonKey(ignore: true)
  _$$PatientNotificationDataModelResponseImplCopyWith<
          _$PatientNotificationDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DoctorNotificationDataModelResponse
    _$DoctorNotificationDataModelResponseFromJson(Map<String, dynamic> json) {
  return _DoctorNotificationDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DoctorNotificationDataModelResponse {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lname')
  String? get lastName => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoctorNotificationDataModelResponseCopyWith<
          DoctorNotificationDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorNotificationDataModelResponseCopyWith<$Res> {
  factory $DoctorNotificationDataModelResponseCopyWith(
          DoctorNotificationDataModelResponse value,
          $Res Function(DoctorNotificationDataModelResponse) then) =
      _$DoctorNotificationDataModelResponseCopyWithImpl<$Res,
          DoctorNotificationDataModelResponse>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? workingplace});
}

/// @nodoc
class _$DoctorNotificationDataModelResponseCopyWithImpl<$Res,
        $Val extends DoctorNotificationDataModelResponse>
    implements $DoctorNotificationDataModelResponseCopyWith<$Res> {
  _$DoctorNotificationDataModelResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$DoctorNotificationDataModelResponseImplCopyWith<$Res>
    implements $DoctorNotificationDataModelResponseCopyWith<$Res> {
  factory _$$DoctorNotificationDataModelResponseImplCopyWith(
          _$DoctorNotificationDataModelResponseImpl value,
          $Res Function(_$DoctorNotificationDataModelResponseImpl) then) =
      __$$DoctorNotificationDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? workingplace});
}

/// @nodoc
class __$$DoctorNotificationDataModelResponseImplCopyWithImpl<$Res>
    extends _$DoctorNotificationDataModelResponseCopyWithImpl<$Res,
        _$DoctorNotificationDataModelResponseImpl>
    implements _$$DoctorNotificationDataModelResponseImplCopyWith<$Res> {
  __$$DoctorNotificationDataModelResponseImplCopyWithImpl(
      _$DoctorNotificationDataModelResponseImpl _value,
      $Res Function(_$DoctorNotificationDataModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? workingplace = freezed,
  }) {
    return _then(_$DoctorNotificationDataModelResponseImpl(
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
class _$DoctorNotificationDataModelResponseImpl
    with DiagnosticableTreeMixin
    implements _DoctorNotificationDataModelResponse {
  const _$DoctorNotificationDataModelResponseImpl(
      {this.id,
      @JsonKey(name: 'name') this.firstName,
      @JsonKey(name: 'lname') this.lastName,
      this.workingplace});

  factory _$DoctorNotificationDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DoctorNotificationDataModelResponseImplFromJson(json);

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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DoctorNotificationDataModelResponse(id: $id, firstName: $firstName, lastName: $lastName, workingplace: $workingplace)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DoctorNotificationDataModelResponse'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('workingplace', workingplace));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorNotificationDataModelResponseImpl &&
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
  _$$DoctorNotificationDataModelResponseImplCopyWith<
          _$DoctorNotificationDataModelResponseImpl>
      get copyWith => __$$DoctorNotificationDataModelResponseImplCopyWithImpl<
          _$DoctorNotificationDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorNotificationDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DoctorNotificationDataModelResponse
    implements DoctorNotificationDataModelResponse {
  const factory _DoctorNotificationDataModelResponse(
      {final int? id,
      @JsonKey(name: 'name') final String? firstName,
      @JsonKey(name: 'lname') final String? lastName,
      final String? workingplace}) = _$DoctorNotificationDataModelResponseImpl;

  factory _DoctorNotificationDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$DoctorNotificationDataModelResponseImpl.fromJson;

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
  _$$DoctorNotificationDataModelResponseImplCopyWith<
          _$DoctorNotificationDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SectionsNotificationDataModelResponse
    _$SectionsNotificationDataModelResponseFromJson(Map<String, dynamic> json) {
  return _SectionsNotificationDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SectionsNotificationDataModelResponse {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'submit_status')
  bool? get submitStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'outcome_status')
  bool? get outcomeStatus => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SectionsNotificationDataModelResponseCopyWith<
          SectionsNotificationDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionsNotificationDataModelResponseCopyWith<$Res> {
  factory $SectionsNotificationDataModelResponseCopyWith(
          SectionsNotificationDataModelResponse value,
          $Res Function(SectionsNotificationDataModelResponse) then) =
      _$SectionsNotificationDataModelResponseCopyWithImpl<$Res,
          SectionsNotificationDataModelResponse>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'submit_status') bool? submitStatus,
      @JsonKey(name: 'outcome_status') bool? outcomeStatus,
      String? workingplace});
}

/// @nodoc
class _$SectionsNotificationDataModelResponseCopyWithImpl<$Res,
        $Val extends SectionsNotificationDataModelResponse>
    implements $SectionsNotificationDataModelResponseCopyWith<$Res> {
  _$SectionsNotificationDataModelResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$SectionsNotificationDataModelResponseImplCopyWith<$Res>
    implements $SectionsNotificationDataModelResponseCopyWith<$Res> {
  factory _$$SectionsNotificationDataModelResponseImplCopyWith(
          _$SectionsNotificationDataModelResponseImpl value,
          $Res Function(_$SectionsNotificationDataModelResponseImpl) then) =
      __$$SectionsNotificationDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'submit_status') bool? submitStatus,
      @JsonKey(name: 'outcome_status') bool? outcomeStatus,
      String? workingplace});
}

/// @nodoc
class __$$SectionsNotificationDataModelResponseImplCopyWithImpl<$Res>
    extends _$SectionsNotificationDataModelResponseCopyWithImpl<$Res,
        _$SectionsNotificationDataModelResponseImpl>
    implements _$$SectionsNotificationDataModelResponseImplCopyWith<$Res> {
  __$$SectionsNotificationDataModelResponseImplCopyWithImpl(
      _$SectionsNotificationDataModelResponseImpl _value,
      $Res Function(_$SectionsNotificationDataModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? submitStatus = freezed,
    Object? outcomeStatus = freezed,
    Object? workingplace = freezed,
  }) {
    return _then(_$SectionsNotificationDataModelResponseImpl(
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
class _$SectionsNotificationDataModelResponseImpl
    with DiagnosticableTreeMixin
    implements _SectionsNotificationDataModelResponse {
  const _$SectionsNotificationDataModelResponseImpl(
      {this.id,
      @JsonKey(name: 'submit_status') this.submitStatus,
      @JsonKey(name: 'outcome_status') this.outcomeStatus,
      this.workingplace});

  factory _$SectionsNotificationDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SectionsNotificationDataModelResponseImplFromJson(json);

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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SectionsNotificationDataModelResponse(id: $id, submitStatus: $submitStatus, outcomeStatus: $outcomeStatus, workingplace: $workingplace)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'SectionsNotificationDataModelResponse'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('submitStatus', submitStatus))
      ..add(DiagnosticsProperty('outcomeStatus', outcomeStatus))
      ..add(DiagnosticsProperty('workingplace', workingplace));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionsNotificationDataModelResponseImpl &&
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
  _$$SectionsNotificationDataModelResponseImplCopyWith<
          _$SectionsNotificationDataModelResponseImpl>
      get copyWith => __$$SectionsNotificationDataModelResponseImplCopyWithImpl<
          _$SectionsNotificationDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionsNotificationDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SectionsNotificationDataModelResponse
    implements SectionsNotificationDataModelResponse {
  const factory _SectionsNotificationDataModelResponse(
          {final int? id,
          @JsonKey(name: 'submit_status') final bool? submitStatus,
          @JsonKey(name: 'outcome_status') final bool? outcomeStatus,
          final String? workingplace}) =
      _$SectionsNotificationDataModelResponseImpl;

  factory _SectionsNotificationDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$SectionsNotificationDataModelResponseImpl.fromJson;

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
  _$$SectionsNotificationDataModelResponseImplCopyWith<
          _$SectionsNotificationDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
