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
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => GetPatientSectionsDataModelResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetPatientSectionsModelResponseImplToJson(
        _$GetPatientSectionsModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'submit_status': instance.submitStatus,
      'patient_name': instance.patientName,
      'doctor_Id': instance.doctorId,
      'data': instance.data,
    };

_$GetPatientSectionsDataModelResponseImpl
    _$$GetPatientSectionsDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetPatientSectionsDataModelResponseImpl(
          sectionId: json['section_id'] as int?,
          sectionStatus: json['section_status'] as bool?,
          updatedAt: json['updated_at'] as String?,
          sectionName: json['section_name'] as String?,
        );

Map<String, dynamic> _$$GetPatientSectionsDataModelResponseImplToJson(
        _$GetPatientSectionsDataModelResponseImpl instance) =>
    <String, dynamic>{
      'section_id': instance.sectionId,
      'section_status': instance.sectionStatus,
      'updated_at': instance.updatedAt,
      'section_name': instance.sectionName,
    };
