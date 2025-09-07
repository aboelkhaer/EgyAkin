
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'remove_member_from_consultation_model_response.freezed.dart';
part 'remove_member_from_consultation_model_response.g.dart';

@freezed
class RemoveMemberFromConsultationModelResponse
    with _$RemoveMemberFromConsultationModelResponse {
  const factory RemoveMemberFromConsultationModelResponse({
    String? message,
  }) = _RemoveMemberFromConsultationModelResponse;
  factory RemoveMemberFromConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$RemoveMemberFromConsultationModelResponseFromJson(json);
}
