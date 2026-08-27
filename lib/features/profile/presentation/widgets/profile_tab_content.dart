import 'dart:math' as math;

import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/widgets/local_profile_avatar_image.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_email_verification_banner.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_syndicate_card_banner.dart';
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
          final isCameraBusy = cubit.isCameraBusy;
          final doctorFromCubit = state.maybeWhen(
            loaded: (doctor, _) => doctor,
            orElse: () => cubit.currentDoctor.id != null
                ? cubit.currentDoctor
                : currentDoctorModel,
          );
          final homeCubit = context.watch<HomeCubit>();
          // Prefer HomeCubit models — updated immediately on role change.
          final effectiveHome = homeCubit.homeDataModel.userType != null &&
                  homeCubit.homeDataModel.userType!.isNotEmpty
              ? homeCubit.homeDataModel
              : homeDataModel;
          final effectiveDoctor =
              homeCubit.currentDoctorModel.userType != null &&
                      homeCubit.currentDoctorModel.userType!.isNotEmpty
                  ? homeCubit.currentDoctorModel
                  : doctorFromCubit;
          final imageUrl = doctorFromCubit.image ?? currentDoctorModel.image;
          final emailVerified = isDoctorEmailVerified(
            doctor: effectiveDoctor,
            homeData: effectiveHome,
          );
          final bothVerified = _isVerified && emailVerified;
          final isResearchUser = isResearchMember(
            effectiveHome,
            doctor: effectiveDoctor,
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
                  imageUrl: imageUrl,
                  imageRevision: cubit.imageRevision,
                  displayName: _displayName,
                  specialtyLine: _specialtyLine,
                  isVerified: _isVerified,
                  isCameraBusy: isCameraBusy,
                  onAvatarTap: () => _openDoctorInfo(),
                  onCameraTap: isCameraBusy
                      ? null
                      : () => _onChangeProfilePhoto(context, cubit),
                ),
              ),
              if (bothVerified)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                    child: _VerificationCard(isDark: isDark),
                  ),
                )
              else
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                    child: ProfileEmailVerificationStatus(
                      isDark: isDark,
                      isVerified: emailVerified,
                      email: doctorFromCubit.email ?? currentDoctorModel.email,
                      onTap: () {
                        navigatorKey.currentState?.pushNamed(
                          AppRoutes.emailVerification,
                          arguments:
                              AppRoutesArgs.emailVerificationRouteArgs(
                            currentDoctorModel: doctorFromCubit,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              if (needsSyndicateCardVerification(
                doctor: effectiveDoctor,
                homeData: effectiveHome,
              ))
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, homeState) {
                        final isUploading = homeState.maybeWhen(
                          loaded: (
                            _,
                            __,
                            ___,
                            ____,
                            isUploadingSyndicateCard,
                            _____,
                            ______,
                            _______,
                            ________,
                            _________,
                          ) =>
                              isUploadingSyndicateCard,
                          orElse: () => false,
                        );
                        return ProfileSyndicateCardStatus(
                          isDark: isDark,
                          isPending:
                              isSyndicateCardPending(effectiveHome),
                          isUploading: isUploading,
                          onTap: () {
                            context.read<HomeCubit>().uploadSyndicateCard();
                          },
                        );
                      },
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                  child: _StatsGrid(
                    isDark: isDark,
                    showClinicalStats: isResearchUser,
                    patients:
                        context.read<HomeCubit>().doctorPatientCount ?? '0',
                    score: context.read<HomeCubit>().doctorScore ??
                        currentDoctorPoints.toString(),
                    savedPosts: effectiveHome.savedPosts ?? '0',
                    allPosts: effectiveHome.postsCount ?? '0',
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
                    items: _menuItems(
                      context,
                      showResearchFeatures: isResearchUser,
                      homeData: effectiveHome,
                      doctor: effectiveDoctor,
                    ),
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

  List<_MenuItemData> _menuItems(
    BuildContext context, {
    required bool showResearchFeatures,
    required HomeModelResponse homeData,
    required DoctorModel doctor,
  }) {
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

    if (showResearchFeatures &&
        PermissionHelper.canPermission(
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
                homeDataModel: homeData,
                currentDoctorModel: doctor,
                initialTab: 0,
              ),
            );
          },
        ),
      );
    }

    if (showResearchFeatures &&
        PermissionHelper.canPermission(
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
                    currentDoctorId: doctor.id.toString(),
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
                  currentDoctorModel: doctor,
                  accountVerification: accountVerification,
                  homeDataModel: homeData,
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

  Future<void> _onChangeProfilePhoto(
    BuildContext context,
    ProfileCubit cubit,
  ) async {
    final picked = await cubit.pickProfileImage();
    if (picked == null || !context.mounted) return;

    // Let the pick loading state settle before presenting the dialog.
    await Future<void>.delayed(const Duration(milliseconds: 16));
    if (!context.mounted) return;

    final confirmed = await showGeneralDialog<bool>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      barrierLabel: 'profile-photo-confirm',
      barrierColor: const Color(0x99000000),
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        final dialogIsDark =
            Theme.of(dialogContext).brightness == Brightness.dark;
        final cardBg =
            dialogIsDark ? HomeDashboardColors.cardBg(true) : Colors.white;
        final titleColor = dialogIsDark
            ? HomeDashboardColors.title(true)
            : const Color(0xFF1F2937);
        final descColor = dialogIsDark
            ? HomeDashboardColors.subtitle(true)
            : const Color(0xFF6B7280);
        final primary = HomeDashboardColors.primary(dialogIsDark);
        final maxWidth = MediaQuery.sizeOf(dialogContext).width;
        final dialogWidth = maxWidth > 420 ? 340.0 : maxWidth - 48.0;

        return SafeArea(
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: dialogWidth,
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.14),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.tr(AppStrings.updateProfilePhoto),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primary.withOpacity(0.35),
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.file(
                          picked,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                          filterQuality: FilterQuality.medium,
                          cacheWidth: 280,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      context.tr(AppStrings.useThisPhotoAsYourProfilePicture),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        height: 1.35,
                        color: descColor,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(false),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: descColor,
                              side: BorderSide(
                                color: dialogIsDark
                                    ? HomeDashboardColors.border(true)
                                    : const Color(0xFFE5E7EB),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              context.tr(AppStrings.cancel),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop(true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              context.tr(AppStrings.confirm),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Fade only — scale feels jittery on many devices.
        final opacity = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        );
        return FadeTransition(
          opacity: opacity,
          child: child,
        );
      },
    );

    if (!context.mounted) return;
    // Let the dialog fade-out finish before starting upload UI work.
    await Future<void>.delayed(const Duration(milliseconds: 240));
    if (!context.mounted) return;

    if (confirmed == true) {
      await cubit.uploadPickedProfileImage();
    } else {
      cubit.discardPickedProfileImage();
    }
  }
}

class _ProfileHeader extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String initials;
  final String? imageUrl;
  final int imageRevision;
  final String displayName;
  final String specialtyLine;
  final bool isVerified;
  final bool isCameraBusy;
  final VoidCallback onAvatarTap;
  final VoidCallback? onCameraTap;

  const _ProfileHeader({
    required this.isDark,
    required this.primary,
    required this.initials,
    required this.imageUrl,
    required this.imageRevision,
    required this.displayName,
    required this.specialtyLine,
    required this.isVerified,
    required this.isCameraBusy,
    required this.onAvatarTap,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? HomeDashboardColors.cardBg(true) : Colors.white;
    final bannerHeight = 110.h;
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
                      child: _ProfileBannerArt(
                        isDark: isDark,
                        height: bannerHeight,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: onAvatarTap,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOutCubic,
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
                                  child: ClipOval(
                                    child: SizedBox(
                                      height: avatarRadius * 2,
                                      width: avatarRadius * 2,
                                      child: LocalProfileAvatarImage(
                                        imageUrl: imageUrl,
                                        revision: imageRevision,
                                        height: avatarRadius * 2,
                                        width: avatarRadius * 2,
                                        fallback: Center(
                                          child: Text(
                                            initials,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              color: isDark
                                                  ? const Color(0xFFD1D5DB)
                                                  : primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: -4,
                            bottom: -2,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12.r),
                                onTap: onCameraTap,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 160),
                                  opacity: onCameraTap == null ? 0.85 : 1,
                                  child: Container(
                                    width: 36.w,
                                    height: 36.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF22D3EE),
                                          Color(0xFF6366F1),
                                          Color(0xFF7C3AED),
                                        ],
                                        stops: [0.0, 0.55, 1.0],
                                      ),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(
                                          isDark ? 0.28 : 0.7,
                                        ),
                                        width: 1.6,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF22D3EE)
                                              .withOpacity(isDark ? 0.35 : 0.28),
                                          blurRadius: 14,
                                          offset: const Offset(0, 4),
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                            isDark ? 0.35 : 0.08,
                                          ),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        if (isCameraBusy)
                                          SizedBox(
                                            width: 15.w,
                                            height: 15.w,
                                            child:
                                                const CircularProgressIndicator(
                                              strokeWidth: 1.8,
                                              color: Colors.white,
                                            ),
                                          )
                                        else ...[
                                          Icon(
                                            Icons.photo_camera_rounded,
                                            size: 15.sp,
                                            color: Colors.white,
                                          ),
                                          Positioned(
                                            right: 5.w,
                                            bottom: 5.w,
                                            child: Container(
                                              width: 11.w,
                                              height: 11.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.18),
                                                    blurRadius: 3,
                                                  ),
                                                ],
                                              ),
                                              child: Icon(
                                                Icons.add_rounded,
                                                size: 9.sp,
                                                color: const Color(0xFF4F46E5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

/// Bold liquid-wave kidney banner — vivid color blocks + glowing organ mark.
class _ProfileBannerArt extends StatefulWidget {
  final bool isDark;
  final double height;

  const _ProfileBannerArt({
    required this.isDark,
    required this.height,
  });

  @override
  State<_ProfileBannerArt> createState() => _ProfileBannerArtState();
}

class _ProfileBannerArtState extends State<_ProfileBannerArt>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _logoController;
  late final Animation<double> _t;
  late final Animation<double> _logoPulse;
  late final Animation<double> _logoGlow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
    _t = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _logoPulse = Tween<double>(begin: 0.96, end: 1.05).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );
    _logoGlow = Tween<double>(begin: 0.35, end: 0.85).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    return AnimatedBuilder(
      animation: Listenable.merge([_t, _logoController]),
      builder: (context, _) {
        final p = _t.value;
        final drift = (p - 0.5) * 2;
        final floatY = math.sin(p * math.pi * 2) * 3.5;

        return Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.hardEdge,
          children: [
            // Vivid clinical base
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? const [
                          Color(0xFF1E1B4B),
                          Color(0xFF4C1D95),
                          Color(0xFF0E7490),
                          Color(0xFF134E4A),
                        ]
                      : const [
                          Color(0xFF818CF8),
                          Color(0xFF22D3EE),
                          Color(0xFFA78BFA),
                          Color(0xFF67E8F9),
                        ],
                  stops: const [0.0, 0.35, 0.7, 1.0],
                ),
              ),
            ),

            // Bold morphing liquid wave layer
            CustomPaint(
              painter: _LiquidWavePainter(
                progress: p,
                isDark: isDark,
              ),
            ),

            // Giant glowing kidney silhouette
            Positioned(
              right: -8 + drift * 6,
              top: -4,
              bottom: -10,
              width: 150,
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _BoldKidneyMarkPainter(
                    progress: p,
                    isDark: isDark,
                  ),
                ),
              ),
            ),

            // Hot glow orbs
            Positioned(
              left: -20 + drift * 18,
              top: -28,
              child: _GlowOrb(
                size: 110,
                color: isDark
                    ? const Color(0xFFF0ABFC).withOpacity(0.45)
                    : Colors.white.withOpacity(0.55),
              ),
            ),
            Positioned(
              left: 70 - drift * 10,
              bottom: -36,
              child: _GlowOrb(
                size: 90,
                color: isDark
                    ? const Color(0xFF22D3EE).withOpacity(0.4)
                    : const Color(0xFFA5F3FC).withOpacity(0.7),
              ),
            ),

            // Spark dots
            ...List.generate(7, (i) {
              final ax = -0.85 + i * 0.22;
              final ay =
                  -0.55 + (i % 3) * 0.4 + drift * 0.06 * (i.isEven ? 1 : -1);
              return Align(
                alignment:
                    Alignment(ax.clamp(-1.0, 0.4), ay.clamp(-0.85, 0.7)),
                child: IgnorePointer(
                  child: Container(
                    width: 4 + (i % 3).toDouble(),
                    height: 4 + (i % 3).toDouble(),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(isDark ? 0.55 : 0.7),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF67E8F9).withOpacity(0.6),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // Animated EgyAkin logo
            Positioned(
              left: 14,
              top: 14 + floatY,
              child: Transform.scale(
                scale: _logoPulse.value,
                child: _AnimatedBannerLogo(
                  glow: _logoGlow.value,
                  spin: p,
                  isDark: isDark,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 34,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      (isDark ? const Color(0xFF1A1428) : Colors.white)
                          .withOpacity(isDark ? 0.35 : 0.25),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AnimatedBannerLogo extends StatelessWidget {
  final double glow;
  final double spin;
  final bool isDark;

  const _AnimatedBannerLogo({
    required this.glow,
    required this.spin,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 52,
          height: 52,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Soft outer glow
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF67E8F9).withOpacity(0.35 * glow),
                      blurRadius: 16,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: const Color(0xFFA78BFA).withOpacity(0.25 * glow),
                      blurRadius: 22,
                    ),
                  ],
                ),
              ),
              // Rotating dashed ring
              Transform.rotate(
                angle: spin * 6.28318,
                child: CustomPaint(
                  size: const Size(50, 50),
                  painter: _LogoRingPainter(
                    progress: glow,
                    isDark: isDark,
                  ),
                ),
              ),
              // Logo glass disc
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(isDark ? 0.16 : 0.88),
                  border: Border.all(
                    color: Colors.white.withOpacity(isDark ? 0.45 : 0.95),
                    width: 1.4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    AppImages.appIcon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Wordmark
        Opacity(
          opacity: 0.55 + glow * 0.4,
          child: Image.asset(
            AppImages.whiteEgyAkin,
            height: 16,
            color: Colors.white,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}

class _LogoRingPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _LogoRingPainter({
    required this.progress,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 1.5;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF67E8F9).withOpacity(0.35 + progress * 0.45);

    const dashes = 14;
    const sweep = 6.28318 / dashes;
    for (var i = 0; i < dashes; i++) {
      if (i.isOdd) continue;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * sweep,
        sweep * 0.55,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LogoRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isDark != isDark;
  }
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withOpacity(0)],
          ),
        ),
      ),
    );
  }
}

class _LiquidWavePainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _LiquidWavePainter({required this.progress, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final drift = (progress - 0.5) * 2;

    // Layer 1 — bold violet ribbon
    final wave1 = Path()
      ..moveTo(0, size.height * (0.35 + drift * 0.04))
      ..cubicTo(
        size.width * 0.25,
        size.height * (0.05 - drift * 0.06),
        size.width * 0.55,
        size.height * (0.75 + drift * 0.05),
        size.width,
        size.height * (0.25 - drift * 0.04),
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(
      wave1,
      Paint()
        ..shader = LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFFA855F7).withOpacity(0.55),
                  const Color(0xFF6366F1).withOpacity(0.15),
                ]
              : [
                  Colors.white.withOpacity(0.45),
                  const Color(0xFFC4B5FD).withOpacity(0.25),
                ],
        ).createShader(Offset.zero & size),
    );

    // Layer 2 — cyan sweep
    final wave2 = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * (0.55 - drift * 0.05))
      ..cubicTo(
        size.width * 0.3,
        size.height * (0.85 + drift * 0.06),
        size.width * 0.65,
        size.height * (0.2 - drift * 0.05),
        size.width,
        size.height * (0.65 + drift * 0.04),
      )
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(
      wave2,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: isDark
              ? [
                  const Color(0xFF22D3EE).withOpacity(0.5),
                  const Color(0xFF2DD4BF).withOpacity(0.12),
                ]
              : [
                  const Color(0xFF67E8F9).withOpacity(0.55),
                  Colors.white.withOpacity(0.2),
                ],
        ).createShader(Offset.zero & size),
    );

    // Accent stroke on wave crest
    final crest = Path()
      ..moveTo(0, size.height * (0.55 - drift * 0.05))
      ..cubicTo(
        size.width * 0.3,
        size.height * (0.85 + drift * 0.06),
        size.width * 0.65,
        size.height * (0.2 - drift * 0.05),
        size.width,
        size.height * (0.65 + drift * 0.04),
      );
    canvas.drawPath(
      crest,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..color = Colors.white.withOpacity(isDark ? 0.35 : 0.5),
    );
  }

  @override
  bool shouldRepaint(covariant _LiquidWavePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isDark != isDark;
  }
}

class _BoldKidneyMarkPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _BoldKidneyMarkPainter({required this.progress, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width * 0.52, size.height * 0.48);
    final h = size.height * 0.72;
    final path = _bean(c, h);

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white.withOpacity(isDark ? 0.12 : 0.22),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..color = Colors.white.withOpacity(isDark ? 0.55 : 0.65),
    );

    // Inner glow ring
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..color = const Color(0xFF67E8F9).withOpacity(isDark ? 0.2 : 0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );

    // Hilum accent
    canvas.drawCircle(
      Offset(c.dx - h * 0.08, c.dy + h * 0.02),
      5,
      Paint()..color = const Color(0xFF22D3EE).withOpacity(0.85),
    );
  }

  Path _bean(Offset c, double h) {
    final w = h * 0.7;
    final path = Path();
    path.moveTo(c.dx, c.dy - h * 0.45);
    path.cubicTo(
      c.dx + w * 0.55,
      c.dy - h * 0.45,
      c.dx + w * 0.62,
      c.dy + h * 0.08,
      c.dx + w * 0.25,
      c.dy + h * 0.42,
    );
    path.cubicTo(
      c.dx,
      c.dy + h * 0.55,
      c.dx - w * 0.18,
      c.dy + h * 0.28,
      c.dx - w * 0.05,
      c.dy + h * 0.05,
    );
    path.cubicTo(
      c.dx + w * 0.08,
      c.dy - h * 0.1,
      c.dx - w * 0.28,
      c.dy - h * 0.12,
      c.dx - w * 0.42,
      c.dy + h * 0.05,
    );
    path.cubicTo(
      c.dx - w * 0.62,
      c.dy + h * 0.22,
      c.dx - w * 0.55,
      c.dy - h * 0.4,
      c.dx,
      c.dy - h * 0.45,
    );
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _BoldKidneyMarkPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isDark != isDark;
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
  final bool showClinicalStats;
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
    this.showClinicalStats = true,
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
        if (showClinicalStats) ...[
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  isDark: isDark,
                  icon: Icons.people_alt_rounded,
                  iconBg: const Color(0xFF8B5CF6),
                  value: patients,
                  label: context.tr(AppStrings.patients),
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
        ],
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
