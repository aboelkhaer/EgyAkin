// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthenticationModelResponseImpl _$$AuthenticationModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthenticationModelResponseImpl(
      value: json['value'] as bool?,
      token: json['token'] as String?,
      doctorModel: json['data'] == null
          ? null
          : DoctorModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthenticationModelResponseImplToJson(
        _$AuthenticationModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'token': instance.token,
      'data': instance.doctorModel,
    };

_$DoctorModelImpl _$$DoctorModelImplFromJson(Map<String, dynamic> json) =>
    _$DoctorModelImpl(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['name'] as String?,
      lastName: json['lname'] as String?,
      email: json['email'] as String?,
      age: json['age'] as String?,
      specialty: json['specialty'] as String?,
      token: json['token'] as String?,
      password: json['password'] as String?,
      workingplace: json['workingplace'] as String?,
      phone: json['phone'] as String?,
      job: json['job'] as String?,
      gender: json['gender'] as String?,
      image: json['image'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
      syndicateCard: json['syndicate_card'] as String?,
      patientsCount: json['patients_count'] as String?,
      highestdegree: json['highestdegree'] as String?,
      registrationNumber: json['registration_number'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      phoneVerifiedAt: json['phone_verified_at'] as String?,
      blocked: json['blocked'] as bool?,
      limited: json['limited'] as bool?,
      patients: (json['patients'] as List<dynamic>?)
          ?.map((e) => PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$DoctorModelImplToJson(_$DoctorModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.firstName,
      'lname': instance.lastName,
      'email': instance.email,
      'age': instance.age,
      'specialty': instance.specialty,
      'token': instance.token,
      'password': instance.password,
      'workingplace': instance.workingplace,
      'phone': instance.phone,
      'job': instance.job,
      'gender': instance.gender,
      'image': instance.image,
      'password_confirmation': instance.passwordConfirmation,
      'syndicate_card': instance.syndicateCard,
      'patients_count': instance.patientsCount,
      'highestdegree': instance.highestdegree,
      'registration_number': instance.registrationNumber,
      'email_verified_at': instance.emailVerifiedAt,
      'phone_verified_at': instance.phoneVerifiedAt,
      'blocked': instance.blocked,
      'limited': instance.limited,
      'patients': instance.patients,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
