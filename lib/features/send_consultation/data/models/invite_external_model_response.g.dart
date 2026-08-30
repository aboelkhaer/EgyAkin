// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_external_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InviteExternalModelResponseImpl _$$InviteExternalModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$InviteExternalModelResponseImpl(
      value: json['value'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : InviteExternalData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InviteExternalModelResponseImplToJson(
        _$InviteExternalModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
      'data': instance.data,
    };

_$InviteExternalDataImpl _$$InviteExternalDataImplFromJson(
        Map<String, dynamic> json) =>
    _$InviteExternalDataImpl(
      inviteId: (json['invite_id'] as num?)?.toInt(),
      consultationId: (json['consultation_id'] as num?)?.toInt(),
      email: json['email'] as String?,
      expiresAt: json['expires_at'] as String?,
      existingUserId: (json['existing_user_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$InviteExternalDataImplToJson(
        _$InviteExternalDataImpl instance) =>
    <String, dynamic>{
      'invite_id': instance.inviteId,
      'consultation_id': instance.consultationId,
      'email': instance.email,
      'expires_at': instance.expiresAt,
      'existing_user_id': instance.existingUserId,
    };
