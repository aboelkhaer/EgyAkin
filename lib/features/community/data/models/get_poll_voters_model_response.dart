// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../exports.dart';

part 'get_poll_voters_model_response.freezed.dart';
part 'get_poll_voters_model_response.g.dart';

@freezed
class GetPollVotersModelResponse with _$GetPollVotersModelResponse {
  const factory GetPollVotersModelResponse({
    List<DoctorModel>? data,
    String? message,
  }) = _GetPollVotersModelResponse;
  factory GetPollVotersModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPollVotersModelResponseFromJson(json);
}
