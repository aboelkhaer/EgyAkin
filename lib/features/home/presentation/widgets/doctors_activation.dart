import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

/// Admin home section: doctors waiting for syndicate card verification.
class DoctorsActivation extends StatefulWidget {
  final bool isDark;

  const DoctorsActivation({
    super.key,
    required this.isDark,
  });

  @override
  State<DoctorsActivation> createState() => _DoctorsActivationState();
}

class _DoctorsActivationState extends State<DoctorsActivation> {
  @override
  void initState() {
    super.initState();
    PermissionHelper.refreshPermissions().then((_) {
      if (mounted) setState(() {});
    });
  }

  void _openDoctorProfile({
    required DoctorModel doctor,
    required DoctorModel currentDoctorModel,
    required HomeModelResponse homeData,
  }) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctor.id.toString(),
        currentDoctorModel: currentDoctorModel,
        currentDoctorPoints: int.tryParse(homeData.scoreValue ?? '0') ?? 0,
        accountVerification: homeData.verified ?? false,
        initialIndex: 0,
        isSyndicateCardRequired:
            homeData.isSyndicateCardRequired?.toString() ?? '',
        currentDoctorRole: homeData.role?.toString() ?? '',
        homeDataModel: homeData,
        isNavigateToTheButtonOfInformationTab: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!PermissionHelper.canPermission(
      AppPermissions.viewDoctorActivationForAdmin,
    )) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loaded: (
            homeData,
            currentDoctorModel,
            _,
            __,
            ___,
            ____,
            _____,
            ______,
            _______,
            ________,
          ) {
            final pending =
                homeData.data?.pendingSyndicateCard ?? const <DoctorModel>[];
            if (pending.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 14.h),
                HomeSectionHeader(
                  title: context.tr(AppStrings.doctorsActivation),
                  isDark: widget.isDark,
                  badgeCount: pending.length,
                ),
                SizedBox(height: 10.h),
                ...pending.map(
                  (doctor) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: _PendingSyndicateDoctorCard(
                      isDark: widget.isDark,
                      doctor: doctor,
                      onTap: () => _openDoctorProfile(
                        doctor: doctor,
                        currentDoctorModel: currentDoctorModel,
                        homeData: homeData,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _PendingSyndicateDoctorCard extends StatelessWidget {
  final bool isDark;
  final DoctorModel doctor;
  final VoidCallback onTap;

  const _PendingSyndicateDoctorCard({
    required this.isDark,
    required this.doctor,
    required this.onTap,
  });

  String get _initials {
    final a =
        (doctor.firstName?.isNotEmpty ?? false) ? doctor.firstName![0] : '';
    final b =
        (doctor.lastName?.isNotEmpty ?? false) ? doctor.lastName![0] : '';
    final value = ('$a$b').toUpperCase();
    return value.isEmpty ? 'DR' : value;
  }

  String get _name {
    final first = capitalizeFirstText(doctor.firstName ?? '') ?? '';
    final last = capitalizeFirstText(doctor.lastName ?? '') ?? '';
    final full = '$first $last'.trim();
    return full.isEmpty ? 'Doctor' : full;
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFF59E0B);
    final specialty = capitalizeFirstText(doctor.specialty ?? '') ?? '';
    final workplace = doctor.workingplace?.trim() ?? '';
    final subtitle = [
      if (specialty.isNotEmpty) specialty,
      if (workplace.isNotEmpty) workplace,
    ].join(' · ');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: isDark ? HomeDashboardColors.cardBg(true) : Colors.white,
            border: Border.all(
              color: accent.withOpacity(isDark ? 0.35 : 0.22),
            ),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: accent.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    child: ClipOval(
                      child: doctor.image == null || doctor.image!.trim().isEmpty
                          ? Container(
                              color: accent.withOpacity(0.14),
                              alignment: Alignment.center,
                              child: Text(
                                _initials,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                  color: accent,
                                ),
                              ),
                            )
                          : CustomCachedNetworkImage(
                              imageUrl: doctor.image.toString(),
                              height: 48.w,
                              width: 48.w,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    right: -1,
                    bottom: -1,
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? HomeDashboardColors.cardBg(true)
                              : Colors.white,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.hourglass_top_rounded,
                        size: 9.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: HomeDashboardColors.subtitle(isDark),
                        ),
                      ),
                    ],
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
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
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      context.tr(AppStrings.reviewSyndicateCard),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
