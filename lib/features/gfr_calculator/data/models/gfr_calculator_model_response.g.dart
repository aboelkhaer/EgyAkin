// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gfr_calculator_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GFRCalculatorModelResponseImpl _$$GFRCalculatorModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GFRCalculatorModelResponseImpl(
      age: json['age'] as String?,
      creatinine: json['creatinine'] as String?,
      gender: json['gender'] as String?,
      equationType: json['equationType'] as String?,
      weight: json['weight'] as String?,
      height: json['height'] as String?,
    );

Map<String, dynamic> _$$GFRCalculatorModelResponseImplToJson(
        _$GFRCalculatorModelResponseImpl instance) =>
    <String, dynamic>{
      'age': instance.age,
      'creatinine': instance.creatinine,
      'gender': instance.gender,
      'equationType': instance.equationType,
      'weight': instance.weight,
      'height': instance.height,
    };

_$GFRCalculatorHistoryModelResponseImpl
    _$$GFRCalculatorHistoryModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GFRCalculatorHistoryModelResponseImpl(
          age: json['age'] as String?,
          creatinine: json['creatinine'] as String?,
          cystatin: json['cystatin'] as String?,
          gender: json['gender'] as String?,
          result: json['result'] as String?,
          date: json['date'] as String?,
          weight: json['weight'] as String?,
          height: json['height'] as String?,
          equationType: json['equationType'] as String?,
        );

Map<String, dynamic> _$$GFRCalculatorHistoryModelResponseImplToJson(
        _$GFRCalculatorHistoryModelResponseImpl instance) =>
    <String, dynamic>{
      'age': instance.age,
      'creatinine': instance.creatinine,
      'cystatin': instance.cystatin,
      'gender': instance.gender,
      'result': instance.result,
      'date': instance.date,
      'weight': instance.weight,
      'height': instance.height,
      'equationType': instance.equationType,
    };
