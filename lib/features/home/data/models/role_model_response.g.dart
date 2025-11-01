// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoleModelImpl _$$RoleModelImplFromJson(Map<String, dynamic> json) =>
    _$RoleModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => PermissionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RoleModelImplToJson(_$RoleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'permissions': instance.permissions,
    };

_$PermissionModelImpl _$$PermissionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PermissionModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: json['category'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$PermissionModelImplToJson(
        _$PermissionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'description': instance.description,
    };
