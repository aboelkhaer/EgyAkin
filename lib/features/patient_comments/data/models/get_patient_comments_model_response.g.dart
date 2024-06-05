// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_patient_comments_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPatientCommentsModelResponseImpl
    _$$GetPatientCommentsModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$GetPatientCommentsModelResponseImpl(
          value: json['value'] as bool?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetPatientCommentsModelResponseImplToJson(
        _$GetPatientCommentsModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };
