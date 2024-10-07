// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_patient_filters_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplyPatientFiltersModelResponseImpl
    _$$ApplyPatientFiltersModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$ApplyPatientFiltersModelResponseImpl(
          data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  PatientHomeDataModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          pagination: json['pagination'] == null
              ? null
              : PaginationFiltersModelResponse.fromJson(
                  json['pagination'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$ApplyPatientFiltersModelResponseImplToJson(
        _$ApplyPatientFiltersModelResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
    };

_$PaginationFiltersModelResponseImpl
    _$$PaginationFiltersModelResponseImplFromJson(Map<String, dynamic> json) =>
        _$PaginationFiltersModelResponseImpl(
          total: (json['total'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$PaginationFiltersModelResponseImplToJson(
        _$PaginationFiltersModelResponseImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
    };
