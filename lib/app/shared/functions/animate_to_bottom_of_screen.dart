import '../../../exports.dart';

void animateToBottomOfScreen(ScrollController scrollController) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (scrollController.hasClients) {
      final maxScroll = scrollController.position.maxScrollExtent + 10;
      scrollController.animateTo(maxScroll,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  });
}
