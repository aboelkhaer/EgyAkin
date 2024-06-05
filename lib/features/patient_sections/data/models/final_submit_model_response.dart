// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'final_submit_model_response.freezed.dart';
part 'final_submit_model_response.g.dart';

@freezed
class FinalSubmitModelResponse with _$FinalSubmitModelResponse {
  const factory FinalSubmitModelResponse({
    bool? value,
    String? message,
  }) = _FinalSubmitModelResponse;
  factory FinalSubmitModelResponse.fromJson(Map<String, dynamic> json) =>
      _$FinalSubmitModelResponseFromJson(json);
}
