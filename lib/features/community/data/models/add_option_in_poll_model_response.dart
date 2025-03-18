// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_option_in_poll_model_response.freezed.dart';
part 'add_option_in_poll_model_response.g.dart';

@freezed
class AddOptionInPollModelResponse with _$AddOptionInPollModelResponse {
  const factory AddOptionInPollModelResponse({
    AddOptionInPollDataModelResponse? data,
    String? message,
  }) = _AddOptionInPollModelResponse;
  factory AddOptionInPollModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AddOptionInPollModelResponseFromJson(json);
}

@freezed
class AddOptionInPollDataModelResponse with _$AddOptionInPollDataModelResponse {
  const factory AddOptionInPollDataModelResponse({
    int? id,
    @JsonKey(name: 'poll_id') String? pollId,
    @JsonKey(name: 'option_text') String? option,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _AddOptionInPollDataModelResponse;
  factory AddOptionInPollDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AddOptionInPollDataModelResponseFromJson(json);
}
