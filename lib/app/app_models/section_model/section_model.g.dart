// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionModel _$SectionModelFromJson(Map<String, dynamic> json) => SectionModel(
      id: json['id'] as int?,
      ownerId: json['doctor_id'] as int?,
      patientId: json['patient_id'] as int?,
      section1: json['section_1'] as bool?,
      section2: json['section_2'] as bool?,
      section3: json['section_3'] as bool?,
      section4: json['section_4'] as bool?,
      section5: json['section_5'] as bool?,
      section6: json['section_6'] as bool?,
      section7: json['section_7'] as bool?,
      submitStatus: json['submit_status'] as bool?,
      outcomeStatus: json['outcome_status'] as bool?,
      doctorId: json['doc_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$SectionModelToJson(SectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_id': instance.ownerId,
      'patient_id': instance.patientId,
      'section_1': instance.section1,
      'section_2': instance.section2,
      'section_3': instance.section3,
      'section_4': instance.section4,
      'section_5': instance.section5,
      'section_6': instance.section6,
      'section_7': instance.section7,
      'submit_status': instance.submitStatus,
      'outcome_status': instance.outcomeStatus,
      'doc_id': instance.doctorId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
