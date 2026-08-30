import 'package:egy_akin/exports.dart';

void showCustomBottomSheet({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isFilter = false,
  double? heightFactor,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useSafeArea: false,
    // Sit above the tab bar / nested navigators so MediaQuery is clean.
    useRootNavigator: true,
    builder: (context) {
      final factor = heightFactor != null
          ? heightFactor.clamp(0.35, 0.92)
          : isFilter
              ? 0.92
              : 0.5;

      return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
          final sheetColor = isDarkMode
              ? AppColors.darkScaffoldBG
              : const Color(0xFFF5F5F7);

          // Keep the sheet pinned to the physical bottom of the screen.
          // Keyboard avoidance is handled inside the sheet content (footer),
          // so we do NOT pad/lift the whole sheet — that was leaving a dark
          // empty band between the actions and the keyboard.
          final sheetHeight = MediaQuery.sizeOf(context).height * factor;

          return Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: Material(
                color: sheetColor,
                child: SizedBox(
                  width: double.infinity,
                  height: sheetHeight,
                  child: builder(context),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
