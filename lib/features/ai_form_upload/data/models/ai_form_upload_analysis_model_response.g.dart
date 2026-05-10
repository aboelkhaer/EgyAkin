// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_form_upload_analysis_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiFormUploadAnalysisModelResponseImpl
    _$$AiFormUploadAnalysisModelResponseImplFromJson(
            Map<String, dynamic> json) =>
        _$AiFormUploadAnalysisModelResponseImpl(
          extractedText: json['extracted_text'] as String?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$AiFormUploadAnalysisModelResponseImplToJson(
        _$AiFormUploadAnalysisModelResponseImpl instance) =>
    <String, dynamic>{
      'extracted_text': instance.extractedText,
      'data': instance.data,
    };
