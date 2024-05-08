// ignore_for_file: invalid_annotation_target

import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_patient_comments_model_response.freezed.dart';
part 'get_patient_comments_model_response.g.dart';

@freezed
class GetPatientCommentsModelResponse with _$GetPatientCommentsModelResponse {
  const factory GetPatientCommentsModelResponse({
    bool? value,
    List<CommentModel>? data,
  }) = _GetPatientCommentsModelResponse;
  factory GetPatientCommentsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPatientCommentsModelResponseFromJson(json);
}
