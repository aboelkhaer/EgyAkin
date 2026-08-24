import 'package:egy_akin/exports.dart';

class AboutSectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const AboutSectionCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return Container(
          width: double.infinity,
          padding: padding ?? EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCardBG : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : Colors.grey.shade200,
            ),
            boxShadow: isDark
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

class AboutSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const AboutSectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(isDark ? 0.2 : 0.1),
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
                      color: isDark ? AppColors.darkTitle : Colors.grey.shade900,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        height: 1.4,
                        color: isDark
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

class AboutHeroBanner extends StatelessWidget {
  const AboutHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 20.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      AppColors.primary.withOpacity(0.38),
                      AppColors.darkCardBG,
                    ]
                  : [
                      AppColors.primary.withOpacity(0.14),
                      AppColors.subBG,
                    ],
            ),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.primary.withOpacity(0.28)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(isDark ? 0.08 : 0.92),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.18),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.asset(
                  AppImages.appIcon,
                  height: 52.h,
                  width: 52.h,
                  color: isDark ? AppColors.darkTitle : null,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                context.tr(AppStrings.welcomeToEgyAkin),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkTitle : Colors.grey.shade900,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                context.tr(AppStrings.egyAkinDescription),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1.45,
                  color: isDark
                      ? AppColors.darkDescription
                      : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AboutFeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const AboutFeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkScaffoldBG.withOpacity(0.55)
                : AppColors.subBG.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : Colors.grey.shade200,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(isDark ? 0.22 : 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, size: 18.sp, color: AppColors.primary),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w700,
                        color:
                            isDark ? AppColors.darkTitle : Colors.grey.shade900,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 11.sp,
                        height: 1.4,
                        color: isDark
                            ? AppColors.darkDescription
                            : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AboutPersonTile extends StatelessWidget {
  final String name;
  final String role;
  final String? email;
  final IconData icon;
  final VoidCallback? onEmailTap;

  const AboutPersonTile({
    super.key,
    required this.name,
    required this.role,
    this.email,
    this.icon = Icons.person_outline_rounded,
    this.onEmailTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkScaffoldBG.withOpacity(0.55)
                : AppColors.subBG.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : Colors.grey.shade200,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor:
                    AppColors.primary.withOpacity(isDark ? 0.25 : 0.12),
                child: Icon(icon, color: AppColors.primary, size: 20.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color:
                            isDark ? AppColors.darkTitle : Colors.grey.shade900,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: 11.sp,
                        height: 1.35,
                        color: isDark
                            ? AppColors.darkDescription
                            : Colors.grey.shade600,
                      ),
                    ),
                    if (email != null) ...[
                      SizedBox(height: 6.h),
                      GestureDetector(
                        onTap: onEmailTap,
                        child: Text(
                          email!,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AboutLinkTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const AboutLinkTile({
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
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkScaffoldBG.withOpacity(0.55)
                    : AppColors.subBG.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : Colors.grey.shade200,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color:
                          AppColors.primary.withOpacity(isDark ? 0.22 : 0.12),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(icon, size: 18.sp, color: AppColors.primary),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: isDark
                                ? AppColors.darkDescription
                                : Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.darkTitle
                                : Colors.grey.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: isDark
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
