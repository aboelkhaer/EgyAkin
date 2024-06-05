import 'package:freezed_annotation/freezed_annotation.dart';
part 'upload_profile_image_model_response.freezed.dart';
part 'upload_profile_image_model_response.g.dart';

@freezed
class UploadProfileImageModelResponse with _$UploadProfileImageModelResponse {
  const factory UploadProfileImageModelResponse({
    bool? value,
    String? message,
    String? image,
  }) = _UploadProfileImageModelResponse;
  factory UploadProfileImageModelResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadProfileImageModelResponseFromJson(json);
}
