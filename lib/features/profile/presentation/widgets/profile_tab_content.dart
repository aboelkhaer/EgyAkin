import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/permissions/app_permissions.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/more/presentation/pages/more_screen.dart';

import '../../../../exports.dart';

/// Redesigned Profile tab body matching the home dashboard mockups.
class ProfileTabContent extends StatelessWidget {
  final ProfileCubit cubit;
  final String isSyndicateCardRequired;
  final bool accountVerification;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final bool isDark;

  const ProfileTabContent({
    super.key,
    required this.cubit,
    required this.isSyndicateCardRequired,
    required this.accountVerification,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.isDark,
  });

  String get _initials {
    final a = (currentDoctorModel.firstName?.isNotEmpty ?? false)
        ? currentDoctorModel.firstName![0]
        : '';
    final b = (currentDoctorModel.lastName?.isNotEmpty ?? false)
        ? currentDoctorModel.lastName![0]
        : '';
    final value = ('$a$b').toUpperCase();
    return value.isEmpty ? 'DR' : value;
  }

  String get _displayName => doctorName(
        firstName: currentDoctorModel.firstName ?? '',
        lastName: currentDoctorModel.lastName ?? '',
        role: isSyndicateCardRequired,
      );

  String get _specialtyLine {
    final specialty =
        capitalizeFirstText(currentDoctorModel.specialty ?? '') ?? '';
    final place = currentDoctorModel.workingplace?.trim();
    if (specialty.isEmpty && (place == null || place.isEmpty)) {
      return '';
    }
    if (place == null || place.isEmpty) return specialty;
    if (specialty.isEmpty) return place;
    return '$specialty · $place';
  }

  bool get _isVerified => isVerifiedUser(isSyndicateCardRequired);

  @override
  Widget build(BuildContext context) {
    final scaffold = HomeDashboardColors.scaffold(isDark);
    final primary = HomeDashboardColors.primary(isDark);

    return ColoredBox(
      color: scaffold,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              customSnackBar(message: message, context: context);
            },
            loaded: (doctorModel, isLoadedImage) {
              if (isLoadedImage) {
                context.read<HomeCubit>().getDoctorDataFromLocal();
              }
            },
            signOutLoaded: () {
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed(AppRoutes.signIn);
            },
          );
        },
        builder: (context, state) {
          final signingOut = state.maybeWhen(
            signOutLoading: () => true,
            orElse: () => false,
          );

          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: _ProfileHeader(
                  isDark: isDark,
                  primary: primary,
                  initials: _initials,
                  imageUrl: currentDoctorModel.image,
                  displayName: _displayName,
                  specialtyLine: _specialtyLine,
                  isVerified: _isVerified,
                  onAvatarTap: () => _openDoctorInfo(),
                ),
              ),
              if (_isVerified)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                    child: _VerificationCard(isDark: isDark),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                  child: _StatsGrid(
                    isDark: isDark,
                    patients:
                        context.read<HomeCubit>().doctorPatientCount ?? '0',
                    score: context.read<HomeCubit>().doctorScore ??
                        currentDoctorPoints.toString(),
                    savedPosts: homeDataModel.savedPosts ?? '0',
                    allPosts: homeDataModel.postsCount ?? '0',
                    onPatients: () => _openPatients(context),
                    onScore: () => _openScore(context),
                    onSaved: () => _openSavedPosts(context),
                    onAllPosts: () => _openAllPosts(context),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                  child: _MenuCard(
                    isDark: isDark,
                    items: _menuItems(context),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 100.h),
                  child: _SignOutCard(
                    isDark: isDark,
                    loading: signingOut,
                    onTap: signingOut ? null : () => cubit.signOut(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<_MenuItemData> _menuItems(BuildContext context) {
    final items = <_MenuItemData>[
      _MenuItemData(
        icon: Icons.person_outline_rounded,
        iconBg: const Color(0xFF8B5CF6),
        title: context.tr(AppStrings.account),
        subtitle: context.tr(AppStrings.manageYourPersonalInfo),
        onTap: () {
          navigatorKey.currentState?.pushNamed(AppRoutes.doctorProfile);
        },
      ),
    ];

    if (PermissionHelper.canPermission(
        AppPermissions.viewConsultationInHomeProfile)) {
      items.add(
        _MenuItemData(
          icon: Icons.chat_bubble_outline_rounded,
          iconBg: const Color(0xFF3B82F6),
          title: context.tr(AppStrings.consultation),
          subtitle: context.tr(AppStrings.initateOrViewConsultations),
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.consultation,
              arguments: AppRoutesArgs.consultationRouteArgs(
                homeDataModel: homeDataModel,
                currentDoctorModel: cubit.currentDoctor,
                initialTab: 0,
              ),
            );
          },
        ),
      );
    }

    if (PermissionHelper.canPermission(
        AppPermissions.viewAchievementsInHomeProfile)) {
      items.add(
        _MenuItemData(
          icon: Icons.emoji_events_outlined,
          iconBg: const Color(0xFFF59E0B),
          title: context.tr(AppStrings.achievements),
          subtitle: context.tr(AppStrings.exploreYourAccomplishments),
          onTap: () {
            showCustomBottomSheet(
              context: context,
              heightFactor: 0.78,
              builder: (context) {
                return BlocProvider(
                  create: (context) =>
                      DoctorInfoViewCubit(sl(), sl(), sl(), sl(), sl(), sl()),
                  child: AchievementsTab(
                    isProfileFeature: true,
                    currentDoctorId: cubit.currentDoctor.id.toString(),
                  ),
                );
              },
            );
          },
        ),
      );
    }

    items.add(
      _MenuItemData(
        icon: Icons.tune_rounded,
        iconBg: const Color(0xFF22C55E),
        title: context.tr(AppStrings.settingsAndMore),
        subtitle: context.tr(AppStrings.settingsAndMoreSubtitle),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => sl<MoreCubit>(),
                child: MoreScreen(
                  currentDoctorModel: currentDoctorModel,
                  accountVerification: accountVerification,
                  homeDataModel: homeDataModel,
                ),
              ),
            ),
          );
        },
      ),
    );

    return items;
  }

  void _openDoctorInfo() {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: cubit.currentDoctor.id.toString(),
        currentDoctorModel: cubit.currentDoctor,
        isSyndicateCardRequired:
            homeDataModel.isSyndicateCardRequired.toString(),
        accountVerification: homeDataModel.verified ?? accountVerification,
        currentDoctorRole: homeDataModel.role.toString(),
        currentDoctorPoints:
            int.tryParse(homeDataModel.scoreValue ?? '') ?? currentDoctorPoints,
        homeDataModel: homeDataModel,
        initialIndex: 0,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  void _openPatients(BuildContext context) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.profilePatients,
      arguments: AppRoutesArgs.profilePatientsRouteArgs(
        doctorId: cubit.currentDoctor.id.toString(),
        currentDoctorModel: cubit.currentDoctor,
        accountVerification: accountVerification,
        currentDoctorPoints: currentDoctorPoints,
        isSyndicateCardRequired: isSyndicateCardRequired,
        doctorFirstName: cubit.currentDoctor.firstName.toString(),
        currentDoctorRole: currentDoctorRole,
        homeDataModel: homeDataModel,
      ),
    );
  }

  void _openScore(BuildContext context) {
    showCustomBottomSheet(
      context: context,
      heightFactor: 0.72,
      builder: (context) {
        return BlocProvider(
          create: (context) => ScoreHistoryCubit(sl()),
          child: ScoreHistoryScreen(
            doctorId: cubit.currentDoctor.id.toString(),
          ),
        );
      },
    );
  }

  void _openSavedPosts(BuildContext context) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.savedPosts,
      arguments: AppRoutesArgs.savedPostsRouteArgs(
        currentDoctorModel: currentDoctorModel,
        homeDataModel: homeDataModel,
        doctorId: currentDoctorModel.id.toString(),
        doctorName: _displayName,
      ),
    );
  }

  void _openAllPosts(BuildContext context) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.allDoctorPosts,
      arguments: AppRoutesArgs.allDoctorPostsRouteArgs(
        currentDoctorModel: currentDoctorModel,
        homeDataModel: homeDataModel,
        doctorId: currentDoctorModel.id.toString(),
        doctorName: _displayName,
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String initials;
  final String? imageUrl;
  final String displayName;
  final String specialtyLine;
  final bool isVerified;
  final VoidCallback onAvatarTap;

  const _ProfileHeader({
    required this.isDark,
    required this.primary,
    required this.initials,
    required this.imageUrl,
    required this.displayName,
    required this.specialtyLine,
    required this.isVerified,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? HomeDashboardColors.cardBg(true) : Colors.white;
    final bannerHeight = 82.h;
    final avatarRadius = 38.r;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(26.r),
            border: isDark
                ? Border.all(
                    color: HomeDashboardColors.border(true).withOpacity(0.55),
                  )
                : null,
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.045),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              SizedBox(
                height: bannerHeight + avatarRadius,
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: bannerHeight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isDark
                                ? const [
                                    Color(0xFF7C3AED),
                                    Color(0xFF5B21B6),
                                    Color(0xFF4C1D95),
                                  ]
                                : const [
                                    Color(0xFFC4B5FD),
                                    Color(0xFFA78BFA),
                                    Color(0xFF8B5CF6),
                                  ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: GestureDetector(
                        onTap: onAvatarTap,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: cardBg,
                                border: Border.all(
                                  color: isDark
                                      ? HomeDashboardColors.border(true)
                                          .withOpacity(0.8)
                                      : Colors.white,
                                  width: isDark ? 1.5 : 3.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(isDark ? 0.35 : 0.08),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: cardBg,
                                    width: 2.5,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: avatarRadius,
                                  backgroundColor: isDark
                                      ? const Color(0xFF2A2A2E)
                                      : const Color(0xFFF3F0FF),
                                  child: imageUrl == null || imageUrl!.isEmpty
                                      ? Text(
                                          initials,
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                            color: isDark
                                                ? const Color(0xFFD1D5DB)
                                                : primary,
                                          ),
                                        )
                                      : ClipOval(
                                          child: CustomCachedNetworkImage(
                                            imageUrl: imageUrl!,
                                            height: avatarRadius * 2,
                                            width: avatarRadius * 2,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            if (isVerified)
                              Positioned(
                                right: -1,
                                bottom: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(1.5.w),
                                  child: Icon(
                                    Icons.verified_rounded,
                                    size: 16.sp,
                                    color: HomeDashboardColors.success,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 14.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            displayName,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? HomeDashboardColors.title(true)
                                  : const Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        if (isVerified) ...[
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.verified_rounded,
                            size: 14.sp,
                            color: HomeDashboardColors.success,
                          ),
                        ],
                      ],
                    ),
                    if (specialtyLine.isNotEmpty) ...[
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF2E2248)
                              : const Color(0xFFF3E8FF),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.medical_services_outlined,
                              size: 12.sp,
                              color: isDark
                                  ? const Color(0xFFC4B5FD)
                                  : const Color(0xFF7C3AED),
                            ),
                            SizedBox(width: 5.w),
                            Flexible(
                              child: Text(
                                specialtyLine,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? const Color(0xFFC4B5FD)
                                      : const Color(0xFF6D28D9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

class _VerificationCard extends StatelessWidget {
  final bool isDark;

  const _VerificationCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF14532D).withOpacity(0.55)
            : const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark
              ? const Color(0xFF22C55E).withOpacity(0.35)
              : const Color(0xFFA7F3D0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34.r,
            height: 34.r,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF22C55E).withOpacity(0.28)
                  : const Color(0xFFD1FAE5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.verified_rounded,
              color: isDark ? const Color(0xFF4ADE80) : const Color(0xFF10B981),
              size: 18.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(AppStrings.verifiedAccount),
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF1F2937),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  context.tr(AppStrings.emailAndSyndicateCardConfirmed),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final bool isDark;
  final String patients;
  final String score;
  final String savedPosts;
  final String allPosts;
  final VoidCallback onPatients;
  final VoidCallback onScore;
  final VoidCallback onSaved;
  final VoidCallback onAllPosts;

  const _StatsGrid({
    required this.isDark,
    required this.patients,
    required this.score,
    required this.savedPosts,
    required this.allPosts,
    required this.onPatients,
    required this.onScore,
    required this.onSaved,
    required this.onAllPosts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatTile(
                isDark: isDark,
                icon: Icons.people_alt_rounded,
                iconBg: const Color(0xFF8B5CF6),
                value: patients,
                label: context.tr(AppStrings.myPatients),
                onTap: onPatients,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _StatTile(
                isDark: isDark,
                icon: Icons.workspace_premium_rounded,
                iconBg: const Color(0xFFF59E0B),
                value: score,
                label: context.tr(AppStrings.score),
                onTap: onScore,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: _StatTile(
                isDark: isDark,
                icon: Icons.bookmark_rounded,
                iconBg: const Color(0xFF3B82F6),
                value: savedPosts,
                label: context.tr(AppStrings.savedPosts),
                onTap: onSaved,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _StatTile(
                isDark: isDark,
                icon: Icons.article_rounded,
                iconBg: const Color(0xFF22C55E),
                value: allPosts,
                label: context.tr(AppStrings.allPosts),
                onTap: onAllPosts,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final Color iconBg;
  final String value;
  final String label;
  final VoidCallback onTap;

  const _StatTile({
    required this.isDark,
    required this.icon,
    required this.iconBg,
    required this.value,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: HomeDashboardDecor.card(isDark),
          child: Row(
            children: [
              Container(
                width: 30.r,
                height: 30.r,
                decoration: BoxDecoration(
                  color: iconBg.withOpacity(isDark ? 0.18 : 0.12),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Icon(icon, color: iconBg, size: 15.sp),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.w500,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: HomeDashboardColors.subtitle(isDark),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItemData {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuItemData({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class _MenuCard extends StatelessWidget {
  final bool isDark;
  final List<_MenuItemData> items;

  const _MenuCard({
    required this.isDark,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: HomeDashboardDecor.card(isDark),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _MenuRow(isDark: isDark, item: items[i]),
            if (i != items.length - 1)
              Divider(
                height: 1,
                indent: 54.w,
                color: HomeDashboardColors.border(isDark).withOpacity(0.6),
              ),
          ],
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final bool isDark;
  final _MenuItemData item;

  const _MenuRow({
    required this.isDark,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            children: [
              Container(
                width: 34.r,
                height: 34.r,
                decoration: BoxDecoration(
                  color: item.iconBg.withOpacity(isDark ? 0.18 : 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(item.icon, color: item.iconBg, size: 16.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      item.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.w500,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: HomeDashboardColors.subtitle(isDark),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignOutCard extends StatelessWidget {
  final bool isDark;
  final bool loading;
  final VoidCallback? onTap;

  const _SignOutCard({
    required this.isDark,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: HomeDashboardDecor.card(isDark),
          child: Row(
            children: [
              Container(
                width: 34.r,
                height: 34.r,
                decoration: BoxDecoration(
                  color: HomeDashboardColors.danger.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: HomeDashboardColors.danger,
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: loading
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 18.r,
                          height: 18.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: HomeDashboardColors.danger,
                          ),
                        ),
                      )
                    : Text(
                        context.tr(AppStrings.signOut),
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w700,
                          color: HomeDashboardColors.danger,
                        ),
                      ),
              ),
              if (!loading)
                Icon(
                  Icons.chevron_right_rounded,
                  color: HomeDashboardColors.subtitle(isDark),
                  size: 16.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
