// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ai_consultation_history_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetAiConsultationHistoryModelResponseImpl
    _$$GetAiConsultationHistoryModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetAiConsultationHistoryModelResponseImpl(
          value: json['value'] as bool?,
          message: json['message'] as String?,
          trialCount: (json['trial_count'] as num?)?.toInt(),
          resetDate: json['reset_date'] as String?,
          history: json['history'] == null
              ? null
              : ConsultationHistory.fromJson(
                  json['history'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$GetAiConsultationHistoryModelResponseImplToJson(
        _$GetAiConsultationHistoryModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'message': instance.message,
      'trial_count': instance.trialCount,
      'reset_date': instance.resetDate,
      'history': instance.history,
    };

_$ConsultationHistoryImpl _$$ConsultationHistoryImplFromJson(
        Map<String, dynamic> json) =>
    _$ConsultationHistoryImpl(
      currentPage: (json['current_page'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ConsultationData.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ConsultationHistoryImplToJson(
        _$ConsultationHistoryImpl instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'total': instance.total,
      'last_page': instance.lastPage,
    };

_$ConsultationDataImpl _$$ConsultationDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ConsultationDataImpl(
      id: (json['id'] as num?)?.toInt(),
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      patientId: (json['patient_id'] as num?)?.toInt(),
      question: json['question'] as String?,
      response: json['response'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$ConsultationDataImplToJson(
        _$ConsultationDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_id': instance.doctorId,
      'patient_id': instance.patientId,
      'question': instance.question,
      'response': instance.response,
      'created_at': instance.createdAt,
    };
