import 'package:freezed_annotation/freezed_annotation.dart';
part 'sign_out_model_response.freezed.dart';
part 'sign_out_model_response.g.dart';

@freezed
class SignOutModelResponse with _$SignOutModelResponse {
  const factory SignOutModelResponse({
    bool? value,
    String? message,
  }) = _SignOutModelResponse;
  factory SignOutModelResponse.fromJson(Map<String, dynamic> json) =>
      _$SignOutModelResponseFromJson(json);
}
