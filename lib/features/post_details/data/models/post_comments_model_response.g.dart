// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comments_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostCommentsModelResponseImpl _$$PostCommentsModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PostCommentsModelResponseImpl(
      value: json['value'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PostCommentsModelResponseImplToJson(
        _$PostCommentsModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };

_$CommentModelImpl _$$CommentModelImplFromJson(Map<String, dynamic> json) =>
    _$CommentModelImpl(
      id: json['id'] as int?,
      content: json['content'] as String?,
      updatedAt: json['updated_at'] as String?,
      doctor: json['doctor'] == null
          ? null
          : DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CommentModelImplToJson(_$CommentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'updated_at': instance.updatedAt,
      'doctor': instance.doctor,
    };
