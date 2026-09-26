import 'package:egy_akin/app/routes/fade_swipe_back_page_route.dart';
import 'package:flutter/material.dart';

/// iOS-style push from the right / pop to the right, with left-edge swipe-back.
class SlideFromRightPageRoute<T> extends PageRouteBuilder<T> {
  SlideFromRightPageRoute({
    required WidgetBuilder builder,
    super.settings,
    Duration duration = const Duration(milliseconds: 240),
    Duration reverseDuration = const Duration(milliseconds: 200),
  }) : super(
          opaque: true,
          barrierDismissible: false,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          pageBuilder: (context, animation, secondaryAnimation) {
            return EdgeSwipeBack(child: builder(context));
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            );
          },
        );
}
