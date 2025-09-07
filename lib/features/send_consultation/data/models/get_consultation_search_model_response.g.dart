// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_consultation_search_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetConsultationSearchModelResponseImpl
    _$$GetConsultationSearchModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetConsultationSearchModelResponseImpl(
          value: json['value'] as bool?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => DoctorModelInConsultationModelResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetConsultationSearchModelResponseImplToJson(
        _$GetConsultationSearchModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };

_$DoctorModelInConsultationModelResponseImpl
    _$$DoctorModelInConsultationModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$DoctorModelInConsultationModelResponseImpl(
          id: _parseId(json['id']),
          firstName: json['name'] as String?,
          lastName: json['lname'] as String?,
          email: json['email'] as String?,
          phone: json['phone'] as String?,
          specialty: json['specialty'] as String?,
          workingplace: json['workingplace'] as String?,
          image: json['image'] as String?,
          syndicateCard: json['syndicate_card'] as String?,
          isSyndicateCardRequired: json['isSyndicateCardRequired'] as String?,
          patientsCount: json['patients_count'] as String?,
          score: json['score'] as String?,
          role: json['role'] as String?,
          status: json['status'] as String?,
          isVerified: json['isVerified'] as String?,
        );

Map<String, dynamic> _$$DoctorModelInConsultationModelResponseImplToJson(
        _$DoctorModelInConsultationModelResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.firstName,
      'lname': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'specialty': instance.specialty,
      'workingplace': instance.workingplace,
      'image': instance.image,
      'syndicate_card': instance.syndicateCard,
      'isSyndicateCardRequired': instance.isSyndicateCardRequired,
      'patients_count': instance.patientsCount,
      'score': instance.score,
      'role': instance.role,
      'status': instance.status,
      'isVerified': instance.isVerified,
    };
