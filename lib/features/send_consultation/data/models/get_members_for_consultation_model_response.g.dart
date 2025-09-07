// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_members_for_consultation_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetMembersForConsultationModelResponseImpl
    _$$GetMembersForConsultationModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetMembersForConsultationModelResponseImpl(
          value: json['value'] as bool?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => DoctorModelInConsultationModelResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetMembersForConsultationModelResponseImplToJson(
        _$GetMembersForConsultationModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };
