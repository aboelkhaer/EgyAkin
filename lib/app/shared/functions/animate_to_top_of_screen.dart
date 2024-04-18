import '../../../exports.dart';

animateToTopOfScreen(ScrollController scrollController) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (scrollController.hasClients) {
      final minScroll = scrollController.position.minScrollExtent;
      scrollController.animateTo(minScroll,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  });
}
