// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePostModel _$BasePostModelFromJson(Map<String, dynamic> json) =>
    BasePostModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      content: json['content'] as String?,
      image: json['image'] as String?,
      hidden: json['hidden'] as bool?,
      doctorId: json['doctor_id'] as String?,
      updatedAt: json['updated_at'] as String?,
      baseDoctorModel: json['doctor'] == null
          ? null
          : BaseDoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BasePostModelToJson(BasePostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'hidden': instance.hidden,
      'doctor_id': instance.doctorId,
      'updated_at': instance.updatedAt,
      'doctor': instance.baseDoctorModel,
    };
