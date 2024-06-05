// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_patient_section_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPatientSectionDetailsModelResponseImpl
    _$$GetPatientSectionDetailsModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GetPatientSectionDetailsModelResponseImpl(
          value: json['value'] as bool?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$GetPatientSectionDetailsModelResponseImplToJson(
        _$GetPatientSectionDetailsModelResponseImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.data,
    };
