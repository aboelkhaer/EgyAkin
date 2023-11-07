// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutModel _$LogoutModelFromJson(Map<String, dynamic> json) => LogoutModel(
      message: json['message'] as String?,
    )..value = json['value'] as bool?;

Map<String, dynamic> _$LogoutModelToJson(LogoutModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
    };
