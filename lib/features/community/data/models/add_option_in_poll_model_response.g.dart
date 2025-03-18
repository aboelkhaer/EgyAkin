// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_option_in_poll_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddOptionInPollModelResponseImpl _$$AddOptionInPollModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AddOptionInPollModelResponseImpl(
      data: json['data'] == null
          ? null
          : AddOptionInPollDataModelResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$AddOptionInPollModelResponseImplToJson(
        _$AddOptionInPollModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
    };

_$AddOptionInPollDataModelResponseImpl
    _$$AddOptionInPollDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$AddOptionInPollDataModelResponseImpl(
          id: (json['id'] as num?)?.toInt(),
          pollId: json['poll_id'] as String?,
          option: json['option_text'] as String?,
          createdAt: json['created_at'] as String?,
          updatedAt: json['updated_at'] as String?,
        );

Map<String, dynamic> _$$AddOptionInPollDataModelResponseImplToJson(
        _$AddOptionInPollDataModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'poll_id': instance.pollId,
      'option_text': instance.option,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
