// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModelResponse _$DoctorModelResponseFromJson(Map<String, dynamic> json) =>
    DoctorModelResponse(
      value: json['value'] as bool?,
      doctorModel: json['data'] == null
          ? null
          : DoctorModel.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$DoctorModelResponseToJson(
        DoctorModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.doctorModel,
      'token': instance.token,
    };

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
      id: json['id'] as int?,
      firstName: json['name'] as String?,
      lastName: json['lname'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'] as String?,
      age: json['age'] as int?,
      specialty: json['specialty'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
      workingPlace: json['workingplace'] as String?,
      phone: json['phone'] as String?,
      job: json['job'] as String?,
      highestDegree: json['highestdegree'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

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
      'highestdegree': instance.highestDegree,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

LogoutModel _$LogoutModelFromJson(Map<String, dynamic> json) => LogoutModel(
      value: json['value'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LogoutModelToJson(LogoutModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
