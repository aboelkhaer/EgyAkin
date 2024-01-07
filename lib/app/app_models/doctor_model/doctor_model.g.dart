// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
      id: json['id'] as int?,
      firstName: json['name'] as String?,
      lastName: json['lname'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'] as String?,
      age: json['age'] as String?,
      specialty: json['specialty'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
      workingPlace: json['workingplace'] as String?,
      phone: json['phone'] as String?,
      job: json['job'] as String?,
      highestDegree: json['highestdegree'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    )..registrationNumber = json['registration_number'] as String?;

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.firstName,
      'lname': instance.lastName,
      'email': instance.email,
      'emailVerifiedAt': instance.emailVerifiedAt,
      'age': instance.age,
      'specialty': instance.specialty,
      'password_confirmation': instance.passwordConfirmation,
      'workingplace': instance.workingPlace,
      'phone': instance.phone,
      'job': instance.job,
      'registration_number': instance.registrationNumber,
      'highestdegree': instance.highestDegree,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
