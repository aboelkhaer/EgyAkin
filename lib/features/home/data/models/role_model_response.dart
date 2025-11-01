import 'package:freezed_annotation/freezed_annotation.dart';
part 'role_model_response.freezed.dart';
part 'role_model_response.g.dart';

@freezed
class RoleModel with _$RoleModel {
  const factory RoleModel({
    required int id,
    required String name,
    required List<PermissionModel> permissions,
  }) = _RoleModel;

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);
}

@freezed
class PermissionModel with _$PermissionModel {
  const factory PermissionModel({
    required int id,
    required String name,
    String? category,
    String? description,
  }) = _PermissionModel;

  factory PermissionModel.fromJson(Map<String, dynamic> json) =>
      _$PermissionModelFromJson(json);
}
