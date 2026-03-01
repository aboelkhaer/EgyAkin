// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_with_google_model_response.freezed.dart';
part 'authentication_with_google_model_response.g.dart';

@freezed
class AuthenticationWithGoogleModelResponse
    with _$AuthenticationWithGoogleModelResponse {
  const factory AuthenticationWithGoogleModelResponse({
    String? message,
    AuthenticationWithGoogleDataModelResponse? data,
  }) = _AuthenticationWithGoogleModelResponse;
  factory AuthenticationWithGoogleModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AuthenticationWithGoogleModelResponseFromJson(json);
}

@freezed
class AuthenticationWithGoogleDataModelResponse
    with _$AuthenticationWithGoogleDataModelResponse {
  const factory AuthenticationWithGoogleDataModelResponse({
    @JsonKey(name: 'user') DoctorModel? doctorModel,
    String? token,
    String? provider,
    List<String>? permissions,
  }) = _AuthenticationWithGoogleDataModelResponse;
  factory AuthenticationWithGoogleDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AuthenticationWithGoogleDataModelResponseFromJson(json);
}
