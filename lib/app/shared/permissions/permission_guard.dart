import 'package:egy_akin/app/shared/functions/permissions_helper.dart';

import '../../../exports.dart';

class PermissionGuard extends StatefulWidget {
  final AppPermissions permission;
  final Widget child;
  final Widget? fallback;

  const PermissionGuard({
    super.key,
    required this.permission,
    required this.child,
    this.fallback,
  });

  @override
  State<PermissionGuard> createState() => _PermissionGuardState();
}

class _PermissionGuardState extends State<PermissionGuard> {
  bool? _cachedResult;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final hasPermission =
        await PermissionHelper.hasPermission(widget.permission);
    if (mounted) {
      setState(() {
        _cachedResult = hasPermission;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show fallback while checking or if no permission
    if (_cachedResult == null) {
      return widget.fallback ?? const SizedBox();
    }

    // Show child if has permission, otherwise show fallback
    return _cachedResult! ? widget.child : widget.fallback ?? const SizedBox();
  }
}
