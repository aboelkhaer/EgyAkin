import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';
import 'dart:io';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () {
                return const SizedBox.shrink();
              },
              orElse: () {
                return Column(
                  children: [
                    // Clean Divider with "OR" text
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: isDarkMode
                                ? AppColors.darkBorder
                                : AppColors.description.withOpacity(0.3),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            context.tr(AppStrings.or),
                            style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.darkDescription
                                  : AppColors.description,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: isDarkMode
                                ? AppColors.darkBorder
                                : AppColors.description.withOpacity(0.3),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Social Login Buttons in Row
                    Row(
                      children: [
                        // Google Sign In Button
                        Expanded(
                          child: _GoogleSignInButton(isDarkMode: isDarkMode),
                        ),
                        // Show Apple button only on iOS
                        if (Platform.isIOS) ...[
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _AppleSignInButton(isDarkMode: isDarkMode),
                          ),
                        ],
                      ],
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  final bool isDarkMode;

  const _GoogleSignInButton({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: isDarkMode ? AppColors.darkCardBG : Colors.white,
        border: Border.all(
          color: isDarkMode ? AppColors.darkBorder : Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            try {
              AuthenticationCubit.get(context).signInWithGoogle();
            } catch (e) {
              debugPrint('Error in Google Sign-In button: $e');
              // Show error to user
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Failed to start Google Sign-In. Please try again.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            }
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google logo image
                Container(
                  width: 18.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.r),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 0.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.r),
                    child: Image.asset(
                      'assets/images/google_logo.png',
                      width: 18.w,
                      height: 18.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Google',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? AppColors.darkTitle : AppColors.title,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppleSignInButton extends StatelessWidget {
  final bool isDarkMode;

  const _AppleSignInButton({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    // Apple Sign-In button colors based on dark mode
    // Light mode: Black background with white text/icon
    // Dark mode: White background with black text/icon (Apple HIG)
    final Color backgroundColor = isDarkMode ? Colors.white : AppColors.black;
    final Color textAndIconColor = isDarkMode ? AppColors.black : Colors.white;

    return Container(
      height: 38.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: backgroundColor,
        border: isDarkMode
            ? Border.all(
                color: AppColors.darkBorder,
                width: 1,
              )
            : null,
        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            try {
              AuthenticationCubit.get(context).signInWithApple();
            } catch (e) {
              debugPrint('Error in Apple Sign-In button: $e');
              // Show error to user
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context
                        .tr(AppStrings.failedToStartAppleSignInPleaseTryAgain)),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            }
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Apple Logo
                Icon(
                  Icons.apple,
                  size: 18.sp,
                  color: textAndIconColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Apple',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: textAndIconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showComingSoonDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Text(
          context.tr(AppStrings.comingSoon),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          context.tr(AppStrings.socialLoginComingSoon),
          style: TextStyle(fontSize: 12.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              context.tr(AppStrings.ok),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );
}
