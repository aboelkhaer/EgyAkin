// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseCommentModel _$BaseCommentModelFromJson(Map<String, dynamic> json) =>
    BaseCommentModel(
      id: (json['id'] as num?)?.toInt(),
      content: json['content'] as String?,
      updatedAt: json['updated_at'] as String?,
      baseDoctorModel: json['doctor'] == null
          ? null
          : BaseDoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseCommentModelToJson(BaseCommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'updated_at': instance.updatedAt,
      'doctor': instance.baseDoctorModel,
    };
