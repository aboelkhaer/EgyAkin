// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'gfr_calculator_model_response.freezed.dart';
part 'gfr_calculator_model_response.g.dart';

@freezed
class GFRCalculatorModelResponse with _$GFRCalculatorModelResponse {
  const factory GFRCalculatorModelResponse({
    String? age,
    String? creatinine,
    String? gender,
  }) = _GFRCalculatorModelResponse;
  factory GFRCalculatorModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GFRCalculatorModelResponseFromJson(json);
}

@freezed
class GFRCalculatorHistoryModelResponse
    with _$GFRCalculatorHistoryModelResponse {
  const factory GFRCalculatorHistoryModelResponse({
    String? age,
    String? creatinine,
    String? gender,
    String? result,
    String? date,
  }) = _GFRCalculatorHistoryModelResponse;
  factory GFRCalculatorHistoryModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GFRCalculatorHistoryModelResponseFromJson(json);
}
