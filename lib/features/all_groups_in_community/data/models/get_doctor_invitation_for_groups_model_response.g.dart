// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_doctor_invitation_for_groups_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetDoctorInvitationForGroupsModelResponseImpl
    _$$GetDoctorInvitationForGroupsModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetDoctorInvitationForGroupsModelResponseImpl(
          data: json['data'] == null
              ? null
              : GetAllGroupsInCommunityDataModelResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$GetDoctorInvitationForGroupsModelResponseImplToJson(
        _$GetDoctorInvitationForGroupsModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
