// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'upload_syndicate_card_model_response.freezed.dart';
part 'upload_syndicate_card_model_response.g.dart';

@freezed
class UploadSyndicateCardModelResponse with _$UploadSyndicateCardModelResponse {
  const factory UploadSyndicateCardModelResponse({
    String? message,
  }) = _UploadSyndicateCardModelResponse;
  factory UploadSyndicateCardModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UploadSyndicateCardModelResponseFromJson(json);
}
