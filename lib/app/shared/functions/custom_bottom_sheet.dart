import 'package:egy_akin/app/services/theme_bloc.dart';
import 'package:egy_akin/exports.dart';

void showCustomBottomSheet({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isFilter = false,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true, // Allow full height control
    builder: (context) {
      final mediaQuery = MediaQuery.of(context);
      final screenHeight = mediaQuery.size.height;
      final desiredHeight = isFilter
          ? screenHeight * 0.8
          : screenHeight * 0.5; // Adjust the height as needed

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
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        child: Container(
                          width: double.infinity, // Full width
                          height: desiredHeight,
                          color:
                              isDarkMode ? AppColors.darkCardBG : Colors.white,
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
