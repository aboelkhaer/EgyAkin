// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_app_settings_model_response.freezed.dart';
part 'get_app_settings_model_response.g.dart';

@freezed
class GetAppSettingsModelResponse with _$GetAppSettingsModelResponse {
  const factory GetAppSettingsModelResponse({
    @JsonKey(name: 'app_freeze') bool? appFreeze,
    @JsonKey(name: 'force_update') bool? forceUpdate,
  }) = _GetAppSettingsModelResponse;
  factory GetAppSettingsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAppSettingsModelResponseFromJson(json);
}
