// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_response_of_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetResponseOfSearchModelImpl _$$GetResponseOfSearchModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GetResponseOfSearchModelImpl(
      data: json['data'] == null
          ? null
          : GetPostsCommunityDataModelResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetResponseOfSearchModelImplToJson(
        _$GetResponseOfSearchModelImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
