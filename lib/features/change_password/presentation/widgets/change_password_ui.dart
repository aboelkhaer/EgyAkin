import 'package:egy_akin/exports.dart';

class ChangePasswordSectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ChangePasswordSectionCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Container(
          width: double.infinity,
          padding: padding ?? EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.darkCardBG : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isDarkMode ? AppColors.darkBorder : Colors.grey.shade200,
            ),
            boxShadow: isDarkMode
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: child,
        );
      },
    );
  }
}

class ChangePasswordSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const ChangePasswordSectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(isDarkMode ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode
                          ? AppColors.darkTitle
                          : Colors.grey.shade900,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        height: 1.35,
                        color: isDarkMode
                            ? AppColors.darkDescription
                            : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ChangePasswordHeroBanner extends StatelessWidget {
  const ChangePasswordHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [
                      AppColors.primary.withOpacity(0.35),
                      AppColors.darkCardBG,
                    ]
                  : [
                      AppColors.primary.withOpacity(0.12),
                      AppColors.subBG,
                    ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.primary.withOpacity(0.25)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(isDarkMode ? 0.08 : 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.lock_reset_rounded,
                  size: 40.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                context.tr(AppStrings.changePassword),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color:
                      isDarkMode ? AppColors.darkTitle : Colors.grey.shade900,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                context.tr(AppStrings.changePasswordSubtitle),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1.4,
                  color: isDarkMode
                      ? AppColors.darkDescription
                      : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChangePasswordSecurityTip extends StatelessWidget {
  const ChangePasswordSecurityTip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isDarkMode
                ? AppColors.primary.withOpacity(0.12)
                : AppColors.primary.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.primary.withOpacity(isDarkMode ? 0.3 : 0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 18.sp,
                color: AppColors.primary,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  context.tr(AppStrings.changePasswordSecurityTip),
                  style: TextStyle(
                    fontSize: 11.sp,
                    height: 1.4,
                    color: isDarkMode
                        ? AppColors.darkDescription
                        : Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
