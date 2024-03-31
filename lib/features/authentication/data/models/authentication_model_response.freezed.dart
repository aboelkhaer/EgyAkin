// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthenticationModelResponse _$AuthenticationModelResponseFromJson(
    Map<String, dynamic> json) {
  return _AuthenticationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthenticationModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  DoctorModel? get doctorModel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthenticationModelResponseCopyWith<AuthenticationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationModelResponseCopyWith<$Res> {
  factory $AuthenticationModelResponseCopyWith(
          AuthenticationModelResponse value,
          $Res Function(AuthenticationModelResponse) then) =
      _$AuthenticationModelResponseCopyWithImpl<$Res,
          AuthenticationModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      String? token,
      @JsonKey(name: 'data') DoctorModel? doctorModel});

  $DoctorModelCopyWith<$Res>? get doctorModel;
}

/// @nodoc
class _$AuthenticationModelResponseCopyWithImpl<$Res,
        $Val extends AuthenticationModelResponse>
    implements $AuthenticationModelResponseCopyWith<$Res> {
  _$AuthenticationModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? token = freezed,
    Object? doctorModel = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorModel: freezed == doctorModel
          ? _value.doctorModel
          : doctorModel // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DoctorModelCopyWith<$Res>? get doctorModel {
    if (_value.doctorModel == null) {
      return null;
    }

    return $DoctorModelCopyWith<$Res>(_value.doctorModel!, (value) {
      return _then(_value.copyWith(doctorModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthenticationModelResponseImplCopyWith<$Res>
    implements $AuthenticationModelResponseCopyWith<$Res> {
  factory _$$AuthenticationModelResponseImplCopyWith(
          _$AuthenticationModelResponseImpl value,
          $Res Function(_$AuthenticationModelResponseImpl) then) =
      __$$AuthenticationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      String? token,
      @JsonKey(name: 'data') DoctorModel? doctorModel});

  @override
  $DoctorModelCopyWith<$Res>? get doctorModel;
}

/// @nodoc
class __$$AuthenticationModelResponseImplCopyWithImpl<$Res>
    extends _$AuthenticationModelResponseCopyWithImpl<$Res,
        _$AuthenticationModelResponseImpl>
    implements _$$AuthenticationModelResponseImplCopyWith<$Res> {
  __$$AuthenticationModelResponseImplCopyWithImpl(
      _$AuthenticationModelResponseImpl _value,
      $Res Function(_$AuthenticationModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? token = freezed,
    Object? doctorModel = freezed,
  }) {
    return _then(_$AuthenticationModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorModel: freezed == doctorModel
          ? _value.doctorModel
          : doctorModel // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthenticationModelResponseImpl
    with DiagnosticableTreeMixin
    implements _AuthenticationModelResponse {
  const _$AuthenticationModelResponseImpl(
      {this.value, this.token, @JsonKey(name: 'data') this.doctorModel});

  factory _$AuthenticationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AuthenticationModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? token;
  @override
  @JsonKey(name: 'data')
  final DoctorModel? doctorModel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthenticationModelResponse(value: $value, token: $token, doctorModel: $doctorModel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthenticationModelResponse'))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('doctorModel', doctorModel));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.doctorModel, doctorModel) ||
                other.doctorModel == doctorModel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, token, doctorModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationModelResponseImplCopyWith<_$AuthenticationModelResponseImpl>
      get copyWith => __$$AuthenticationModelResponseImplCopyWithImpl<
          _$AuthenticationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthenticationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AuthenticationModelResponse
    implements AuthenticationModelResponse {
  const factory _AuthenticationModelResponse(
          {final bool? value,
          final String? token,
          @JsonKey(name: 'data') final DoctorModel? doctorModel}) =
      _$AuthenticationModelResponseImpl;

  factory _AuthenticationModelResponse.fromJson(Map<String, dynamic> json) =
      _$AuthenticationModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get token;
  @override
  @JsonKey(name: 'data')
  DoctorModel? get doctorModel;
  @override
  @JsonKey(ignore: true)
  _$$AuthenticationModelResponseImplCopyWith<_$AuthenticationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) {
  return _DoctorModel.fromJson(json);
}

/// @nodoc
mixin _$DoctorModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lname')
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get age => throw _privateConstructorUsedError;
  String? get specialty => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get job => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'password_confirmation')
  String? get passwordConfirmation => throw _privateConstructorUsedError;
  @JsonKey(name: 'syndicate_card')
  String? get syndicateCard => throw _privateConstructorUsedError;
  String? get highestdegree => throw _privateConstructorUsedError;
  @JsonKey(name: 'registration_number')
  String? get registrationNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'email_verified_at')
  String? get emailVerifiedAt => throw _privateConstructorUsedError;
  bool? get blocked => throw _privateConstructorUsedError;
  bool? get limited => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoctorModelCopyWith<DoctorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorModelCopyWith<$Res> {
  factory $DoctorModelCopyWith(
          DoctorModel value, $Res Function(DoctorModel) then) =
      _$DoctorModelCopyWithImpl<$Res, DoctorModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? email,
      String? age,
      String? specialty,
      String? token,
      String? password,
      String? workingplace,
      String? phone,
      String? job,
      String? gender,
      String? image,
      @JsonKey(name: 'password_confirmation') String? passwordConfirmation,
      @JsonKey(name: 'syndicate_card') String? syndicateCard,
      String? highestdegree,
      @JsonKey(name: 'registration_number') String? registrationNumber,
      @JsonKey(name: 'email_verified_at') String? emailVerifiedAt,
      bool? blocked,
      bool? limited,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$DoctorModelCopyWithImpl<$Res, $Val extends DoctorModel>
    implements $DoctorModelCopyWith<$Res> {
  _$DoctorModelCopyWithImpl(this._value, this._then);

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
    Object? age = freezed,
    Object? specialty = freezed,
    Object? token = freezed,
    Object? password = freezed,
    Object? workingplace = freezed,
    Object? phone = freezed,
    Object? job = freezed,
    Object? gender = freezed,
    Object? image = freezed,
    Object? passwordConfirmation = freezed,
    Object? syndicateCard = freezed,
    Object? highestdegree = freezed,
    Object? registrationNumber = freezed,
    Object? emailVerifiedAt = freezed,
    Object? blocked = freezed,
    Object? limited = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      specialty: freezed == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordConfirmation: freezed == passwordConfirmation
          ? _value.passwordConfirmation
          : passwordConfirmation // ignore: cast_nullable_to_non_nullable
              as String?,
      syndicateCard: freezed == syndicateCard
          ? _value.syndicateCard
          : syndicateCard // ignore: cast_nullable_to_non_nullable
              as String?,
      highestdegree: freezed == highestdegree
          ? _value.highestdegree
          : highestdegree // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      blocked: freezed == blocked
          ? _value.blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      limited: freezed == limited
          ? _value.limited
          : limited // ignore: cast_nullable_to_non_nullable
              as bool?,
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
abstract class _$$DoctorModelImplCopyWith<$Res>
    implements $DoctorModelCopyWith<$Res> {
  factory _$$DoctorModelImplCopyWith(
          _$DoctorModelImpl value, $Res Function(_$DoctorModelImpl) then) =
      __$$DoctorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? email,
      String? age,
      String? specialty,
      String? token,
      String? password,
      String? workingplace,
      String? phone,
      String? job,
      String? gender,
      String? image,
      @JsonKey(name: 'password_confirmation') String? passwordConfirmation,
      @JsonKey(name: 'syndicate_card') String? syndicateCard,
      String? highestdegree,
      @JsonKey(name: 'registration_number') String? registrationNumber,
      @JsonKey(name: 'email_verified_at') String? emailVerifiedAt,
      bool? blocked,
      bool? limited,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$DoctorModelImplCopyWithImpl<$Res>
    extends _$DoctorModelCopyWithImpl<$Res, _$DoctorModelImpl>
    implements _$$DoctorModelImplCopyWith<$Res> {
  __$$DoctorModelImplCopyWithImpl(
      _$DoctorModelImpl _value, $Res Function(_$DoctorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? age = freezed,
    Object? specialty = freezed,
    Object? token = freezed,
    Object? password = freezed,
    Object? workingplace = freezed,
    Object? phone = freezed,
    Object? job = freezed,
    Object? gender = freezed,
    Object? image = freezed,
    Object? passwordConfirmation = freezed,
    Object? syndicateCard = freezed,
    Object? highestdegree = freezed,
    Object? registrationNumber = freezed,
    Object? emailVerifiedAt = freezed,
    Object? blocked = freezed,
    Object? limited = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DoctorModelImpl(
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
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
      specialty: freezed == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordConfirmation: freezed == passwordConfirmation
          ? _value.passwordConfirmation
          : passwordConfirmation // ignore: cast_nullable_to_non_nullable
              as String?,
      syndicateCard: freezed == syndicateCard
          ? _value.syndicateCard
          : syndicateCard // ignore: cast_nullable_to_non_nullable
              as String?,
      highestdegree: freezed == highestdegree
          ? _value.highestdegree
          : highestdegree // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      blocked: freezed == blocked
          ? _value.blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      limited: freezed == limited
          ? _value.limited
          : limited // ignore: cast_nullable_to_non_nullable
              as bool?,
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
class _$DoctorModelImpl with DiagnosticableTreeMixin implements _DoctorModel {
  const _$DoctorModelImpl(
      {this.id,
      @JsonKey(name: 'name') this.firstName,
      @JsonKey(name: 'lname') this.lastName,
      this.email,
      this.age,
      this.specialty,
      this.token,
      this.password,
      this.workingplace,
      this.phone,
      this.job,
      this.gender,
      this.image,
      @JsonKey(name: 'password_confirmation') this.passwordConfirmation,
      @JsonKey(name: 'syndicate_card') this.syndicateCard,
      this.highestdegree,
      @JsonKey(name: 'registration_number') this.registrationNumber,
      @JsonKey(name: 'email_verified_at') this.emailVerifiedAt,
      this.blocked,
      this.limited,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$DoctorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorModelImplFromJson(json);

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
  final String? age;
  @override
  final String? specialty;
  @override
  final String? token;
  @override
  final String? password;
  @override
  final String? workingplace;
  @override
  final String? phone;
  @override
  final String? job;
  @override
  final String? gender;
  @override
  final String? image;
  @override
  @JsonKey(name: 'password_confirmation')
  final String? passwordConfirmation;
  @override
  @JsonKey(name: 'syndicate_card')
  final String? syndicateCard;
  @override
  final String? highestdegree;
  @override
  @JsonKey(name: 'registration_number')
  final String? registrationNumber;
  @override
  @JsonKey(name: 'email_verified_at')
  final String? emailVerifiedAt;
  @override
  final bool? blocked;
  @override
  final bool? limited;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DoctorModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, age: $age, specialty: $specialty, token: $token, password: $password, workingplace: $workingplace, phone: $phone, job: $job, gender: $gender, image: $image, passwordConfirmation: $passwordConfirmation, syndicateCard: $syndicateCard, highestdegree: $highestdegree, registrationNumber: $registrationNumber, emailVerifiedAt: $emailVerifiedAt, blocked: $blocked, limited: $limited, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DoctorModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('age', age))
      ..add(DiagnosticsProperty('specialty', specialty))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('workingplace', workingplace))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('job', job))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('passwordConfirmation', passwordConfirmation))
      ..add(DiagnosticsProperty('syndicateCard', syndicateCard))
      ..add(DiagnosticsProperty('highestdegree', highestdegree))
      ..add(DiagnosticsProperty('registrationNumber', registrationNumber))
      ..add(DiagnosticsProperty('emailVerifiedAt', emailVerifiedAt))
      ..add(DiagnosticsProperty('blocked', blocked))
      ..add(DiagnosticsProperty('limited', limited))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.workingplace, workingplace) ||
                other.workingplace == workingplace) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.passwordConfirmation, passwordConfirmation) ||
                other.passwordConfirmation == passwordConfirmation) &&
            (identical(other.syndicateCard, syndicateCard) ||
                other.syndicateCard == syndicateCard) &&
            (identical(other.highestdegree, highestdegree) ||
                other.highestdegree == highestdegree) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.emailVerifiedAt, emailVerifiedAt) ||
                other.emailVerifiedAt == emailVerifiedAt) &&
            (identical(other.blocked, blocked) || other.blocked == blocked) &&
            (identical(other.limited, limited) || other.limited == limited) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        firstName,
        lastName,
        email,
        age,
        specialty,
        token,
        password,
        workingplace,
        phone,
        job,
        gender,
        image,
        passwordConfirmation,
        syndicateCard,
        highestdegree,
        registrationNumber,
        emailVerifiedAt,
        blocked,
        limited,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorModelImplCopyWith<_$DoctorModelImpl> get copyWith =>
      __$$DoctorModelImplCopyWithImpl<_$DoctorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorModelImplToJson(
      this,
    );
  }
}

abstract class _DoctorModel implements DoctorModel {
  const factory _DoctorModel(
      {final int? id,
      @JsonKey(name: 'name') final String? firstName,
      @JsonKey(name: 'lname') final String? lastName,
      final String? email,
      final String? age,
      final String? specialty,
      final String? token,
      final String? password,
      final String? workingplace,
      final String? phone,
      final String? job,
      final String? gender,
      final String? image,
      @JsonKey(name: 'password_confirmation')
      final String? passwordConfirmation,
      @JsonKey(name: 'syndicate_card') final String? syndicateCard,
      final String? highestdegree,
      @JsonKey(name: 'registration_number') final String? registrationNumber,
      @JsonKey(name: 'email_verified_at') final String? emailVerifiedAt,
      final bool? blocked,
      final bool? limited,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at')
      final String? updatedAt}) = _$DoctorModelImpl;

  factory _DoctorModel.fromJson(Map<String, dynamic> json) =
      _$DoctorModelImpl.fromJson;

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
  String? get age;
  @override
  String? get specialty;
  @override
  String? get token;
  @override
  String? get password;
  @override
  String? get workingplace;
  @override
  String? get phone;
  @override
  String? get job;
  @override
  String? get gender;
  @override
  String? get image;
  @override
  @JsonKey(name: 'password_confirmation')
  String? get passwordConfirmation;
  @override
  @JsonKey(name: 'syndicate_card')
  String? get syndicateCard;
  @override
  String? get highestdegree;
  @override
  @JsonKey(name: 'registration_number')
  String? get registrationNumber;
  @override
  @JsonKey(name: 'email_verified_at')
  String? get emailVerifiedAt;
  @override
  bool? get blocked;
  @override
  bool? get limited;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DoctorModelImplCopyWith<_$DoctorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
