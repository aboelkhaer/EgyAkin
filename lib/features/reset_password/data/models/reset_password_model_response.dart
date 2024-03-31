import 'package:freezed_annotation/freezed_annotation.dart';
part 'reset_password_model_response.freezed.dart';
part 'reset_password_model_response.g.dart';

@freezed
class ResetPasswordModelResponse with _$ResetPasswordModelResponse {
  const factory ResetPasswordModelResponse({
    bool? success,
  }) = _ResetPasswordModelResponse;
  factory ResetPasswordModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordModelResponseFromJson(json);
}
