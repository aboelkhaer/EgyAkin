import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_us_model_response.freezed.dart';
part 'contact_us_model_response.g.dart';

@freezed
class ContactUsModelResponseModelResponse
    with _$ContactUsModelResponseModelResponse {
  const factory ContactUsModelResponseModelResponse({
    String? message,
  }) = _ContactUsModelResponseModelResponse;
  factory ContactUsModelResponseModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ContactUsModelResponseModelResponseFromJson(json);
}
