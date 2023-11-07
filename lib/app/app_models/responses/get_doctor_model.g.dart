// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDoctorModelResponse _$GetDoctorModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetDoctorModelResponse(
      doctorModel: json['data'] == null
          ? null
          : DoctorModel.fromJson(json['data'] as Map<String, dynamic>),
    )..value = json['value'] as bool?;

Map<String, dynamic> _$GetDoctorModelResponseToJson(
        GetDoctorModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.doctorModel,
    };
