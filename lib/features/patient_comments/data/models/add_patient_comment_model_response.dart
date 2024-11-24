import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_patient_comment_model_response.freezed.dart';
part 'add_patient_comment_model_response.g.dart';

@freezed
class AddPatientCommentsModelResponse with _$AddPatientCommentsModelResponse {
  const factory AddPatientCommentsModelResponse({
    String? message,
  }) = _AddPatientCommentsModelResponse;
  factory AddPatientCommentsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AddPatientCommentsModelResponseFromJson(json);
}
