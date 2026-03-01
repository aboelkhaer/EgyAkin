import 'dart:convert';

import '../../../exports.dart';

/// Helper class for permission checking and function wrapping
/// 
/// Supports both legacy string-based permissions and new enum-based permissions
class PermissionHelper {
  // Legacy string-based permissions
  static final Set<String> _permissions = {};
  
  // New enum-based permissions cache
  static final Map<AppPermissions, bool> _permissionCache = {};
  static bool _isInitialized = false;

  // Legacy methods for string-based permissions
  static void loadPermissions(List<String> permissions) {
    _permissions.clear();
    _permissions.addAll(permissions);
  }

  static bool can(String permissionName) {
    return _permissions.contains(permissionName);
  }

  // New methods for enum-based permissions
  /// Initialize permissions from local storage
  static Future<void> _initializePermissions() async {
    if (_isInitialized) return;

    try {
      final permissionsJson =
          await sl<AppPreferences>().getString(AppLocalStrings.permissions);

      if (permissionsJson == null || permissionsJson.isEmpty) {
        _isInitialized = true;
        return;
      }

      // Decode JSON to List<String>
      final List<dynamic> permissionsList = jsonDecode(permissionsJson);
      final List<String> permissions =
          permissionsList.map((e) => e.toString()).toList();

      // Convert string permissions to AppPermissions enum
      final Set<AppPermissions> appPermissions = permissions
          .map((p) => p.toPermission())
          .whereType<AppPermissions>()
          .toSet();

      // Cache all permissions
      for (final permission in AppPermissions.values) {
        _permissionCache[permission] = appPermissions.contains(permission);
      }

      _isInitialized = true;
    } catch (e) {
      debugPrint('Error initializing permissions: $e');
      _isInitialized = true;
    }
  }

  /// Check if user has a specific permission (enum-based)
  static Future<bool> hasPermission(AppPermissions permission) async {
    await _initializePermissions();
    return _permissionCache[permission] ?? false;
  }

  /// Synchronously check permission (uses cache, may return false if not initialized)
  static bool canPermission(AppPermissions permission) {
    return _permissionCache[permission] ?? false;
  }

  /// Clear the permission cache (useful after logout or permission update)
  static void clearCache() {
    _permissionCache.clear();
    _isInitialized = false;
  }

  /// Refresh permissions from local storage
  static Future<void> refreshPermissions() async {
    _isInitialized = false;
    await _initializePermissions();
  }
}

/// Helper class for wrapping functions based on permissions
class PermissionFunction {
  /// Wrap a VoidCallback based on permission
  /// Returns the function if permission is granted, null otherwise
  static Future<VoidCallback?> wrapVoidCallback(
    AppPermissions permission,
    VoidCallback callback,
  ) async {
    final hasPermission = await PermissionHelper.hasPermission(permission);
    return hasPermission ? callback : null;
  }

  /// Wrap a VoidCallback with a fallback function
  /// Returns the callback if permission is granted, fallback otherwise
  static Future<VoidCallback> wrapVoidCallbackWithFallback(
    AppPermissions permission,
    VoidCallback callback, {
    VoidCallback? fallback,
  }) async {
    final hasPermission = await PermissionHelper.hasPermission(permission);
    if (hasPermission) return callback;
    return fallback ?? () {};
  }

  /// Wrap a function with one parameter based on permission
  static Future<T Function(P)?> wrapFunction1<T, P>(
    AppPermissions permission,
    T Function(P) callback,
  ) async {
    final hasPermission = await PermissionHelper.hasPermission(permission);
    return hasPermission ? callback : null;
  }

  /// Wrap a function with one parameter and fallback
  static Future<T Function(P)> wrapFunction1WithFallback<T, P>(
    AppPermissions permission,
    T Function(P) callback, {
    T Function(P)? fallback,
  }) async {
    final hasPermission = await PermissionHelper.hasPermission(permission);
    if (hasPermission) return callback;
    if (fallback != null) return fallback;
    // Return a no-op function that throws
    return (_) {
      throw UnimplementedError('Permission denied for $permission');
    };
  }

  /// Synchronously wrap a VoidCallback (uses cache)
  /// Returns the function if permission is granted, null otherwise
  static VoidCallback? wrapVoidCallbackSync(
    AppPermissions permission,
    VoidCallback callback,
  ) {
    final hasPermission = PermissionHelper.canPermission(permission);
    return hasPermission ? callback : null;
  }

  /// Synchronously wrap a VoidCallback with fallback (uses cache)
  static VoidCallback wrapVoidCallbackSyncWithFallback(
    AppPermissions permission,
    VoidCallback callback, {
    VoidCallback? fallback,
  }) {
    final hasPermission = PermissionHelper.canPermission(permission);
    if (hasPermission) return callback;
    return fallback ?? () {};
  }
}
