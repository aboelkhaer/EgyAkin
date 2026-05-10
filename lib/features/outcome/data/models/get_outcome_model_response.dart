// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_outcome_model_response.freezed.dart';
part 'get_outcome_model_response.g.dart';

@freezed
class GetOutcomeModelResponse with _$GetOutcomeModelResponse {
  const factory GetOutcomeModelResponse({
    bool? value,
    List<QuestionModel>? data,
    @JsonKey(name: 'ai_mode') String? aiMode,
    @JsonKey(name: 'ai_hint') String? aiHint,
    @JsonKey(name: 'ai_voice_time') int? aiVoiceTime,
    @JsonKey(name: 'Submitter') OutcomeSubmitterModel? submitter,
  }) = _GetOutcomeModelResponse;
  factory GetOutcomeModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOutcomeModelResponseFromJson(json);
}

@freezed
class OutcomeSubmitterModel with _$OutcomeSubmitterModel {
  const factory OutcomeSubmitterModel({
    String? id,
    String? name,
    String? image,
  }) = _OutcomeSubmitterModel;
  factory OutcomeSubmitterModel.fromJson(Map<String, dynamic> json) =>
      _$OutcomeSubmitterModelFromJson(json);
}
