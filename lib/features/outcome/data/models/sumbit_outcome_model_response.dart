// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'sumbit_outcome_model_response.freezed.dart';
part 'sumbit_outcome_model_response.g.dart';

@freezed
class SubmitOutcomeModelResponse with _$SubmitOutcomeModelResponse {
  const factory SubmitOutcomeModelResponse({
    bool? value,
    String? message,
  }) = _SubmitOutcomeModelResponse;
  factory SubmitOutcomeModelResponse.fromJson(Map<String, dynamic> json) =>
      _$SubmitOutcomeModelResponseFromJson(json);
}
