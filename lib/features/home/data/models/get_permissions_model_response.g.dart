// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_permissions_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPermissionsModelResponseImpl _$$GetPermissionsModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetPermissionsModelResponseImpl(
      value: json['value'] as bool?,
      message: json['message'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$GetPermissionsModelResponseImplToJson(
        _$GetPermissionsModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
      'permissions': instance.permissions,
    };
