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
    isScrollControlled: true, // Allow full height control
    builder: (context) {
      final mediaQuery = MediaQuery.of(context);
      final screenHeight = mediaQuery.size.height;
      final desiredHeight = heightFactor != null
          ? screenHeight * heightFactor.clamp(0.35, 0.92)
          : isFilter
              ? screenHeight * 0.72
              : screenHeight * 0.5;

      return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap:
                        () {}, // Prevents the bottom sheet from closing when tapping inside it
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: desiredHeight,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? AppColors.darkScaffoldBG
                                : const Color(0xFFF5F5F7),
                            border: Border(
                              top: BorderSide(
                                color: isDarkMode
                                    ? Colors.white.withOpacity(0.06)
                                    : const Color(0xFFE8E8EE),
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDarkMode ? 0.35 : 0.08,
                                ),
                                blurRadius: 24,
                                offset: const Offset(0, -4),
                              ),
                            ],
                          ),
                          child: builder(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
