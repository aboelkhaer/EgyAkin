import 'package:flutter/scheduler.dart';

import '../../../exports.dart';

void animateToTopOfScreen(ScrollController scrollController) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (scrollController.hasClients && scrollController.positions.length == 1) {
      final maxScroll = scrollController.position.minScrollExtent;
      scrollController
          .animateTo(
        maxScroll,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then((_) {
        debugPrint('Animation to top of screen completed.');
      }).catchError((error) {
        debugPrint('Error during animation: $error');
      });
    } else if (!scrollController.hasClients) {
      debugPrint('ScrollController has no clients.');
    } else {
      debugPrint('ScrollController is attached to multiple positions.');
    }
  });
}
