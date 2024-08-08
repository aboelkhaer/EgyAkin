// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_current_doctor_consultation_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetCurrentDoctorConsultationModelResponse
    _$GetCurrentDoctorConsultationModelResponseFromJson(
        Map<String, dynamic> json) {
  return _GetCurrentDoctorConsultationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetCurrentDoctorConsultationModelResponse {
  int? get id => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'consultation_doctors')
  List<ConsultationDoctorsModelResponse>? get consultationDoctors =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetCurrentDoctorConsultationModelResponseCopyWith<
          GetCurrentDoctorConsultationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetCurrentDoctorConsultationModelResponseCopyWith<$Res> {
  factory $GetCurrentDoctorConsultationModelResponseCopyWith(
          GetCurrentDoctorConsultationModelResponse value,
          $Res Function(GetCurrentDoctorConsultationModelResponse) then) =
      _$GetCurrentDoctorConsultationModelResponseCopyWithImpl<$Res,
          GetCurrentDoctorConsultationModelResponse>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'doctor_id') String? doctorId,
      @JsonKey(name: 'patient_id') String? patientId,
      @JsonKey(name: 'consult_message') String? consultMessage,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'consultation_doctors')
      List<ConsultationDoctorsModelResponse>? consultationDoctors});
}

/// @nodoc
class _$GetCurrentDoctorConsultationModelResponseCopyWithImpl<$Res,
        $Val extends GetCurrentDoctorConsultationModelResponse>
    implements $GetCurrentDoctorConsultationModelResponseCopyWith<$Res> {
  _$GetCurrentDoctorConsultationModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    Object? consultationDoctors = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      consultationDoctors: freezed == consultationDoctors
          ? _value.consultationDoctors
          : consultationDoctors // ignore: cast_nullable_to_non_nullable
              as List<ConsultationDoctorsModelResponse>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetCurrentDoctorConsultationModelResponseImplCopyWith<$Res>
    implements $GetCurrentDoctorConsultationModelResponseCopyWith<$Res> {
  factory _$$GetCurrentDoctorConsultationModelResponseImplCopyWith(
          _$GetCurrentDoctorConsultationModelResponseImpl value,
          $Res Function(_$GetCurrentDoctorConsultationModelResponseImpl) then) =
      __$$GetCurrentDoctorConsultationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'doctor_id') String? doctorId,
      @JsonKey(name: 'patient_id') String? patientId,
      @JsonKey(name: 'consult_message') String? consultMessage,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'consultation_doctors')
      List<ConsultationDoctorsModelResponse>? consultationDoctors});
}

/// @nodoc
class __$$GetCurrentDoctorConsultationModelResponseImplCopyWithImpl<$Res>
    extends _$GetCurrentDoctorConsultationModelResponseCopyWithImpl<$Res,
        _$GetCurrentDoctorConsultationModelResponseImpl>
    implements _$$GetCurrentDoctorConsultationModelResponseImplCopyWith<$Res> {
  __$$GetCurrentDoctorConsultationModelResponseImplCopyWithImpl(
      _$GetCurrentDoctorConsultationModelResponseImpl _value,
      $Res Function(_$GetCurrentDoctorConsultationModelResponseImpl) _then)
      : super(_value, _then);

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
    Object? consultationDoctors = freezed,
  }) {
    return _then(_$GetCurrentDoctorConsultationModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      consultationDoctors: freezed == consultationDoctors
          ? _value._consultationDoctors
          : consultationDoctors // ignore: cast_nullable_to_non_nullable
              as List<ConsultationDoctorsModelResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetCurrentDoctorConsultationModelResponseImpl
    with DiagnosticableTreeMixin
    implements _GetCurrentDoctorConsultationModelResponse {
  const _$GetCurrentDoctorConsultationModelResponseImpl(
      {this.id,
      @JsonKey(name: 'doctor_id') this.doctorId,
      @JsonKey(name: 'patient_id') this.patientId,
      @JsonKey(name: 'consult_message') this.consultMessage,
      this.status,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'consultation_doctors')
      final List<ConsultationDoctorsModelResponse>? consultationDoctors})
      : _consultationDoctors = consultationDoctors;

  factory _$GetCurrentDoctorConsultationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetCurrentDoctorConsultationModelResponseImplFromJson(json);

  @override
  final int? id;
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
  final List<ConsultationDoctorsModelResponse>? _consultationDoctors;
  @override
  @JsonKey(name: 'consultation_doctors')
  List<ConsultationDoctorsModelResponse>? get consultationDoctors {
    final value = _consultationDoctors;
    if (value == null) return null;
    if (_consultationDoctors is EqualUnmodifiableListView)
      return _consultationDoctors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetCurrentDoctorConsultationModelResponse(id: $id, doctorId: $doctorId, patientId: $patientId, consultMessage: $consultMessage, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, consultationDoctors: $consultationDoctors)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'GetCurrentDoctorConsultationModelResponse'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('doctorId', doctorId))
      ..add(DiagnosticsProperty('patientId', patientId))
      ..add(DiagnosticsProperty('consultMessage', consultMessage))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('consultationDoctors', consultationDoctors));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCurrentDoctorConsultationModelResponseImpl &&
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
            const DeepCollectionEquality()
                .equals(other._consultationDoctors, _consultationDoctors));
  }

  @JsonKey(ignore: true)
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
      const DeepCollectionEquality().hash(_consultationDoctors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCurrentDoctorConsultationModelResponseImplCopyWith<
          _$GetCurrentDoctorConsultationModelResponseImpl>
      get copyWith =>
          __$$GetCurrentDoctorConsultationModelResponseImplCopyWithImpl<
                  _$GetCurrentDoctorConsultationModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetCurrentDoctorConsultationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetCurrentDoctorConsultationModelResponse
    implements GetCurrentDoctorConsultationModelResponse {
  const factory _GetCurrentDoctorConsultationModelResponse(
          {final int? id,
          @JsonKey(name: 'doctor_id') final String? doctorId,
          @JsonKey(name: 'patient_id') final String? patientId,
          @JsonKey(name: 'consult_message') final String? consultMessage,
          final String? status,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt,
          @JsonKey(name: 'consultation_doctors')
          final List<ConsultationDoctorsModelResponse>? consultationDoctors}) =
      _$GetCurrentDoctorConsultationModelResponseImpl;

  factory _GetCurrentDoctorConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetCurrentDoctorConsultationModelResponseImpl.fromJson;

  @override
  int? get id;
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
  @JsonKey(name: 'consultation_doctors')
  List<ConsultationDoctorsModelResponse>? get consultationDoctors;
  @override
  @JsonKey(ignore: true)
  _$$GetCurrentDoctorConsultationModelResponseImplCopyWith<
          _$GetCurrentDoctorConsultationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ConsultationDoctorsModelResponse _$ConsultationDoctorsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ConsultationDoctorsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ConsultationDoctorsModelResponse {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_id')
  String? get doctorId => throw _privateConstructorUsedError;
  String? get reply => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConsultationDoctorsModelResponseCopyWith<ConsultationDoctorsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsultationDoctorsModelResponseCopyWith<$Res> {
  factory $ConsultationDoctorsModelResponseCopyWith(
          ConsultationDoctorsModelResponse value,
          $Res Function(ConsultationDoctorsModelResponse) then) =
      _$ConsultationDoctorsModelResponseCopyWithImpl<$Res,
          ConsultationDoctorsModelResponse>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'doctor_id') String? doctorId,
      String? reply,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$ConsultationDoctorsModelResponseCopyWithImpl<$Res,
        $Val extends ConsultationDoctorsModelResponse>
    implements $ConsultationDoctorsModelResponseCopyWith<$Res> {
  _$ConsultationDoctorsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? doctorId = freezed,
    Object? reply = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$ConsultationDoctorsModelResponseImplCopyWith<$Res>
    implements $ConsultationDoctorsModelResponseCopyWith<$Res> {
  factory _$$ConsultationDoctorsModelResponseImplCopyWith(
          _$ConsultationDoctorsModelResponseImpl value,
          $Res Function(_$ConsultationDoctorsModelResponseImpl) then) =
      __$$ConsultationDoctorsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'doctor_id') String? doctorId,
      String? reply,
      String? status,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$ConsultationDoctorsModelResponseImplCopyWithImpl<$Res>
    extends _$ConsultationDoctorsModelResponseCopyWithImpl<$Res,
        _$ConsultationDoctorsModelResponseImpl>
    implements _$$ConsultationDoctorsModelResponseImplCopyWith<$Res> {
  __$$ConsultationDoctorsModelResponseImplCopyWithImpl(
      _$ConsultationDoctorsModelResponseImpl _value,
      $Res Function(_$ConsultationDoctorsModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? doctorId = freezed,
    Object? reply = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ConsultationDoctorsModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$ConsultationDoctorsModelResponseImpl
    with DiagnosticableTreeMixin
    implements _ConsultationDoctorsModelResponse {
  const _$ConsultationDoctorsModelResponseImpl(
      {this.id,
      @JsonKey(name: 'doctor_id') this.doctorId,
      this.reply,
      this.status,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$ConsultationDoctorsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ConsultationDoctorsModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'doctor_id')
  final String? doctorId;
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConsultationDoctorsModelResponse(id: $id, doctorId: $doctorId, reply: $reply, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConsultationDoctorsModelResponse'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('doctorId', doctorId))
      ..add(DiagnosticsProperty('reply', reply))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsultationDoctorsModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.reply, reply) || other.reply == reply) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, doctorId, reply, status, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsultationDoctorsModelResponseImplCopyWith<
          _$ConsultationDoctorsModelResponseImpl>
      get copyWith => __$$ConsultationDoctorsModelResponseImplCopyWithImpl<
          _$ConsultationDoctorsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsultationDoctorsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ConsultationDoctorsModelResponse
    implements ConsultationDoctorsModelResponse {
  const factory _ConsultationDoctorsModelResponse(
          {final int? id,
          @JsonKey(name: 'doctor_id') final String? doctorId,
          final String? reply,
          final String? status,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt}) =
      _$ConsultationDoctorsModelResponseImpl;

  factory _ConsultationDoctorsModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$ConsultationDoctorsModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'doctor_id')
  String? get doctorId;
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
  @override
  @JsonKey(ignore: true)
  _$$ConsultationDoctorsModelResponseImplCopyWith<
          _$ConsultationDoctorsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
