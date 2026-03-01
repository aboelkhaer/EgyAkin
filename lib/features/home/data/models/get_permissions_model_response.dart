// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_permissions_model_response.freezed.dart';
part 'get_permissions_model_response.g.dart';

@freezed
class GetPermissionsModelResponse with _$GetPermissionsModelResponse {
  const factory GetPermissionsModelResponse({
    bool? value,
    String? message,
    List<String>? permissions,
  }) = _GetPermissionsModelResponse;
  factory GetPermissionsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPermissionsModelResponseFromJson(json);
}
