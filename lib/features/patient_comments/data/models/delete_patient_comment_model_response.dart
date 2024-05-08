import 'package:freezed_annotation/freezed_annotation.dart';
part 'delete_patient_comment_model_response.freezed.dart';
part 'delete_patient_comment_model_response.g.dart';

@freezed
class DeletePatientCommentsModelResponse
    with _$DeletePatientCommentsModelResponse {
  const factory DeletePatientCommentsModelResponse({
    String? message,
  }) = _DeletePatientCommentsModelResponse;
  factory DeletePatientCommentsModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DeletePatientCommentsModelResponseFromJson(json);
}
