import 'home_dashboard_shared.dart';
import '../../../../../exports.dart';

bool isDoctorEmailVerified({
  required DoctorModel doctor,
  HomeModelResponse? homeData,
}) {
  final verifiedAt = doctor.emailVerifiedAt?.trim();
  final hasVerifiedAt = verifiedAt != null && verifiedAt.isNotEmpty;
  // Require both the account flag and a local verified-at timestamp so a
  // stale `/user/me` `verified: true` cannot resurrect after an email change.
  return homeData?.verified == true && hasVerifiedAt;
}

/// Eye-catching home banner prompting email verification.
class HomeEmailVerificationBanner extends StatelessWidget {
  final bool isDark;
  final DoctorModel currentDoctorModel;
  final VoidCallback onDismiss;
  final VoidCallback onVerify;

  const HomeEmailVerificationBanner({
    super.key,
    required this.isDark,
    required this.currentDoctorModel,
    required this.onDismiss,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    final email = currentDoctorModel.email?.trim();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onVerify,
        borderRadius: BorderRadius.circular(22.r),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? const [
                      Color(0xFF312E81),
                      Color(0xFF4C1D95),
                      Color(0xFF0E7490),
                    ]
                  : const [
                      Color(0xFF6366F1),
                      Color(0xFF7C3AED),
                      Color(0xFF06B6D4),
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: (isDark
                        ? const Color(0xFF6366F1)
                        : const Color(0xFF7C3AED))
                    .withOpacity(0.35),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22.r),
            child: Stack(
              children: [
                Positioned(
                  right: -24,
                  top: -28,
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.12),
                    ),
                  ),
                ),
                Positioned(
                  left: -30,
                  bottom: -40,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF22D3EE).withOpacity(0.18),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14.w, 14.h, 10.w, 14.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 46.w,
                        height: 46.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.28),
                          ),
                        ),
                        child: Icon(
                          Icons.mark_email_unread_rounded,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr(AppStrings.verifyYourEmail),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              context.tr(
                                AppStrings
                                    .youMustVerifyYourEmailAddressToEnjoyAllFeatures,
                              ),
                              style: TextStyle(
                                fontSize: 11.sp,
                                height: 1.35,
                                color: Colors.white.withOpacity(0.88),
                              ),
                            ),
                            if (email != null && email.isNotEmpty) ...[
                              SizedBox(height: 6.h),
                              Text(
                                email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.75),
                                ),
                              ),
                            ],
                            SizedBox(height: 10.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 7.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    context.tr(AppStrings.verifyNow),
                                    style: TextStyle(
                                      fontSize: 11.5.sp,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF4F46E5),
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 14.sp,
                                    color: const Color(0xFF4F46E5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: onDismiss,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        icon: Icon(
                          Icons.close_rounded,
                          size: 18.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
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

/// Compact profile status card for email verification.
class ProfileEmailVerificationStatus extends StatelessWidget {
  final bool isDark;
  final bool isVerified;
  final String? email;
  final VoidCallback? onTap;

  const ProfileEmailVerificationStatus({
    super.key,
    required this.isDark,
    required this.isVerified,
    required this.email,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = isVerified
        ? HomeDashboardColors.success
        : const Color(0xFFF59E0B);
    final cardBg = isDark ? HomeDashboardColors.cardBg(true) : Colors.white;
    final title = isVerified
        ? context.tr(AppStrings.emailVerified)
        : context.tr(AppStrings.emailNotVerified);
    final subtitle = isVerified
        ? context.tr(AppStrings.yourEmailIsVerified)
        : context.tr(AppStrings.tapToVerifyYourEmail);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isVerified ? null : onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: accent.withOpacity(isDark ? 0.35 : 0.28),
            ),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: accent.withOpacity(isDark ? 0.22 : 0.14),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  isVerified
                      ? Icons.verified_rounded
                      : Icons.mark_email_unread_outlined,
                  color: accent,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? HomeDashboardColors.title(true)
                            : const Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      email != null && email!.isNotEmpty
                          ? '$subtitle\n$email'
                          : subtitle,
                      style: TextStyle(
                        fontSize: 11.sp,
                        height: 1.3,
                        color: isDark
                            ? HomeDashboardColors.subtitle(true)
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isVerified)
                Icon(
                  Icons.chevron_right_rounded,
                  color: accent,
                  size: 22.sp,
                )
              else
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(isDark ? 0.2 : 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    context.tr(AppStrings.verified),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: accent,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
