// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_patient_history_for_add_patient.freezed.dart';
part 'get_patient_history_for_add_patient.g.dart';

Object? questionAnswerFromJson(Object? json) {
  if (json == null) return null;

  if (json is String) {
    final trimmed = json.trim();
    if (trimmed.isEmpty) return null;
    if (trimmed.startsWith('[') || trimmed.startsWith('{')) {
      try {
        return questionAnswerFromJson(jsonDecode(trimmed));
      } catch (_) {
        return json;
      }
    }
    return json;
  }

  if (json is List) {
    return json.map(_normalizeQuestionAnswerElement).toList();
  }

  if (json is Map) {
    final map = _normalizeQuestionAnswerElement(json) as Map<String, dynamic>;
    if (map.containsKey('timestamp') &&
        (map.containsKey('value') ||
            map.containsKey('val') ||
            map.containsKey('reading'))) {
      return [map];
    }
    for (final key in ['readings', 'items', 'data', 'answers']) {
      final nested = map[key];
      if (nested is List) {
        return nested.map(_normalizeQuestionAnswerElement).toList();
      }
    }
    final keys = map.keys.toList();
    if (keys.isNotEmpty && keys.every((k) => int.tryParse(k) != null)) {
      keys.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
      return keys.map((k) => _normalizeQuestionAnswerElement(map[k])).toList();
    }
    if (map.values.every((v) => v is Map)) {
      return map.values.map(_normalizeQuestionAnswerElement).toList();
    }
  }

  return json;
}

Object? _normalizeQuestionAnswerElement(Object? item) {
  if (item is Map) {
    return Map<String, dynamic>.from(
      item.map((k, v) => MapEntry(k.toString(), v)),
    );
  }
  if (item is String) {
    final trimmed = item.trim();
    if (trimmed.startsWith('{')) {
      try {
        return _normalizeQuestionAnswerElement(jsonDecode(trimmed));
      } catch (_) {}
    }
  }
  return item;
}

Object? questionAnswerToJson(Object? answer) => answer;

@freezed
class GetPatientHistoryForAddPatientModelResponse
    with _$GetPatientHistoryForAddPatientModelResponse {
  const factory GetPatientHistoryForAddPatientModelResponse({
    bool? value,
    @JsonKey(name: 'ai_hint') String? aiHint,
    @JsonKey(name: 'ai_voice_time') int? aiVoiceTime,
    List<QuestionModel>? data,
  }) = _GetPatientHistoryForAddPatientModelResponse;
  factory GetPatientHistoryForAddPatientModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetPatientHistoryForAddPatientModelResponseFromJson(json);
}

@freezed
class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    int? id,
    String? question,
    List<dynamic>? values,
    String? type,
    @JsonKey(name: 'keyboard_type') String? keyboardType,
    bool? mandatory,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(fromJson: questionAnswerFromJson, toJson: questionAnswerToJson)
    dynamic answer,
  }) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
}

// @freezed
// class StringQuestionModel extends QuestionModel with _$StringQuestionModel {
//   const factory StringQuestionModel({
//     String answer,
//   }) = _StringQuestionModel;

//   factory StringQuestionModel.fromJson(Map<String, dynamic> json) =>
//       _$StringQuestionModelFromJson(json);
// }
