// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_doctor_profile_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateDoctorProfileModelResponseImpl
    _$$UpdateDoctorProfileModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$UpdateDoctorProfileModelResponseImpl(
          data: json['data'] == null
              ? null
              : DoctorModel.fromJson(json['data'] as Map<String, dynamic>),
          message: json['message'] as String?,
        );

Map<String, dynamic> _$$UpdateDoctorProfileModelResponseImplToJson(
        _$UpdateDoctorProfileModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
    };
