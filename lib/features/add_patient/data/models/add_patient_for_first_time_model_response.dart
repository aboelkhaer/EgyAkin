// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_patient_for_first_time_model_response.freezed.dart';
part 'add_patient_for_first_time_model_response.g.dart';

@freezed
class AddPatientForFirstTimeModelResponse
    with _$AddPatientForFirstTimeModelResponse {
  const factory AddPatientForFirstTimeModelResponse({
    int? id,
    String? message,
  }) = _AddPatientForFirstTimeModelResponse;
  factory AddPatientForFirstTimeModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AddPatientForFirstTimeModelResponseFromJson(json);
}
