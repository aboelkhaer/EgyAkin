// ignore_for_file: invalid_annotation_target

import 'package:egy_akin/features/send_consultation/data/models/get_consultation_search_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_members_for_consultation_model_response.freezed.dart';
part 'get_members_for_consultation_model_response.g.dart';

@freezed
class GetMembersForConsultationModelResponse
    with _$GetMembersForConsultationModelResponse {
  const factory GetMembersForConsultationModelResponse({
    bool? value,

    List<DoctorModelInConsultationModelResponse>? data,
  }) = _GetMembersForConsultationModelResponse;
  factory GetMembersForConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetMembersForConsultationModelResponseFromJson(json);
      

}

