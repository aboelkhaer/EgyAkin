// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_doctors_for_consultation_model_response.freezed.dart';
part 'add_doctors_for_consultation_model_response.g.dart';

@freezed
class AddDoctorsForConsultationModelResponse
    with _$AddDoctorsForConsultationModelResponse {
  const factory AddDoctorsForConsultationModelResponse({

    String? message,
  }) = _AddDoctorsForConsultationModelResponse;
  factory AddDoctorsForConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AddDoctorsForConsultationModelResponseFromJson(json);
}
