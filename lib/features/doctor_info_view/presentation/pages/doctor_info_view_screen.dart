import 'dart:ui';

import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class DoctorInfoViewScreen extends StatefulWidget {
  final String doctorId;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String isSyndicateCardRequired;
  final bool accountVerification;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final int initialIndex;
  final bool isNavigateToTheButtonOfInformationTab;

  const DoctorInfoViewScreen({
    super.key,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.isSyndicateCardRequired,
    required this.accountVerification,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    required this.initialIndex,
    required this.isNavigateToTheButtonOfInformationTab,
  });

  @override
  State<DoctorInfoViewScreen> createState() => _DoctorInfoViewScreenState();
}

class _DoctorInfoViewScreenState extends State<DoctorInfoViewScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AnimationController _introController;
  final GlobalKey _tabBodyKey = GlobalKey();
  bool _didAutoScrollToSyndicate = false;

  late final Animation<double> _heroFade;
  late final Animation<double> _bodyFade;

  bool get _isOwnProfile =>
      widget.doctorId == widget.currentDoctorModel.id.toString();

  @override
  void initState() {
    super.initState();
    context.read<DoctorInfoViewCubit>().getDoctorInfo(widget.doctorId);

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialIndex.clamp(0, 1),
    )..addListener(_onTabChanged);

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _heroFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    );
    _bodyFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.25, 1.0, curve: Curves.easeOut),
    );

    _introController.forward();
  }

  void _onTabChanged() {
    if (!mounted) return;
    setState(() {});

    if (_tabController.indexIsChanging) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final cubit = context.read<DoctorInfoViewCubit>();
      try {
        final bodyContext = _tabBodyKey.currentContext;
        if (bodyContext != null && bodyContext.mounted) {
          Scrollable.ensureVisible(
            bodyContext,
            alignment: 0.02,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
          );
          return;
        }
      } catch (_) {
        // Fall through to clamp.
      }
      cubit.clampDoctorInfoScroll();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = DoctorInfoViewCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Colors.transparent,
                ),
          child: Scaffold(
            backgroundColor: scaffold,
            body: BlocConsumer<DoctorInfoViewCubit, DoctorInfoViewState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (
                    doctorInfo,
                    isLoadingAchievements,
                    isLoadedAchievements,
                    message,
                    achievements,
                    changesCounter,
                  ) {
                    if (widget.isNavigateToTheButtonOfInformationTab &&
                        !_didAutoScrollToSyndicate) {
                      _didAutoScrollToSyndicate = true;
                      if (_tabController.index != 0) {
                        _tabController.animateTo(0);
                      }
                      Future.delayed(const Duration(milliseconds: 280), () {
                        if (!mounted) return;
                        cubit.scrollToSyndicateCardSection();
                      });
                    } else {
                      // Keep scroll in range after content height changes
                      // (e.g. syndicate card confirm/reject).
                      cubit.clampDoctorInfoScroll();
                    }
                  },
                );
              },
              builder: (context, state) {
                return CustomScrollView(
                  controller: cubit.doctorInfoViewScrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    SliverToBoxAdapter(
                      child: FadeTransition(
                        opacity: _heroFade,
                        child: _ProfileHeader(
                          isDark: isDark,
                          primary: primary,
                          scaffold: scaffold,
                          isOwnProfile: _isOwnProfile,
                          state: state,
                          onBack: () => Navigator.of(context).maybePop(),
                          onEdit: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              navigatorKey.currentState?.pushReplacementNamed(
                                AppRoutes.home,
                                arguments: 4,
                              );
                            });
                          },
                          onOpenImage: (imageUrl) {
                            Navigator.push(
                              context,
                              FullScreenImage.route(imageUrl: imageUrl),
                            );
                          },
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: FadeTransition(
                        opacity: _bodyFade,
                        child: Column(
                          children: [
                            SizedBox(height: 4.h),
                            _MetricsRail(
                              isDark: isDark,
                              primary: primary,
                              state: state,
                              doctorId: widget.doctorId,
                              currentDoctorModel: widget.currentDoctorModel,
                              homeDataModel: widget.homeDataModel,
                              accountVerification: widget.accountVerification,
                              currentDoctorPoints: widget.currentDoctorPoints,
                              isSyndicateCardRequired:
                                  widget.isSyndicateCardRequired,
                              currentDoctorRole: widget.currentDoctorRole,
                            ),
                            SizedBox(height: 12.h),
                          ],
                        ),
                      ),
                    ),
                    // Keep tabs in the scroll flow so they never sit under the status bar.
                    SliverToBoxAdapter(
                      child: ColoredBox(
                        color: scaffold,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 8.h),
                          child: _SegmentedTabs(
                            controller: _tabController,
                            isDark: isDark,
                            primary: primary,
                            labels: [
                              context.tr(AppStrings.information),
                              context.tr(AppStrings.achievements),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: FadeTransition(
                        opacity: _bodyFade,
                        child: KeyedSubtree(
                          key: _tabBodyKey,
                          child: _tabController.index == 0
                              ? InformationTab(
                                  nestInParentScroll: true,
                                  homeDataModel: widget.homeDataModel,
                                  currentDoctorModel: widget.currentDoctorModel,
                                )
                              : AchievementsTab(
                                  nestInParentScroll: true,
                                  isProfileFeature: false,
                                  currentDoctorId: widget.doctorId,
                                ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 36.h)),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// ── Profile header (hero + credentials) ──────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final Color scaffold;
  final bool isOwnProfile;
  final DoctorInfoViewState state;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final ValueChanged<String> onOpenImage;

  const _ProfileHeader({
    required this.isDark,
    required this.primary,
    required this.scaffold,
    required this.isOwnProfile,
    required this.state,
    required this.onBack,
    required this.onEdit,
    required this.onOpenImage,
  });

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return ColoredBox(
      color: scaffold,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(8.w, top + 4.h, 12.w, 34.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? const [
                        Color(0xFF0B1220),
                        Color(0xFF1A1035),
                        Color(0xFF0F172A),
                      ]
                    : const [
                        Color(0xFFDDD6FE),
                        Color(0xFFC4B5FD),
                        Color(0xFFA78BFA),
                      ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _GlassIconButton(
                      isDark: isDark,
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: onBack,
                    ),
                    const Spacer(),
                    if (isOwnProfile)
                      _GlassIconButton(
                        isDark: isDark,
                        icon: Icons.edit_rounded,
                        onTap: onEdit,
                      ),
                  ],
                ),
                SizedBox(height: 14.h),
                state.maybeWhen(
                  orElse: () => _HeroLoading(isDark: isDark),
                  loaded: (doctorInfo, _, __, ___, ____, _____) {
                    final data = doctorInfo?.data;
                    final image = data?.image?.toString() ?? '';
                    final firstName = data?.firstName ?? '';
                    final lastName = data?.lastName ?? '';
                    final initial = firstName.isNotEmpty
                        ? firstName[0].toUpperCase()
                        : 'D';
                    final name = doctorName(
                      firstName: firstName,
                      lastName: lastName,
                      role: data?.isSyndicateCardRequired ?? '',
                    );
                    final specialty = capitalizeFirstText(
                          data?.specialty ?? AppStrings.empty,
                        ) ??
                        '';
                    final verified =
                        data?.isSyndicateCardRequired == 'Verified';
                    final workplace = data?.workingplace?.trim() ?? '';
                    final titleColor =
                        isDark ? Colors.white : const Color(0xFF1F2937);
                    final mutedColor =
                        isDark ? Colors.white70 : const Color(0xFF4B5563);
                    final specialtyColor = isDark
                        ? const Color(0xFFA5B4FC)
                        : const Color(0xFF5B21B6);

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _ProfileAvatar(
                          isDark: isDark,
                          image: image,
                          initial: initial,
                          onOpenImage: onOpenImage,
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (verified)
                                Container(
                                  margin: EdgeInsets.only(bottom: 6.h),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF2DD4BF)
                                            .withOpacity(0.18)
                                        : const Color(0xFFCCFBF1),
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: isDark
                                          ? const Color(0xFF2DD4BF)
                                              .withOpacity(0.45)
                                          : const Color(0xFF5EEAD4),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.verified_rounded,
                                        size: 13.sp,
                                        color: isDark
                                            ? const Color(0xFF5EEAD4)
                                            : const Color(0xFF0F766E),
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        context.tr(
                                            AppStrings.verifiedClinician),
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                          color: isDark
                                              ? const Color(0xFF99F6E4)
                                              : const Color(0xFF0F766E),
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Text(
                                name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  height: 1.15,
                                  fontWeight: FontWeight.w800,
                                  color: titleColor,
                                  letterSpacing: -0.4,
                                ),
                              ),
                              if (specialty.isNotEmpty) ...[
                                SizedBox(height: 5.h),
                                Text(
                                  specialty,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.4,
                                    color: specialtyColor,
                                  ),
                                ),
                              ],
                              if (workplace.isNotEmpty) ...[
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.place_outlined,
                                      size: 13.sp,
                                      color: mutedColor,
                                    ),
                                    SizedBox(width: 4.w),
                                    Flexible(
                                      child: Text(
                                        workplace,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: mutedColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // Frosted credentials card — same pattern as group details
          Transform.translate(
            offset: Offset(0, -18.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _CredentialsCard(
                isDark: isDark,
                primary: primary,
                state: state,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final bool isDark;
  final String image;
  final String initial;
  final ValueChanged<String> onOpenImage;

  const _ProfileAvatar({
    required this.isDark,
    required this.image,
    required this.initial,
    required this.onOpenImage,
  });

  @override
  Widget build(BuildContext context) {
    final size = 76.r;
    final borderColor =
        isDark ? Colors.white.withOpacity(0.92) : Colors.white;

    return GestureDetector(
      onTap: image.isEmpty ? null : () => onOpenImage(image),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.25 : 0.12),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipOval(
          child: image.isEmpty
              ? ColoredBox(
                  color: isDark
                      ? Colors.white.withOpacity(0.12)
                      : Colors.white.withOpacity(0.55),
                  child: Center(
                    child: Text(
                      initial,
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF5B21B6),
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                )
              : CustomCachedNetworkImage(
                  imageUrl: image,
                  height: size,
                  width: size,
                ),
        ),
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final VoidCallback onTap;

  const _GlassIconButton({
    required this.isDark,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark
          ? Colors.white.withOpacity(0.1)
          : Colors.white.withOpacity(0.55),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 36.r,
          height: 36.r,
          child: Icon(
            icon,
            size: 17.sp,
            color: isDark ? Colors.white : const Color(0xFF1F2937),
          ),
        ),
      ),
    );
  }
}

class _HeroLoading extends StatelessWidget {
  final bool isDark;

  const _HeroLoading({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final shimmer = isDark ? Colors.white12 : Colors.white.withOpacity(0.45);

    return Row(
      children: [
        Container(
          width: 76.r,
          height: 76.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: shimmer,
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: shimmer,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                width: 100.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: shimmer,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CredentialsCard extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final DoctorInfoViewState state;

  const _CredentialsCard({
    required this.isDark,
    required this.primary,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: (isDark ? const Color(0xFF1E1B2E) : Colors.white)
                .withOpacity(isDark ? 0.94 : 1),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : const Color(0xFFE5E7EB),
            ),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: state.maybeWhen(
            orElse: () => Row(
              children: [
                Expanded(child: _CredentialSkeleton(isDark: isDark)),
                _CredentialDivider(isDark: isDark),
                Expanded(child: _CredentialSkeleton(isDark: isDark)),
                _CredentialDivider(isDark: isDark),
                Expanded(child: _CredentialSkeleton(isDark: isDark)),
              ],
            ),
            loaded: (doctorInfo, _, __, ___, ____, _____) {
              final job = doctorInfo?.data?.job?.trim();
              final degree = doctorInfo?.data?.highestdegree?.trim();
              final specialty = doctorInfo?.data?.specialty?.trim();
              final noData = context.tr(AppStrings.noData);

              return Row(
                children: [
                  Expanded(
                    child: _CredentialStat(
                      isDark: isDark,
                      label: context.tr(AppStrings.job),
                      value: (job == null || job.isEmpty) ? noData : job,
                    ),
                  ),
                  _CredentialDivider(isDark: isDark),
                  Expanded(
                    child: _CredentialStat(
                      isDark: isDark,
                      label: context.tr(AppStrings.highestDegree),
                      value:
                          (degree == null || degree.isEmpty) ? noData : degree,
                    ),
                  ),
                  _CredentialDivider(isDark: isDark),
                  Expanded(
                    child: _CredentialStat(
                      isDark: isDark,
                      label: context.tr(AppStrings.specialty),
                      value: (specialty == null || specialty.isEmpty)
                          ? noData
                          : specialty,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CredentialStat extends StatelessWidget {
  final bool isDark;
  final String label;
  final String value;

  const _CredentialStat({
    required this.isDark,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
              color: HomeDashboardColors.title(isDark),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: HomeDashboardColors.subtitle(isDark),
            ),
          ),
        ],
      ),
    );
  }
}

class _CredentialDivider extends StatelessWidget {
  final bool isDark;

  const _CredentialDivider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 28.h,
      color: HomeDashboardColors.border(isDark).withOpacity(0.85),
    );
  }
}

class _CredentialSkeleton extends StatelessWidget {
  final bool isDark;

  const _CredentialSkeleton({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Container(
            height: 14.h,
            width: 48.w,
            decoration: BoxDecoration(
              color: HomeDashboardColors.surfaceBg(isDark),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            height: 10.h,
            width: 36.w,
            decoration: BoxDecoration(
              color: HomeDashboardColors.surfaceBg(isDark),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Metrics rail ─────────────────────────────────────────────────────────────

class _MetricsRail extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final DoctorInfoViewState state;
  final String doctorId;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final bool accountVerification;
  final int currentDoctorPoints;
  final String isSyndicateCardRequired;
  final String currentDoctorRole;

  const _MetricsRail({
    required this.isDark,
    required this.primary,
    required this.state,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.accountVerification,
    required this.currentDoctorPoints,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
  });

  @override
  Widget build(BuildContext context) {
    return state.maybeWhen(
      orElse: () => SizedBox(
        height: 96.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemBuilder: (_, __) => Container(
            width: 120.w,
            decoration: BoxDecoration(
              color: HomeDashboardColors.cardBg(isDark),
              borderRadius: BorderRadius.circular(18.r),
            ),
          ),
          separatorBuilder: (_, __) => SizedBox(width: 10.w),
          itemCount: 3,
        ),
      ),
      loaded: (doctorInfo, _, __, ___, ____, _____) {
        final verified =
            isVerifiedUser(doctorInfo?.data?.isSyndicateCardRequired);
        final doctorNameValue = doctorName(
          firstName: doctorInfo?.data?.firstName?.toString() ?? '',
          lastName: doctorInfo?.data?.lastName?.toString() ?? '',
          role: doctorInfo?.data?.isSyndicateCardRequired?.toString() ?? '',
        );

        final items = <_MetricItem>[
          if (verified)
            _MetricItem(
              icon: Icons.people_alt_rounded,
              accent: const Color(0xFF8B5CF6),
              value: doctorInfo?.patientCount?.toString() ?? '0',
              label: context.tr(AppStrings.patients),
              onTap: () {
                navigatorKey.currentState?.pushNamed(
                  AppRoutes.profilePatients,
                  arguments: AppRoutesArgs.profilePatientsRouteArgs(
                    doctorId: doctorId,
                    currentDoctorModel: currentDoctorModel,
                    accountVerification: accountVerification,
                    currentDoctorPoints: currentDoctorPoints,
                    isSyndicateCardRequired: isSyndicateCardRequired,
                    doctorFirstName:
                        doctorInfo?.data?.firstName?.toString() ?? '',
                    currentDoctorRole: currentDoctorRole,
                    homeDataModel: homeDataModel,
                  ),
                );
              },
            ),
          if (verified)
            _MetricItem(
              icon: Icons.workspace_premium_rounded,
              accent: const Color(0xFFF59E0B),
              value: doctorInfo?.scoreValue?.toString() ?? '0',
              label: context.tr(AppStrings.score),
              onTap: () {
                showCustomBottomSheet(
                  context: context,
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => ScoreHistoryCubit(sl()),
                      child: ScoreHistoryScreen(doctorId: doctorId),
                    );
                  },
                );
              },
            ),
          _MetricItem(
            icon: Icons.bookmark_rounded,
            accent: const Color(0xFF3B82F6),
            value: doctorInfo?.savedPostsCount?.toString() ?? '0',
            label: context.tr(AppStrings.savedPosts),
            onTap: () {
              navigatorKey.currentState?.pushNamed(
                AppRoutes.savedPosts,
                arguments: AppRoutesArgs.savedPostsRouteArgs(
                  currentDoctorModel: currentDoctorModel,
                  homeDataModel: homeDataModel,
                  doctorId: doctorId,
                  doctorName: doctorNameValue,
                ),
              );
            },
          ),
          _MetricItem(
            icon: Icons.dynamic_feed_rounded,
            accent: const Color(0xFF22C55E),
            value: doctorInfo?.postsCount?.toString() ?? '0',
            label: context.tr(AppStrings.allPosts),
            onTap: () {
              navigatorKey.currentState?.pushNamed(
                AppRoutes.allDoctorPosts,
                arguments: AppRoutesArgs.allDoctorPostsRouteArgs(
                  currentDoctorModel: currentDoctorModel,
                  homeDataModel: homeDataModel,
                  doctorId: doctorId,
                  doctorName: doctorNameValue,
                ),
              );
            },
          ),
        ];

        return SizedBox(
          height: 104.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final item = items[index];
              return FadeInUp(
                duration: const Duration(milliseconds: 320),
                delay: Duration(milliseconds: (50 * index).clamp(0, 200)),
                from: 10,
                child: _MetricCard(
                  isDark: isDark,
                  item: item,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _MetricItem {
  final IconData icon;
  final Color accent;
  final String value;
  final String label;
  final VoidCallback onTap;

  const _MetricItem({
    required this.icon,
    required this.accent,
    required this.value,
    required this.label,
    required this.onTap,
  });
}

class _MetricCard extends StatelessWidget {
  final bool isDark;
  final _MetricItem item;

  const _MetricCard({required this.isDark, required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Ink(
          width: 128.w,
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      item.accent.withOpacity(0.22),
                      HomeDashboardColors.cardBg(isDark),
                    ]
                  : [
                      Colors.white,
                      item.accent.withOpacity(0.08),
                    ],
            ),
            border: Border.all(
              color: item.accent.withOpacity(isDark ? 0.35 : 0.22),
            ),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: item.accent.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34.r,
                height: 34.r,
                decoration: BoxDecoration(
                  color: item.accent.withOpacity(isDark ? 0.28 : 0.14),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Icon(item.icon, size: 17.sp, color: item.accent),
              ),
              const Spacer(),
              Text(
                item.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: HomeDashboardColors.title(isDark),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Segmented tabs ───────────────────────────────────────────────────────────

class _SegmentedTabs extends StatelessWidget {
  final TabController controller;
  final bool isDark;
  final Color primary;
  final List<String> labels;

  const _SegmentedTabs({
    required this.controller,
    required this.isDark,
    required this.primary,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          height: 46.h,
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: HomeDashboardColors.surfaceBg(isDark),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDark).withOpacity(0.7),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final tabWidth = constraints.maxWidth / labels.length;
              final isRtl = Directionality.of(context) == TextDirection.rtl;
              final indicatorOffset = isRtl
                  ? (labels.length - 1 - controller.index) * tabWidth
                  : controller.index * tabWidth;
              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    left: indicatorOffset,
                    top: 0,
                    bottom: 0,
                    width: tabWidth,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.r),
                        gradient: LinearGradient(
                          colors: [
                            primary,
                            primary.withOpacity(0.82),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.28),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(labels.length, (i) {
                      final selected = controller.index == i;
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => controller.animateTo(i),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w700,
                                color: selected
                                    ? Colors.white
                                    : HomeDashboardColors.subtitle(isDark),
                              ),
                              child: Text(labels[i]),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
