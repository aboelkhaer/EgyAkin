import 'package:flutter/scheduler.dart';

import '../../../exports.dart';

void animateToTopOfScreen(ScrollController scrollController) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (!scrollController.hasClients || scrollController.positions.length != 1) {
      return;
    }
    try {
      final maxScroll = scrollController.position.minScrollExtent;
      if (scrollController.offset <= maxScroll + 0.5) return;
      scrollController.animateTo(
        maxScroll,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } catch (_) {
      // Controller may detach mid-frame during tab switches.
    }
  });
}
