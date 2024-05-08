// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_outcome_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetOutcomeModelResponseImpl _$$GetOutcomeModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetOutcomeModelResponseImpl(
      value: json['value'] as bool?,
      data: json['data'] == null
          ? null
          : GetOutcomeDataModelResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetOutcomeModelResponseImplToJson(
        _$GetOutcomeModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };

_$GetOutcomeDataModelResponseImpl _$$GetOutcomeDataModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetOutcomeDataModelResponseImpl(
      outcomeOfThePatient: json['outcome_of_the_patient'] as String?,
      creatinineOnDischarge: json['creatinine_on_discharge'] as String?,
      duration: json['duration_of_admission'] as String?,
      finalSubmit: json['final_status'] as String?,
      other: json['other'] as String?,
      updateAt: json['update_at'] as String?,
      doctor: json['doctor'] == null
          ? null
          : DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetOutcomeDataModelResponseImplToJson(
        _$GetOutcomeDataModelResponseImpl instance) =>
    <String, dynamic>{
      'outcome_of_the_patient': instance.outcomeOfThePatient,
      'creatinine_on_discharge': instance.creatinineOnDischarge,
      'duration_of_admission': instance.duration,
      'final_status': instance.finalSubmit,
      'other': instance.other,
      'update_at': instance.updateAt,
      'doctor': instance.doctor,
    };
