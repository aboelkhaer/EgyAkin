// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_with_google_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthenticationWithGoogleModelResponseImpl
    _$$AuthenticationWithGoogleModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$AuthenticationWithGoogleModelResponseImpl(
          message: json['message'] as String?,
          data: json['data'] == null
              ? null
              : AuthenticationWithGoogleDataModelResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$AuthenticationWithGoogleModelResponseImplToJson(
        _$AuthenticationWithGoogleModelResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

_$AuthenticationWithGoogleDataModelResponseImpl
    _$$AuthenticationWithGoogleDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$AuthenticationWithGoogleDataModelResponseImpl(
          doctorModel: json['user'] == null
              ? null
              : DoctorModel.fromJson(json['user'] as Map<String, dynamic>),
          token: json['token'] as String?,
          provider: json['provider'] as String?,
          permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
        );

Map<String, dynamic> _$$AuthenticationWithGoogleDataModelResponseImplToJson(
        _$AuthenticationWithGoogleDataModelResponseImpl instance) =>
    <String, dynamic>{
      'user': instance.doctorModel,
      'token': instance.token,
      'provider': instance.provider,
      'permissions': instance.permissions,
    };
