import 'home_dashboard_shared.dart';
import 'home_email_verification_banner.dart';
import '../../../../../exports.dart';

String resolvedUserType(
  HomeModelResponse? homeData, {
  DoctorModel? doctor,
}) {
  final homeType = (homeData?.userType ?? '').trim().toLowerCase();
  final doctorType = (doctor?.userType ?? '').trim().toLowerCase();
  // Prefer home payload — it is synced on profile save / getHome.
  if (homeType.isNotEmpty) return homeType;
  return doctorType;
}

bool isResearchMember(
  HomeModelResponse? homeData, {
  DoctorModel? doctor,
}) {
  return resolvedUserType(homeData, doctor: doctor) == 'medical_statistics';
}

bool isNormalMember(
  HomeModelResponse? homeData, {
  DoctorModel? doctor,
}) {
  return resolvedUserType(homeData, doctor: doctor) == 'normal';
}

/// Research member + email verified + syndicate card not verified yet.
bool needsSyndicateCardVerification({
  required DoctorModel doctor,
  required HomeModelResponse homeData,
}) {
  if (!isResearchMember(homeData, doctor: doctor)) return false;
  if (!isDoctorEmailVerified(doctor: doctor, homeData: homeData)) return false;
  if (isVerifiedUser(homeData.isSyndicateCardRequired)) return false;
  return true;
}

bool isSyndicateCardPending(HomeModelResponse homeData) {
  return homeData.isSyndicateCardRequired ==
      VerificationBySyndicateCard.Pending.name;
}

/// Home banner prompting syndicate card verification for research members.
class HomeSyndicateCardBanner extends StatelessWidget {
  final bool isDark;
  final bool isPending;
  final bool isUploading;
  final VoidCallback? onDismiss;
  final VoidCallback? onUpload;

  const HomeSyndicateCardBanner({
    super.key,
    required this.isDark,
    required this.isPending,
    required this.isUploading,
    required this.onDismiss,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(22.r);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF59E0B).withOpacity(0.32),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isPending || isUploading ? null : onUpload,
          borderRadius: radius,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isPending
                    ? (isDark
                        ? const [
                            Color(0xFF78350F),
                            Color(0xFF92400E),
                            Color(0xFFB45309),
                          ]
                        : const [
                            Color(0xFFF59E0B),
                            Color(0xFFD97706),
                            Color(0xFFEA580C),
                          ])
                    : (isDark
                        ? const [
                            Color(0xFF7C2D12),
                            Color(0xFF9A3412),
                            Color(0xFFC2410C),
                          ]
                        : const [
                            Color(0xFFEA580C),
                            Color(0xFFF59E0B),
                            Color(0xFFD97706),
                          ]),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.hardEdge,
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
                      color: Colors.white.withOpacity(0.1),
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
                          isPending
                              ? Icons.hourglass_top_rounded
                              : Icons.badge_outlined,
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
                              isPending
                                  ? context.tr(AppStrings.waitingForApproval)
                                  : context.tr(
                                      AppStrings.verifyYourSyndicateCard,
                                    ),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              isPending
                                  ? context.tr(
                                      AppStrings
                                          .theSyndicateCardIsBeingProcessedForVerification,
                                    )
                                  : context.tr(
                                      AppStrings
                                          .toAddPatientsYouMustVerifyYourSyndicateCard,
                                    ),
                              style: TextStyle(
                                fontSize: 11.sp,
                                height: 1.35,
                                color: Colors.white.withOpacity(0.88),
                              ),
                            ),
                            if (!isPending) ...[
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
                                    if (isUploading)
                                      SizedBox(
                                        width: 12.w,
                                        height: 12.w,
                                        child:
                                            const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Color(0xFFEA580C),
                                        ),
                                      )
                                    else ...[
                                      Text(
                                        context.tr(
                                          AppStrings.uploadSyndicateCard,
                                        ),
                                        style: TextStyle(
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFFEA580C),
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 14.sp,
                                        color: const Color(0xFFEA580C),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (onDismiss != null)
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

/// Profile status card for syndicate card verification (research members).
class ProfileSyndicateCardStatus extends StatelessWidget {
  final bool isDark;
  final bool isPending;
  final bool isUploading;
  final VoidCallback? onTap;

  const ProfileSyndicateCardStatus({
    super.key,
    required this.isDark,
    required this.isPending,
    required this.isUploading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = isPending
        ? const Color(0xFFF59E0B)
        : const Color(0xFFEA580C);
    final cardBg = isDark ? HomeDashboardColors.cardBg(true) : Colors.white;
    final title = isPending
        ? context.tr(AppStrings.waitingForApproval)
        : context.tr(AppStrings.verifyYourSyndicateCard);
    final subtitle = isPending
        ? context.tr(AppStrings.pendingReview)
        : context.tr(AppStrings.tapToUploadSyndicateCard);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isPending || isUploading ? null : onTap,
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
                child: isUploading
                    ? Padding(
                        padding: EdgeInsets.all(10.w),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: accent,
                        ),
                      )
                    : Icon(
                        isPending
                            ? Icons.hourglass_top_rounded
                            : Icons.badge_outlined,
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
                      subtitle,
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
              if (isPending)
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
                    context.tr(AppStrings.pendingReview),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: accent,
                    ),
                  ),
                )
              else
                Icon(
                  Icons.chevron_right_rounded,
                  color: accent,
                  size: 22.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
