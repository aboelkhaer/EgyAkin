// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_for_dose_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchForDoseInMedicationSectionModelResponseImpl
    _$$SearchForDoseInMedicationSectionModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$SearchForDoseInMedicationSectionModelResponseImpl(
          data: json['data'] == null
              ? null
              : SearchForDoseInMedicationSectionDataModelResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$SearchForDoseInMedicationSectionModelResponseImplToJson(
        _$SearchForDoseInMedicationSectionModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$SearchForDoseInMedicationSectionDataModelResponseImpl
    _$$SearchForDoseInMedicationSectionDataModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$SearchForDoseInMedicationSectionDataModelResponseImpl(
          data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => DoseModelInSearch.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic>
    _$$SearchForDoseInMedicationSectionDataModelResponseImplToJson(
            _$SearchForDoseInMedicationSectionDataModelResponseImpl instance) =>
        <String, dynamic>{
          'data': instance.data,
        };

_$DoseModelInSearchImpl _$$DoseModelInSearchImplFromJson(
        Map<String, dynamic> json) =>
    _$DoseModelInSearchImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      dose: json['dose'] as String?,
    );

Map<String, dynamic> _$$DoseModelInSearchImplToJson(
        _$DoseModelInSearchImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'dose': instance.dose,
    };
