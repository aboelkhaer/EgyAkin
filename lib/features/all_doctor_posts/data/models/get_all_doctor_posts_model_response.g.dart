// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_doctor_posts_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetAllDoctorPostsModelResponseImpl
    _$$GetAllDoctorPostsModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$GetAllDoctorPostsModelResponseImpl(
          data: json['data'] == null
              ? null
              : GetPostsCommunityDataModelResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$GetAllDoctorPostsModelResponseImplToJson(
        _$GetAllDoctorPostsModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
