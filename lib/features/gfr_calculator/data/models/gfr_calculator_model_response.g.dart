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
    );

Map<String, dynamic> _$$GFRCalculatorModelResponseImplToJson(
        _$GFRCalculatorModelResponseImpl instance) =>
    <String, dynamic>{
      'age': instance.age,
      'creatinine': instance.creatinine,
      'gender': instance.gender,
    };

_$GFRCalculatorHistoryModelResponseImpl
    _$$GFRCalculatorHistoryModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$GFRCalculatorHistoryModelResponseImpl(
          age: json['age'] as String?,
          creatinine: json['creatinine'] as String?,
          gender: json['gender'] as String?,
          result: json['result'] as String?,
          date: json['date'] as String?,
        );

Map<String, dynamic> _$$GFRCalculatorHistoryModelResponseImplToJson(
        _$GFRCalculatorHistoryModelResponseImpl instance) =>
    <String, dynamic>{
      'age': instance.age,
      'creatinine': instance.creatinine,
      'gender': instance.gender,
      'result': instance.result,
      'date': instance.date,
    };
