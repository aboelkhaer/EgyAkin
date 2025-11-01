class RoleHelper {
  static final Set<String> _roles = {};

  static void loadRoles(List<String> roles) {
    _roles.clear();
    _roles.addAll(roles);
  }

  static bool hasRole(String roleName) => _roles.contains(roleName);
}
