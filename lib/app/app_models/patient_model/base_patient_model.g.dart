// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePatientModel _$BasePatientModelFromJson(Map<String, dynamic> json) =>
    BasePatientModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      hospital: json['hospital'] as String?,
      updatedAt: json['updated_at'] as String?,
      doctorModel: json['doctor'] == null
          ? null
          : BaseDoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
    )
      ..governorate = json['governorate'] as String?
      ..sections = json['sections'] == null
          ? null
          : SimpleSectionModel.fromJson(
              json['sections'] as Map<String, dynamic>);

Map<String, dynamic> _$BasePatientModelToJson(BasePatientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hospital': instance.hospital,
      'governorate': instance.governorate,
      'updated_at': instance.updatedAt,
      'doctor': instance.doctorModel,
      'sections': instance.sections,
    };

SimpleSectionModel _$SimpleSectionModelFromJson(Map<String, dynamic> json) =>
    SimpleSectionModel(
      submitStatus: json['submit_status'] as bool?,
      outcomeStatus: json['outcome_status'] as bool?,
    );

Map<String, dynamic> _$SimpleSectionModelToJson(SimpleSectionModel instance) =>
    <String, dynamic>{
      'submit_status': instance.submitStatus,
      'outcome_status': instance.outcomeStatus,
    };
