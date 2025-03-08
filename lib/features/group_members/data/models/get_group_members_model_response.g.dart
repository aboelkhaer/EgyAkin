// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_group_members_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetGroupMembersModelResponseImpl _$$GetGroupMembersModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetGroupMembersModelResponseImpl(
      data: json['data'] == null
          ? null
          : GetGroupMembersDataModelResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetGroupMembersModelResponseImplToJson(
        _$GetGroupMembersModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$GetGroupMembersDataModelResponseImpl
    _$$GetGroupMembersDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetGroupMembersDataModelResponseImpl(
          currentPage: (json['current_page'] as num?)?.toInt(),
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          firstPageUrl: json['first_page_url'] as String?,
          from: (json['from'] as num?)?.toInt(),
          lastPage: (json['last_page'] as num?)?.toInt(),
          lastPageUrl: json['last_page_url'] as String?,
          links: (json['links'] as List<dynamic>?)
              ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
              .toList(),
          nextPageUrl: json['next_page_url'] as String?,
          path: json['path'] as String?,
          perPage: (json['perPage'] as num?)?.toInt(),
          prevPageUrl: json['prev_page_url'] as String?,
          to: (json['to'] as num?)?.toInt(),
          total: (json['total'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$GetGroupMembersDataModelResponseImplToJson(
        _$GetGroupMembersDataModelResponseImpl instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'links': instance.links,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'perPage': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };
