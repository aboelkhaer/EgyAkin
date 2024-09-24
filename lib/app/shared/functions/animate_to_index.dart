import 'package:flutter/scheduler.dart';

import '../../../exports.dart';

void animateToIndex(
    ScrollController scrollController, int index, double itemHeight) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (scrollController.hasClients) {
      // Calculate the target position based on the index and item height
      final targetPosition = index * itemHeight;

      // Ensure the target position is within the scrollable range
      final maxScroll = scrollController.position.maxScrollExtent;
      final targetScroll = targetPosition.clamp(0.0, maxScroll);

      scrollController
          .animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then((_) {
        debugPrint('Animation to index $index completed.');
      }).catchError((error) {
        debugPrint('Error during animation: $error');
      });
    } else {
      debugPrint('ScrollController has no clients.');
    }
  });
}
