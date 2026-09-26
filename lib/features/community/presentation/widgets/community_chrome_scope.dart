import 'package:flutter/widgets.dart';

/// Fixed scroll inset matching the overlay community header body height.
class CommunityChromeScope extends InheritedWidget {
  final double scrollTopInset;

  const CommunityChromeScope({
    super.key,
    required this.scrollTopInset,
    required super.child,
  });

  static double of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<CommunityChromeScope>()
            ?.scrollTopInset ??
        0;
  }

  @override
  bool updateShouldNotify(CommunityChromeScope oldWidget) {
    return oldWidget.scrollTopInset != scrollTopInset;
  }
}
