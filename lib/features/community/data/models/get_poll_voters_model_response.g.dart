// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_poll_voters_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPollVotersModelResponseImpl _$$GetPollVotersModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetPollVotersModelResponseImpl(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$GetPollVotersModelResponseImplToJson(
        _$GetPollVotersModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
    };
