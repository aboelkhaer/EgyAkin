// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'change_language_model_response.freezed.dart';
part 'change_language_model_response.g.dart';

@freezed
class ChangeLanguageModelResponse with _$ChangeLanguageModelResponse {
  const factory ChangeLanguageModelResponse({
    String? message,
  }) = _ChangeLanguageModelResponse;
  factory ChangeLanguageModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangeLanguageModelResponseFromJson(json);
}
