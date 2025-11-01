class PermissionHelper {
  static final Set<String> _permissions = {};

  static void loadPermissions(List<String> permissions) {
    _permissions.clear();
    _permissions.addAll(permissions);
  }

  static bool can(String permissionName) {
    return _permissions.contains(permissionName);
  }
}
