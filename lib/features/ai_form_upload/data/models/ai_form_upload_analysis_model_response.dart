// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_form_upload_analysis_model_response.freezed.dart';
part 'ai_form_upload_analysis_model_response.g.dart';

@freezed
class AiFormUploadAnalysisModelResponse with _$AiFormUploadAnalysisModelResponse {
  const factory AiFormUploadAnalysisModelResponse({
    @JsonKey(name: 'extracted_text') String? extractedText,
    List<QuestionModel>? data,
  }) = _AiFormUploadAnalysisModelResponse;

  factory AiFormUploadAnalysisModelResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AiFormUploadAnalysisModelResponseFromJson(json);
}

extension AiFormUploadAnalysisModelResponseX on AiFormUploadAnalysisModelResponse {
  /// Top-level `extracted_text` only (nested `data` holds questions list).
  String? get resolvedExtractedText {
    final top = extractedText;
    if (top != null && top.isNotEmpty) return top;
    return null;
  }

  /// Maps API analysis into the shape expected by [applyVoiceAnswers].
  Map<String, dynamic>? toAnswersMap() {
    final questions = data;
    if (questions != null && questions.isNotEmpty) {
      final map = <String, dynamic>{};
      for (final q in questions) {
        if (q.answer == null) continue;
        final id = q.id;
        if (id != null) {
          map[id.toString()] = q.answer;
        }
        final qText = q.question?.trim().toLowerCase();
        if (qText != null && qText.isNotEmpty) {
          map[qText] = q.answer;
        }
      }
      if (map.isNotEmpty) return map;
    }

    final text = resolvedExtractedText;
    if (text == null || text.isEmpty) return null;
    try {
      final decoded = jsonDecode(text);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (_) {}
    return {'extracted_text': text};
  }
}
