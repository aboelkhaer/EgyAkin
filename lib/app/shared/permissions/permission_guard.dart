import 'package:egy_akin/app/shared/functions/permissions_helper.dart';

import '../../../exports.dart';

class PermissionGuard extends StatefulWidget {
  final AppPermissions permission;
  final Widget child;
  final Widget? fallback;

  /// Shown only while the permission check is still in progress.
  /// Defaults to an empty box so denied fallbacks never flash briefly.
  final Widget? loading;

  const PermissionGuard({
    super.key,
    required this.permission,
    required this.child,
    this.fallback,
    this.loading,
  });

  @override
  State<PermissionGuard> createState() => _PermissionGuardState();
}

class _PermissionGuardState extends State<PermissionGuard> {
  bool? _cachedResult;

  @override
  void initState() {
    super.initState();
    // Avoid a denied-message flash when the cache is already warm.
    if (PermissionHelper.isReady) {
      _cachedResult = PermissionHelper.canPermission(widget.permission);
    }
    _checkPermission();
  }

  @override
  void didUpdateWidget(covariant PermissionGuard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.permission != widget.permission) {
      if (PermissionHelper.isReady) {
        _cachedResult = PermissionHelper.canPermission(widget.permission);
      } else {
        _cachedResult = null;
      }
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    final hasPermission =
        await PermissionHelper.hasPermission(widget.permission);
    if (!mounted) return;
    if (_cachedResult == hasPermission) return;
    setState(() {
      _cachedResult = hasPermission;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Still resolving — never show the denied fallback here.
    if (_cachedResult == null) {
      return widget.loading ?? const SizedBox.shrink();
    }

    return _cachedResult! ? widget.child : widget.fallback ?? const SizedBox();
  }
}
