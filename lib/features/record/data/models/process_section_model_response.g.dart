// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_section_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProcessSectionModelResponseImpl _$$ProcessSectionModelResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProcessSectionModelResponseImpl(
      extractedText: json['extracted_text'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProcessSectionModelResponseImplToJson(
        _$ProcessSectionModelResponseImpl instance) =>
    <String, dynamic>{
      'extracted_text': instance.extractedText,
      'data': instance.data,
    };
