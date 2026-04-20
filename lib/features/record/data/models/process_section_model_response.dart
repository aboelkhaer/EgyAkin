// ignore_for_file: invalid_annotation_target

import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'process_section_model_response.freezed.dart';
part 'process_section_model_response.g.dart';

@freezed
class ProcessSectionModelResponse with _$ProcessSectionModelResponse {
  const factory ProcessSectionModelResponse({
    @JsonKey(name: 'extracted_text') String? extractedText,
    List<QuestionModel>? data,
  }) = _ProcessSectionModelResponse;

  factory ProcessSectionModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ProcessSectionModelResponseFromJson(json);
}

extension ProcessSectionModelResponseX on ProcessSectionModelResponse {
  /// Top-level `extracted_text` only (nested `data` holds questions list).
  String? get resolvedExtractedText {
    final top = extractedText;
    if (top != null && top.isNotEmpty) return top;
    return null;
  }
}
