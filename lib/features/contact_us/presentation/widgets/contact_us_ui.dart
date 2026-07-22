import 'package:egy_akin/exports.dart';

class ContactSectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ContactSectionCard({
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

class ContactSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const ContactSectionHeader({
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
                      color:
                          isDarkMode ? AppColors.darkTitle : Colors.grey.shade900,
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

class ContactHeroBanner extends StatelessWidget {
  const ContactHeroBanner({super.key});

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
                child: Image.asset(
                  AppImages.appIcon,
                  height: 48.h,
                  width: 48.h,
                  color: isDarkMode ? AppColors.darkTitle : null,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                context.tr(AppStrings.contactUs),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode ? AppColors.darkTitle : Colors.grey.shade900,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                context.tr(AppStrings.contactUsSubtitle),
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

class ContactInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const ContactInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkSurface : AppColors.subBG,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isDarkMode
                      ? AppColors.darkBorder
                      : Colors.grey.shade200,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(icon, color: AppColors.primary, size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? AppColors.darkDescription
                                : Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14.sp,
                    color: isDarkMode
                        ? AppColors.darkDescription
                        : Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
