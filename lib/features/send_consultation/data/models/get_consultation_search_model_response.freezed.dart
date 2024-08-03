// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_consultation_search_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetConsultationSearchModelResponse _$GetConsultationSearchModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetConsultationSearchModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetConsultationSearchModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  List<DoctorModelInConsultationModelResponse>? get data =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetConsultationSearchModelResponseCopyWith<
          GetConsultationSearchModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetConsultationSearchModelResponseCopyWith<$Res> {
  factory $GetConsultationSearchModelResponseCopyWith(
          GetConsultationSearchModelResponse value,
          $Res Function(GetConsultationSearchModelResponse) then) =
      _$GetConsultationSearchModelResponseCopyWithImpl<$Res,
          GetConsultationSearchModelResponse>;
  @useResult
  $Res call({bool? value, List<DoctorModelInConsultationModelResponse>? data});
}

/// @nodoc
class _$GetConsultationSearchModelResponseCopyWithImpl<$Res,
        $Val extends GetConsultationSearchModelResponse>
    implements $GetConsultationSearchModelResponseCopyWith<$Res> {
  _$GetConsultationSearchModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<DoctorModelInConsultationModelResponse>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetConsultationSearchModelResponseImplCopyWith<$Res>
    implements $GetConsultationSearchModelResponseCopyWith<$Res> {
  factory _$$GetConsultationSearchModelResponseImplCopyWith(
          _$GetConsultationSearchModelResponseImpl value,
          $Res Function(_$GetConsultationSearchModelResponseImpl) then) =
      __$$GetConsultationSearchModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, List<DoctorModelInConsultationModelResponse>? data});
}

/// @nodoc
class __$$GetConsultationSearchModelResponseImplCopyWithImpl<$Res>
    extends _$GetConsultationSearchModelResponseCopyWithImpl<$Res,
        _$GetConsultationSearchModelResponseImpl>
    implements _$$GetConsultationSearchModelResponseImplCopyWith<$Res> {
  __$$GetConsultationSearchModelResponseImplCopyWithImpl(
      _$GetConsultationSearchModelResponseImpl _value,
      $Res Function(_$GetConsultationSearchModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetConsultationSearchModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<DoctorModelInConsultationModelResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetConsultationSearchModelResponseImpl
    with DiagnosticableTreeMixin
    implements _GetConsultationSearchModelResponse {
  const _$GetConsultationSearchModelResponseImpl(
      {this.value, final List<DoctorModelInConsultationModelResponse>? data})
      : _data = data;

  factory _$GetConsultationSearchModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetConsultationSearchModelResponseImplFromJson(json);

  @override
  final bool? value;
  final List<DoctorModelInConsultationModelResponse>? _data;
  @override
  List<DoctorModelInConsultationModelResponse>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetConsultationSearchModelResponse(value: $value, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GetConsultationSearchModelResponse'))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetConsultationSearchModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetConsultationSearchModelResponseImplCopyWith<
          _$GetConsultationSearchModelResponseImpl>
      get copyWith => __$$GetConsultationSearchModelResponseImplCopyWithImpl<
          _$GetConsultationSearchModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetConsultationSearchModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetConsultationSearchModelResponse
    implements GetConsultationSearchModelResponse {
  const factory _GetConsultationSearchModelResponse(
          {final bool? value,
          final List<DoctorModelInConsultationModelResponse>? data}) =
      _$GetConsultationSearchModelResponseImpl;

  factory _GetConsultationSearchModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetConsultationSearchModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  List<DoctorModelInConsultationModelResponse>? get data;
  @override
  @JsonKey(ignore: true)
  _$$GetConsultationSearchModelResponseImplCopyWith<
          _$GetConsultationSearchModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DoctorModelInConsultationModelResponse
    _$DoctorModelInConsultationModelResponseFromJson(
        Map<String, dynamic> json) {
  return _DoctorModelInConsultationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$DoctorModelInConsultationModelResponse {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lname')
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get specialty => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'syndicate_card')
  String? get syndicateCard => throw _privateConstructorUsedError;
  String? get isSyndicateCardRequired => throw _privateConstructorUsedError;
  @JsonKey(name: 'patients_count')
  String? get patientsCount => throw _privateConstructorUsedError;
  String? get score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoctorModelInConsultationModelResponseCopyWith<
          DoctorModelInConsultationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorModelInConsultationModelResponseCopyWith<$Res> {
  factory $DoctorModelInConsultationModelResponseCopyWith(
          DoctorModelInConsultationModelResponse value,
          $Res Function(DoctorModelInConsultationModelResponse) then) =
      _$DoctorModelInConsultationModelResponseCopyWithImpl<$Res,
          DoctorModelInConsultationModelResponse>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? email,
      String? phone,
      String? specialty,
      String? workingplace,
      String? image,
      @JsonKey(name: 'syndicate_card') String? syndicateCard,
      String? isSyndicateCardRequired,
      @JsonKey(name: 'patients_count') String? patientsCount,
      String? score});
}

/// @nodoc
class _$DoctorModelInConsultationModelResponseCopyWithImpl<$Res,
        $Val extends DoctorModelInConsultationModelResponse>
    implements $DoctorModelInConsultationModelResponseCopyWith<$Res> {
  _$DoctorModelInConsultationModelResponseCopyWithImpl(this._value, this._then);

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
    Object? email = freezed,
    Object? phone = freezed,
    Object? specialty = freezed,
    Object? workingplace = freezed,
    Object? image = freezed,
    Object? syndicateCard = freezed,
    Object? isSyndicateCardRequired = freezed,
    Object? patientsCount = freezed,
    Object? score = freezed,
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      specialty: freezed == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      syndicateCard: freezed == syndicateCard
          ? _value.syndicateCard
          : syndicateCard // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
      patientsCount: freezed == patientsCount
          ? _value.patientsCount
          : patientsCount // ignore: cast_nullable_to_non_nullable
              as String?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DoctorModelInConsultationModelResponseImplCopyWith<$Res>
    implements $DoctorModelInConsultationModelResponseCopyWith<$Res> {
  factory _$$DoctorModelInConsultationModelResponseImplCopyWith(
          _$DoctorModelInConsultationModelResponseImpl value,
          $Res Function(_$DoctorModelInConsultationModelResponseImpl) then) =
      __$$DoctorModelInConsultationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? email,
      String? phone,
      String? specialty,
      String? workingplace,
      String? image,
      @JsonKey(name: 'syndicate_card') String? syndicateCard,
      String? isSyndicateCardRequired,
      @JsonKey(name: 'patients_count') String? patientsCount,
      String? score});
}

/// @nodoc
class __$$DoctorModelInConsultationModelResponseImplCopyWithImpl<$Res>
    extends _$DoctorModelInConsultationModelResponseCopyWithImpl<$Res,
        _$DoctorModelInConsultationModelResponseImpl>
    implements _$$DoctorModelInConsultationModelResponseImplCopyWith<$Res> {
  __$$DoctorModelInConsultationModelResponseImplCopyWithImpl(
      _$DoctorModelInConsultationModelResponseImpl _value,
      $Res Function(_$DoctorModelInConsultationModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? specialty = freezed,
    Object? workingplace = freezed,
    Object? image = freezed,
    Object? syndicateCard = freezed,
    Object? isSyndicateCardRequired = freezed,
    Object? patientsCount = freezed,
    Object? score = freezed,
  }) {
    return _then(_$DoctorModelInConsultationModelResponseImpl(
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      specialty: freezed == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      syndicateCard: freezed == syndicateCard
          ? _value.syndicateCard
          : syndicateCard // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
      patientsCount: freezed == patientsCount
          ? _value.patientsCount
          : patientsCount // ignore: cast_nullable_to_non_nullable
              as String?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorModelInConsultationModelResponseImpl
    with DiagnosticableTreeMixin
    implements _DoctorModelInConsultationModelResponse {
  const _$DoctorModelInConsultationModelResponseImpl(
      {this.id,
      @JsonKey(name: 'name') this.firstName,
      @JsonKey(name: 'lname') this.lastName,
      this.email,
      this.phone,
      this.specialty,
      this.workingplace,
      this.image,
      @JsonKey(name: 'syndicate_card') this.syndicateCard,
      this.isSyndicateCardRequired,
      @JsonKey(name: 'patients_count') this.patientsCount,
      this.score});

  factory _$DoctorModelInConsultationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DoctorModelInConsultationModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'name')
  final String? firstName;
  @override
  @JsonKey(name: 'lname')
  final String? lastName;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? specialty;
  @override
  final String? workingplace;
  @override
  final String? image;
  @override
  @JsonKey(name: 'syndicate_card')
  final String? syndicateCard;
  @override
  final String? isSyndicateCardRequired;
  @override
  @JsonKey(name: 'patients_count')
  final String? patientsCount;
  @override
  final String? score;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DoctorModelInConsultationModelResponse(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, specialty: $specialty, workingplace: $workingplace, image: $image, syndicateCard: $syndicateCard, isSyndicateCardRequired: $isSyndicateCardRequired, patientsCount: $patientsCount, score: $score)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'DoctorModelInConsultationModelResponse'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('specialty', specialty))
      ..add(DiagnosticsProperty('workingplace', workingplace))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('syndicateCard', syndicateCard))
      ..add(DiagnosticsProperty(
          'isSyndicateCardRequired', isSyndicateCardRequired))
      ..add(DiagnosticsProperty('patientsCount', patientsCount))
      ..add(DiagnosticsProperty('score', score));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorModelInConsultationModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty) &&
            (identical(other.workingplace, workingplace) ||
                other.workingplace == workingplace) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.syndicateCard, syndicateCard) ||
                other.syndicateCard == syndicateCard) &&
            (identical(
                    other.isSyndicateCardRequired, isSyndicateCardRequired) ||
                other.isSyndicateCardRequired == isSyndicateCardRequired) &&
            (identical(other.patientsCount, patientsCount) ||
                other.patientsCount == patientsCount) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firstName,
      lastName,
      email,
      phone,
      specialty,
      workingplace,
      image,
      syndicateCard,
      isSyndicateCardRequired,
      patientsCount,
      score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorModelInConsultationModelResponseImplCopyWith<
          _$DoctorModelInConsultationModelResponseImpl>
      get copyWith =>
          __$$DoctorModelInConsultationModelResponseImplCopyWithImpl<
              _$DoctorModelInConsultationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorModelInConsultationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _DoctorModelInConsultationModelResponse
    implements DoctorModelInConsultationModelResponse {
  const factory _DoctorModelInConsultationModelResponse(
      {final int? id,
      @JsonKey(name: 'name') final String? firstName,
      @JsonKey(name: 'lname') final String? lastName,
      final String? email,
      final String? phone,
      final String? specialty,
      final String? workingplace,
      final String? image,
      @JsonKey(name: 'syndicate_card') final String? syndicateCard,
      final String? isSyndicateCardRequired,
      @JsonKey(name: 'patients_count') final String? patientsCount,
      final String? score}) = _$DoctorModelInConsultationModelResponseImpl;

  factory _DoctorModelInConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$DoctorModelInConsultationModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'name')
  String? get firstName;
  @override
  @JsonKey(name: 'lname')
  String? get lastName;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get specialty;
  @override
  String? get workingplace;
  @override
  String? get image;
  @override
  @JsonKey(name: 'syndicate_card')
  String? get syndicateCard;
  @override
  String? get isSyndicateCardRequired;
  @override
  @JsonKey(name: 'patients_count')
  String? get patientsCount;
  @override
  String? get score;
  @override
  @JsonKey(ignore: true)
  _$$DoctorModelInConsultationModelResponseImplCopyWith<
          _$DoctorModelInConsultationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
