// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDoctorModel _$BaseDoctorModelFromJson(Map<String, dynamic> json) =>
    BaseDoctorModel(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['name'] as String?,
      lastName: json['lname'] as String?,
      workingPlace: json['workingplace'] as String?,
    );

Map<String, dynamic> _$BaseDoctorModelToJson(BaseDoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.firstName,
      'lname': instance.lastName,
      'workingplace': instance.workingPlace,
    };
