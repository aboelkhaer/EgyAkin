import 'package:flutter/scheduler.dart';

import '../../../exports.dart';

void animateToPosition(
    ScrollController scrollController, double targetPosition) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (scrollController.hasClients) {
      final targetScroll =
          targetPosition.clamp(0.0, scrollController.position.maxScrollExtent);
      scrollController
          .animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then((_) {
        debugPrint('Animation to position $targetScroll completed.');
      }).catchError((error) {
        debugPrint('Error during animation: $error');
      });
    } else {
      debugPrint('ScrollController has no clients.');
    }
  });
}
