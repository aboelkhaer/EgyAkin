import 'dart:io';

import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class SocialLoginButtons extends StatelessWidget {
  final bool isDark;

  const SocialLoginButtons({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const SizedBox.shrink(),
          orElse: () {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: HomeDashboardColors.border(isDark)
                            .withOpacity(0.8),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        context.tr(AppStrings.or),
                        style: TextStyle(
                          color: HomeDashboardColors.subtitle(isDark),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: HomeDashboardColors.border(isDark)
                            .withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Expanded(
                      child: _SocialButton(
                        isDark: isDark,
                        label: context.tr(AppStrings.google),
                        onTap: () {
                          try {
                            AuthenticationCubit.get(context)
                                .signInWithGoogle();
                          } catch (e) {
                            debugPrint('Error in Google Sign-In button: $e');
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    context.tr(
                                      AppStrings.failedToStartGoogleSignIn,
                                    ),
                                  ),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                        leading: Container(
                          width: 18.r,
                          height: 18.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: Image.asset(
                              'assets/images/google_logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (Platform.isIOS) ...[
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _SocialButton(
                          isDark: isDark,
                          label: context.tr(AppStrings.apple),
                          filled: !isDark,
                          inverted: isDark,
                          onTap: () {
                            try {
                              AuthenticationCubit.get(context)
                                  .signInWithApple();
                            } catch (e) {
                              debugPrint('Error in Apple Sign-In button: $e');
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      context.tr(
                                        AppStrings
                                            .failedToStartAppleSignInPleaseTryAgain,
                                      ),
                                    ),
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              }
                            }
                          },
                          leading: Icon(
                            Icons.apple,
                            size: 18.sp,
                            color: isDark ? Colors.black : Colors.white,
                          ),
                        ),
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
  }
}

class _SocialButton extends StatelessWidget {
  final bool isDark;
  final String label;
  final Widget leading;
  final VoidCallback onTap;
  final bool filled;
  final bool inverted;

  const _SocialButton({
    required this.isDark,
    required this.label,
    required this.leading,
    required this.onTap,
    this.filled = false,
    this.inverted = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = filled
        ? Colors.black
        : inverted
            ? Colors.white
            : HomeDashboardColors.cardBg(isDark);
    final fg = filled
        ? Colors.white
        : inverted
            ? Colors.black
            : HomeDashboardColors.title(isDark);

    return SizedBox(
      height: 42.h,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Ink(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: filled
                    ? Colors.transparent
                    : HomeDashboardColors.border(isDark).withOpacity(0.85),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                leading,
                SizedBox(width: 8.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: fg,
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
