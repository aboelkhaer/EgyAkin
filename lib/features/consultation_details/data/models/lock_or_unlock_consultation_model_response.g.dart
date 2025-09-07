// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lock_or_unlock_consultation_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LockOrUnlockConsultationModelResponseImpl
    _$$LockOrUnlockConsultationModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$LockOrUnlockConsultationModelResponseImpl(
          message: json['message'] as String?,
          data: json['data'] == null
              ? null
              : LockOrUnlockConsultationModelResponseData.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$LockOrUnlockConsultationModelResponseImplToJson(
        _$LockOrUnlockConsultationModelResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

_$LockOrUnlockConsultationModelResponseDataImpl
    _$$LockOrUnlockConsultationModelResponseDataImplFromJson(
            Map<String, dynamic> json) =>
        _$LockOrUnlockConsultationModelResponseDataImpl(
          consultationId: (json['consultation_id'] as num?)?.toInt(),
          isOpen: json['is_open'] as bool?,
        );

Map<String, dynamic> _$$LockOrUnlockConsultationModelResponseDataImplToJson(
        _$LockOrUnlockConsultationModelResponseDataImpl instance) =>
    <String, dynamic>{
      'consultation_id': instance.consultationId,
      'is_open': instance.isOpen,
    };
