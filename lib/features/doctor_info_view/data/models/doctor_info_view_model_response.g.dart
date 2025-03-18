// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_info_view_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorInfoViewModelResponseImpl _$$DoctorInfoViewModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DoctorInfoViewModelResponseImpl(
      patientCount: json['patient_count'] as String?,
      scoreValue: json['score_value'] as String?,
      postsCount: json['posts_count'] as String?,
      savedPostsCount: json['saved_posts_count'] as String?,
      data: json['data'] == null
          ? null
          : DoctorModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DoctorInfoViewModelResponseImplToJson(
        _$DoctorInfoViewModelResponseImpl instance) =>
    <String, dynamic>{
      'patient_count': instance.patientCount,
      'score_value': instance.scoreValue,
      'posts_count': instance.postsCount,
      'saved_posts_count': instance.savedPostsCount,
      'data': instance.data,
    };
