import 'package:flutter/scheduler.dart';

import '../../../exports.dart';

animateToTopOfScreen(ScrollController scrollController) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (scrollController.hasClients) {
      final maxScroll = scrollController.position.minScrollExtent;
      scrollController
          .animateTo(
        maxScroll,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then((_) {
        debugPrint('Animation to bottom of screen completed.');
      }).catchError((error) {
        debugPrint('Error during animation: $error');
      });
    } else {
      debugPrint('ScrollController has no clients.');
    }
  });
}
