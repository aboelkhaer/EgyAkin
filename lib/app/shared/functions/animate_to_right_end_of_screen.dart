import 'package:flutter/scheduler.dart';

import '../../../exports.dart';

/// Scrolls a horizontal strip to its content end after the next layout(s).
/// Retries briefly so newly-added chips are attached before animating.
void animateToRightEndOfScreen(ScrollController scrollController) {
  void tryAnimate([int attempt = 0]) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) {
        if (attempt < 6) tryAnimate(attempt + 1);
        return;
      }

      final position = scrollController.position;
      if (!position.hasContentDimensions) {
        if (attempt < 6) tryAnimate(attempt + 1);
        return;
      }

      final target = position.maxScrollExtent;
      if ((scrollController.offset - target).abs() < 0.5) return;

      scrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    });
  }

  tryAnimate();
}
