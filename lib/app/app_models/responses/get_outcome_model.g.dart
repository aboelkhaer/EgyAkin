// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_outcome_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOutcomeModelResponse _$GetOutcomeModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetOutcomeModelResponse(
      getOutcomeDataModelResponse: json['data'] == null
          ? null
          : GetOutcomeDataModelResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    )..value = json['value'] as bool?;

Map<String, dynamic> _$GetOutcomeModelResponseToJson(
        GetOutcomeModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.getOutcomeDataModelResponse,
    };

GetOutcomeDataModelResponse _$GetOutcomeDataModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetOutcomeDataModelResponse(
      doctorId: json['doctor_id'] as String?,
      outcomeOfThePatient: json['outcome_of_the_patient'] as String?,
      creatinineOnDischarge: json['creatinine_on_discharge'] as String?,
      finalStatus: json['final_status'] as String?,
      other: json['other'] as String?,
      duration: json['duration_of_admission'] as String?,
      updateAt: json['update_at'] as String?,
      baseDoctorModel: json['doctor'] == null
          ? null
          : BaseDoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetOutcomeDataModelResponseToJson(
        GetOutcomeDataModelResponse instance) =>
    <String, dynamic>{
      'doctor_id': instance.doctorId,
      'outcome_of_the_patient': instance.outcomeOfThePatient,
      'creatinine_on_discharge': instance.creatinineOnDischarge,
      'duration_of_admission': instance.duration,
      'final_status': instance.finalStatus,
      'other': instance.other,
      'update_at': instance.updateAt,
      'doctor': instance.baseDoctorModel,
    };
