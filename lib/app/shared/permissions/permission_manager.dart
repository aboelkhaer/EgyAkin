import 'package:egy_akin/app/shared/permissions/app_permissions.dart';

class PermissionManager {
  final Set<AppPermissions> _permissions;

  PermissionManager(this._permissions);

  bool can(AppPermissions permission) {
    return _permissions.contains(permission);
  }

  bool canAny(List<AppPermissions> permissions) {
    return permissions.any(_permissions.contains);
  }

  bool canAll(List<AppPermissions> permissions) {
    return permissions.every(_permissions.contains);
  }
}
