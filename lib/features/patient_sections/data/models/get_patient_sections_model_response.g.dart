// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_patient_sections_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPatientSectionsModelResponseImpl
    _$$GetPatientSectionsModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$GetPatientSectionsModelResponseImpl(
          value: json['value'] as bool?,
          submitStatus: json['submit_status'] as bool?,
          patientName: json['patient_name'] as String?,
          doctorId: json['doctor_Id'] as String?,
          gfr: json['gfr'] == null
              ? null
              : GFRModel.fromJson(json['gfr'] as Map<String, dynamic>),
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => SectionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetPatientSectionsModelResponseImplToJson(
        _$GetPatientSectionsModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'submit_status': instance.submitStatus,
      'patient_name': instance.patientName,
      'doctor_Id': instance.doctorId,
      'gfr': instance.gfr,
      'data': instance.data,
    };

_$SectionModelImpl _$$SectionModelImplFromJson(Map<String, dynamic> json) =>
    _$SectionModelImpl(
      sectionId: (json['section_id'] as num?)?.toInt(),
      sectionStatus: json['section_status'] as bool?,
      updatedAt: json['updated_at'] as String?,
      sectionName: json['section_name'] as String?,
    );

Map<String, dynamic> _$$SectionModelImplToJson(_$SectionModelImpl instance) =>
    <String, dynamic>{
      'section_id': instance.sectionId,
      'section_status': instance.sectionStatus,
      'updated_at': instance.updatedAt,
      'section_name': instance.sectionName,
    };

_$GFRModelImpl _$$GFRModelImplFromJson(Map<String, dynamic> json) =>
    _$GFRModelImpl(
      ckd: json['ckd'] == null
          ? null
          : EquationModel.fromJson(json['ckd'] as Map<String, dynamic>),
      sobh: json['sobh'] == null
          ? null
          : EquationModel.fromJson(json['sobh'] as Map<String, dynamic>),
      mdrd: json['mdrd'] == null
          ? null
          : EquationModel.fromJson(json['mdrd'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GFRModelImplToJson(_$GFRModelImpl instance) =>
    <String, dynamic>{
      'ckd': instance.ckd,
      'sobh': instance.sobh,
      'mdrd': instance.mdrd,
    };

_$EquationModelImpl _$$EquationModelImplFromJson(Map<String, dynamic> json) =>
    _$EquationModelImpl(
      currentGFR: json['current_GFR'] as String?,
      basalCreatinine: json['basal_creatinine_GFR'] as String?,
      creatinineOnDischarge: json['creatinine_on_discharge_GFR'] as String?,
    );

Map<String, dynamic> _$$EquationModelImplToJson(_$EquationModelImpl instance) =>
    <String, dynamic>{
      'current_GFR': instance.currentGFR,
      'basal_creatinine_GFR': instance.basalCreatinine,
      'creatinine_on_discharge_GFR': instance.creatinineOnDischarge,
    };
