// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_doctor_with_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDoctorWithTokenModelResponse _$GetDoctorWithTokenModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetDoctorWithTokenModelResponse(
      doctorModel: json['data'] == null
          ? null
          : DoctorModel.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$GetDoctorWithTokenModelResponseToJson(
        GetDoctorWithTokenModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.doctorModel,
      'token': instance.token,
    };
