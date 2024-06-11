// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_app_settings_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetAppSettingsModelResponseImpl _$$GetAppSettingsModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetAppSettingsModelResponseImpl(
      appFreeze: json['app_freeze'] as bool?,
      forceUpdate: json['force_update'] as bool?,
    );

Map<String, dynamic> _$$GetAppSettingsModelResponseImplToJson(
        _$GetAppSettingsModelResponseImpl instance) =>
    <String, dynamic>{
      'app_freeze': instance.appFreeze,
      'force_update': instance.forceUpdate,
    };
