// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeModelResponseImpl _$$HomeModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeModelResponseImpl(
      value: json['value'] as bool?,
      verified: json['verified'] as bool?,
      unreadCount: _flexibleStringFromJson(json['unreadCount']),
      isSyndicateCardRequired:
          _flexibleStringFromJson(json['isSyndicateCardRequired']),
      appUpdateMessage: json['app_update_message'],
      doctorPatientCount: _flexibleStringFromJson(json['doctor_patient_count']),
      allPatientCount: _flexibleStringFromJson(json['all_patient_count']),
      scoreValue: _flexibleStringFromJson(json['score_value']),
      role: json['role'] as String?,
      userType: json['user_type'] as String?,
      permissionsChanged: json['permissions_changed'] as bool?,
      isUserBlocked: json['isUserBlocked'] as bool?,
      postsCount: _flexibleStringFromJson(json['posts_count']),
      savedPosts: _flexibleStringFromJson(json['saved_posts_count']),
      markedPatientsCount:
          _flexibleStringFromJson(json['marked_patient_count']),
      pendingOutcomeCount:
          _flexibleStringFromJson(json['pending_outcome_count']),
      draftCount: _flexibleStringFromJson(json['draft_count']),
      researchInsights: json['research_insights'] == null
          ? null
          : ResearchInsightsModel.fromJson(
              json['research_insights'] as Map<String, dynamic>),
      data: json['data'] == null
          ? null
          : HomeDataModelResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HomeModelResponseImplToJson(
        _$HomeModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'verified': instance.verified,
      'unreadCount': instance.unreadCount,
      'isSyndicateCardRequired': instance.isSyndicateCardRequired,
      'app_update_message': instance.appUpdateMessage,
      'doctor_patient_count': instance.doctorPatientCount,
      'all_patient_count': instance.allPatientCount,
      'score_value': instance.scoreValue,
      'role': instance.role,
      'user_type': instance.userType,
      'permissions_changed': instance.permissionsChanged,
      'isUserBlocked': instance.isUserBlocked,
      'posts_count': instance.postsCount,
      'saved_posts_count': instance.savedPosts,
      'marked_patient_count': instance.markedPatientsCount,
      'pending_outcome_count': instance.pendingOutcomeCount,
      'draft_count': instance.draftCount,
      'research_insights': instance.researchInsights,
      'data': instance.data,
    };

_$HomeDataModelResponseImpl _$$HomeDataModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeDataModelResponseImpl(
      allPatients: (json['all_patients'] as List<dynamic>?)
          ?.map((e) => PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPatients: (json['current_patient'] as List<dynamic>?)
          ?.map((e) => PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topDoctors: (json['topDoctors'] as List<dynamic>?)
          ?.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingSyndicateCard: (json['pendingSyndicateCard'] as List<dynamic>?)
          ?.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      feeds: (json['feed_posts'] as List<dynamic>?)
          ?.map((e) => PostCommunityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      trendsHashtags: (json['trending_hashtags'] as List<dynamic>?)
          ?.map((e) => TrendModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      latestGroups: (json['latest_groups'] as List<dynamic>?)
          ?.map((e) => GroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingOutcomes: (json['pending_outcomes'] as List<dynamic>?)
          ?.map((e) => PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      drafts: (json['drafts'] as List<dynamic>?)
          ?.map((e) => PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingConsultations: (json['pending_consultations'] as List<dynamic>?)
          ?.map((e) => GetCurrentDoctorConsultationModelResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      activity: (json['activity'] as List<dynamic>?)
          ?.map((e) => HomeActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      weekRecap: json['week_recap'] == null
          ? null
          : WeekRecapModel.fromJson(json['week_recap'] as Map<String, dynamic>),
      researchInsights: json['research_insights'] == null
          ? null
          : ResearchInsightsModel.fromJson(
              json['research_insights'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HomeDataModelResponseImplToJson(
        _$HomeDataModelResponseImpl instance) =>
    <String, dynamic>{
      'all_patients': instance.allPatients,
      'current_patient': instance.currentPatients,
      'topDoctors': instance.topDoctors,
      'pendingSyndicateCard': instance.pendingSyndicateCard,
      'posts': instance.posts,
      'feed_posts': instance.feeds,
      'trending_hashtags': instance.trendsHashtags,
      'latest_groups': instance.latestGroups,
      'pending_outcomes': instance.pendingOutcomes,
      'drafts': instance.drafts,
      'pending_consultations': instance.pendingConsultations,
      'activity': instance.activity,
      'week_recap': instance.weekRecap,
      'research_insights': instance.researchInsights,
    };

_$ResearchInsightsModelImpl _$$ResearchInsightsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ResearchInsightsModelImpl(
      population: json['population'] == null
          ? null
          : ResearchPopulationModel.fromJson(
              json['population'] as Map<String, dynamic>),
      akiIncidencePct: _flexibleNumFromJson(json['aki_incidence_pct']),
      akiIncidenceDeltaPct:
          _flexibleNumFromJson(json['aki_incidence_delta_pct']),
      mostCommonCause: json['most_common_cause'] as String?,
      mostCommonCausePct: _flexibleNumFromJson(json['most_common_cause_pct']),
      avgEgfrAtAdmission: _flexibleNumFromJson(json['avg_egfr_at_admission']),
      avgEgfrAtAdmissionDelta:
          _flexibleNumFromJson(json['avg_egfr_at_admission_delta']),
      computedAt: json['computed_at'] as String?,
    );

Map<String, dynamic> _$$ResearchInsightsModelImplToJson(
        _$ResearchInsightsModelImpl instance) =>
    <String, dynamic>{
      'population': instance.population,
      'aki_incidence_pct': instance.akiIncidencePct,
      'aki_incidence_delta_pct': instance.akiIncidenceDeltaPct,
      'most_common_cause': instance.mostCommonCause,
      'most_common_cause_pct': instance.mostCommonCausePct,
      'avg_egfr_at_admission': instance.avgEgfrAtAdmission,
      'avg_egfr_at_admission_delta': instance.avgEgfrAtAdmissionDelta,
      'computed_at': instance.computedAt,
    };

_$ResearchPopulationModelImpl _$$ResearchPopulationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ResearchPopulationModelImpl(
      patientCount: _flexibleNumFromJson(json['patient_count']),
      hospitalCount: _flexibleNumFromJson(json['hospital_count']),
    );

Map<String, dynamic> _$$ResearchPopulationModelImplToJson(
        _$ResearchPopulationModelImpl instance) =>
    <String, dynamic>{
      'patient_count': instance.patientCount,
      'hospital_count': instance.hospitalCount,
    };

_$WeekRecapModelImpl _$$WeekRecapModelImplFromJson(Map<String, dynamic> json) =>
    _$WeekRecapModelImpl(
      from: json['from'] as String?,
      to: json['to'] as String?,
      patientsAdded: _flexibleIntFromJson(json['patients_added']),
      allPatientsAdded: _flexibleIntFromJson(json['all_patients_added']),
      outcomesSubmitted: _flexibleIntFromJson(json['outcomes_submitted']),
      pointsEarned:
          _flexibleIntFromJson(_readPointsEarned(json, 'points_earned')),
    );

Map<String, dynamic> _$$WeekRecapModelImplToJson(
        _$WeekRecapModelImpl instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'patients_added': instance.patientsAdded,
      'all_patients_added': instance.allPatientsAdded,
      'outcomes_submitted': instance.outcomesSubmitted,
      'points_earned': instance.pointsEarned,
    };

_$PatientHomeDataModelImpl _$$PatientHomeDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PatientHomeDataModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      hospital: json['hospital'] as String?,
      age: _flexibleNumFromJson(json['age']),
      egfr: _flexibleNumFromJson(json['egfr']),
      egfrPrevious: _flexibleNumFromJson(json['egfr_previous']),
      bmi: _flexibleNumFromJson(json['bmi']),
      updatedAt: json['updated_at'] as String?,
      doctor: json['doctor'] == null
          ? null
          : DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
      sections: json['sections'] == null
          ? null
          : SectionHomeDataModel.fromJson(
              json['sections'] as Map<String, dynamic>),
      sectionsCompleted: (json['sections_completed'] as num?)?.toInt(),
      sectionsTotal: (json['sections_total'] as num?)?.toInt(),
      sectionsLastUpdatedAt: json['sections_last_updated_at'] as String?,
      nextSection: json['next_section'] == null
          ? null
          : NextSectionModel.fromJson(
              json['next_section'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PatientHomeDataModelImplToJson(
        _$PatientHomeDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hospital': instance.hospital,
      'age': instance.age,
      'egfr': instance.egfr,
      'egfr_previous': instance.egfrPrevious,
      'bmi': instance.bmi,
      'updated_at': instance.updatedAt,
      'doctor': instance.doctor,
      'sections': instance.sections,
      'sections_completed': instance.sectionsCompleted,
      'sections_total': instance.sectionsTotal,
      'sections_last_updated_at': instance.sectionsLastUpdatedAt,
      'next_section': instance.nextSection,
    };

_$NextSectionModelImpl _$$NextSectionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NextSectionModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$NextSectionModelImplToJson(
        _$NextSectionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$SectionHomeDataModelImpl _$$SectionHomeDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SectionHomeDataModelImpl(
      patientId: (json['patient_id'] as num?)?.toInt(),
      submitStatus: _flexibleBoolFromJson(json['submit_status']),
      outcomeStatus: _flexibleBoolFromJson(json['outcome_status']),
    );

Map<String, dynamic> _$$SectionHomeDataModelImplToJson(
        _$SectionHomeDataModelImpl instance) =>
    <String, dynamic>{
      'patient_id': instance.patientId,
      'submit_status': instance.submitStatus,
      'outcome_status': instance.outcomeStatus,
    };

_$HomeActivityModelImpl _$$HomeActivityModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeActivityModelImpl(
      id: (json['id'] as num?)?.toInt(),
      actor: json['actor'] == null
          ? null
          : HomeActivityActorModel.fromJson(
              json['actor'] as Map<String, dynamic>),
      verb: json['verb'] as String?,
      target: json['target'] == null
          ? null
          : HomeActivityTargetModel.fromJson(
              json['target'] as Map<String, dynamic>),
      at: json['at'] as String?,
      read: json['read'] as bool?,
    );

Map<String, dynamic> _$$HomeActivityModelImplToJson(
        _$HomeActivityModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actor': instance.actor,
      'verb': instance.verb,
      'target': instance.target,
      'at': instance.at,
      'read': instance.read,
    };

_$HomeActivityActorModelImpl _$$HomeActivityActorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeActivityActorModelImpl(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['name'] as String?,
      lastName: json['lname'] as String?,
      image: json['image'] as String?,
      avatar: json['avatar'] as String?,
      isSyndicateCardRequired: json['isSyndicateCardRequired'] as String?,
    );

Map<String, dynamic> _$$HomeActivityActorModelImplToJson(
        _$HomeActivityActorModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.firstName,
      'lname': instance.lastName,
      'image': instance.image,
      'avatar': instance.avatar,
      'isSyndicateCardRequired': instance.isSyndicateCardRequired,
    };

_$HomeActivityTargetModelImpl _$$HomeActivityTargetModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeActivityTargetModelImpl(
      patientId: (json['patient_id'] as num?)?.toInt(),
      typeId: (json['type_id'] as num?)?.toInt(),
      content: json['content'] as String?,
      localizationKey: json['localization_key'] as String?,
      localizationParams: json['localization_params'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$HomeActivityTargetModelImplToJson(
        _$HomeActivityTargetModelImpl instance) =>
    <String, dynamic>{
      'patient_id': instance.patientId,
      'type_id': instance.typeId,
      'content': instance.content,
      'localization_key': instance.localizationKey,
      'localization_params': instance.localizationParams,
    };
