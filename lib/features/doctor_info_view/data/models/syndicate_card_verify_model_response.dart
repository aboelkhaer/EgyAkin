// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'syndicate_card_verify_model_response.freezed.dart';
part 'syndicate_card_verify_model_response.g.dart';

@freezed
class SyndicateCardVerifyModelResponse with _$SyndicateCardVerifyModelResponse {
  const factory SyndicateCardVerifyModelResponse({
    String? message,
  }) = _SyndicateCardVerifyModelResponse;
  factory SyndicateCardVerifyModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SyndicateCardVerifyModelResponseFromJson(json);
}
