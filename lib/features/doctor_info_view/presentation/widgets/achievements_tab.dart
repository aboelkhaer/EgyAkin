import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class AchievementsTab extends StatefulWidget {
  final String currentDoctorId;
  final bool isProfileFeature;

  /// When true, grid participates in a parent scroll view.
  final bool nestInParentScroll;

  const AchievementsTab({
    super.key,
    required this.isProfileFeature,
    required this.currentDoctorId,
    this.nestInParentScroll = false,
  });

  @override
  State<AchievementsTab> createState() => _AchievementsTabState();
}

class _AchievementsTabState extends State<AchievementsTab> {
  static const _accent = Color(0xFFF59E0B);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cubit = context.read<DoctorInfoViewCubit>();

      if (widget.isProfileFeature) {
        cubit.getAchievementsV2(widget.currentDoctorId);
        return;
      }

      final needsFetch = cubit.state.maybeWhen(
        orElse: () => true,
        loaded: (
          _,
          isLoadingAchievements,
          isLoadedAchievements,
          __,
          achievements,
          ___,
        ) {
          if (isLoadingAchievements) return false;
          if (isLoadedAchievements) return false;
          return achievements == null;
        },
      );

      if (needsFetch) {
        cubit.getAchievementsV1(widget.currentDoctorId);
      }
    });
  }

  void _showAchievementDetail(
    BuildContext context, {
    required bool isDark,
    required GetAchievementsModelResponse achievement,
  }) {
    final primary = HomeDashboardColors.primary(isDark);
    final titleColor = HomeDashboardColors.title(isDark);
    final muted = HomeDashboardColors.subtitle(isDark);
    final scaffold = HomeDashboardColors.scaffold(isDark);
    final name = achievement.name?.toString() ?? '';
    final description = achievement.description?.toString() ?? '';
    final score = achievement.score?.toString().trim() ?? '';
    final imageUrl = achievement.image?.toString() ?? '';

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: scaffold,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.06)
                    : const Color(0xFFE8E8EE),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.18)
                            : const Color(0xFFD1D5DB),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Container(
                      width: 112.r,
                      height: 112.r,
                      padding: EdgeInsets.all(14.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _accent.withOpacity(isDark ? 0.28 : 0.18),
                            primary.withOpacity(isDark ? 0.18 : 0.1),
                          ],
                        ),
                        border: Border.all(
                          color: _accent.withOpacity(0.35),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _accent.withOpacity(0.18),
                            blurRadius: 22,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: CustomCachedNetworkImage(
                          imageUrl: imageUrl,
                          width: 84.r,
                          height: 84.r,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                        letterSpacing: -0.2,
                      ),
                    ),
                    if (score.isNotEmpty) ...[
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: _accent.withOpacity(isDark ? 0.18 : 0.12),
                          borderRadius: BorderRadius.circular(99),
                          border: Border.all(
                            color: _accent.withOpacity(0.35),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 15.sp,
                              color: _accent,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '+$score ${context.tr(AppStrings.points)}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: titleColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (description.isNotEmpty) ...[
                      SizedBox(height: 14.h),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.sp,
                          height: 1.45,
                          fontWeight: FontWeight.w500,
                          color: muted,
                        ),
                      ),
                    ],
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => Navigator.of(sheetContext).pop(),
                        style: FilledButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          context.tr(AppStrings.ok),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final nested = widget.nestInParentScroll;
        final primary = HomeDashboardColors.primary(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final muted = HomeDashboardColors.subtitle(isDark);

        return Column(
          mainAxisSize: nested ? MainAxisSize.min : MainAxisSize.max,
          children: [
            if (widget.isProfileFeature) _SheetHeader(
              isDark: isDark,
              primary: primary,
              titleColor: titleColor,
              muted: muted,
              title: context.tr(AppStrings.achievements),
              subtitle: context.tr(AppStrings.exploreYourAccomplishments),
            ),
            BlocBuilder<DoctorInfoViewCubit, DoctorInfoViewState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => _wrapBody(
                    nested: nested,
                    child: _LoadingBody(isDark: isDark),
                  ),
                  loaded: (
                    doctorInfo,
                    isLoadingAchievements,
                    isLoadedAchievements,
                    message,
                    achievements,
                    changesCounter,
                  ) {
                    if (isLoadingAchievements || !isLoadedAchievements) {
                      return _wrapBody(
                        nested: nested,
                        child: _LoadingBody(isDark: isDark),
                      );
                    }

                    if (achievements == null || achievements.isEmpty) {
                      return _wrapBody(
                        nested: nested,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: nested ? 28.h : 24.h,
                            horizontal: 8.w,
                          ),
                          child: DashboardEmptyState(
                            isDark: isDark,
                            icon: Icons.emoji_events_outlined,
                            title: context.tr(AppStrings.noAchievementsYet),
                            subtitle: widget.isProfileFeature
                                ? context.tr(AppStrings.badgesYouEarnWillShowHere)
                                : context.tr(
                                    AppStrings.thisDoctorHasNotEarnedAchievements,
                                  ),
                            hint: widget.isProfileFeature
                                ? context.tr(
                                    AppStrings.keepContributingToUnlockFirstBadge,
                                  )
                                : context.tr(
                                    AppStrings.checkBackLaterForNewBadges,
                                  ),
                            hintIcon: Icons.workspace_premium_outlined,
                          ),
                        ),
                      );
                    }

                    Widget countHeader() {
                      if (!widget.isProfileFeature) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
                        child: Row(
                          children: [
                            Text(
                              '${achievements.length} unlocked',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: muted,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                color: _accent.withOpacity(
                                  isDark ? 0.16 : 0.12,
                                ),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.workspace_premium_rounded,
                                    size: 13.sp,
                                    color: _accent,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    context.tr(AppStrings.badges),
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700,
                                      color: titleColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    Widget badgeCard(int index) {
                      final achievement = achievements[index];
                      return FadeIn(
                        child: _AchievementCard(
                          isDark: isDark,
                          primary: primary,
                          titleColor: titleColor,
                          muted: muted,
                          achievement: achievement,
                          onTap: () => _showAchievementDetail(
                            context,
                            isDark: isDark,
                            achievement: achievement,
                          ),
                        ),
                      );
                    }

                    final gridDelegate =
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 0.78,
                    );

                    if (nested) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          countHeader(),
                          GridView.builder(
                            primary: false,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding:
                                EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 24.h),
                            gridDelegate: gridDelegate,
                            itemCount: achievements.length,
                            itemBuilder: (_, index) => badgeCard(index),
                          ),
                        ],
                      );
                    }

                    return Expanded(
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        slivers: [
                          SliverToBoxAdapter(child: countHeader()),
                          SliverPadding(
                            padding:
                                EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 24.h),
                            sliver: SliverGrid(
                              gridDelegate: gridDelegate,
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => badgeCard(index),
                                childCount: achievements.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _wrapBody({required bool nested, required Widget child}) {
    if (nested) return child;
    return Expanded(child: child);
  }
}

class _SheetHeader extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final Color titleColor;
  final Color muted;
  final String title;
  final String subtitle;

  const _SheetHeader({
    required this.isDark,
    required this.primary,
    required this.titleColor,
    required this.muted,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 10.h),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.18)
                  : const Color(0xFFD1D5DB),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFF59E0B),
                      Color.lerp(
                        const Color(0xFFF59E0B),
                        primary,
                        0.35,
                      )!,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF59E0B).withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.emoji_events_rounded,
                  color: Colors.white,
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
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: muted,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final Color titleColor;
  final Color muted;
  final GetAchievementsModelResponse achievement;
  final VoidCallback onTap;

  const _AchievementCard({
    required this.isDark,
    required this.primary,
    required this.titleColor,
    required this.muted,
    required this.achievement,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final name = achievement.name?.toString() ?? '';
    final score = achievement.score?.toString().trim() ?? '';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          decoration: HomeDashboardDecor.card(isDark).copyWith(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 8.h),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 64.r,
                        height: 64.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFF59E0B)
                                  .withOpacity(isDark ? 0.22 : 0.14),
                              primary.withOpacity(isDark ? 0.12 : 0.06),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.r),
                        child: CustomCachedNetworkImage(
                          imageUrl: achievement.image.toString(),
                          width: 56.r,
                          height: 56.r,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 22.r,
                          height: 22.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark
                                ? const Color(0xFF2A2A2E)
                                : Colors.white,
                            border: Border.all(
                              color: HomeDashboardColors.border(isDark)
                                  .withOpacity(0.8),
                            ),
                          ),
                          child: Icon(
                            Icons.info_outline_rounded,
                            size: 12.sp,
                            color: muted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                    height: 1.2,
                  ),
                ),
                if (score.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    '+$score',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFF59E0B),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingBody extends StatelessWidget {
  final bool isDark;

  const _LoadingBody({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final shimmer = isDark ? const Color(0xFF2A2A2E) : const Color(0xFFE8E8EE);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 24.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 0.78,
      ),
      itemCount: 6,
      itemBuilder: (_, __) {
        return Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: HomeDashboardColors.cardBg(isDark),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: HomeDashboardColors.border(isDark).withOpacity(0.7),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    width: 56.r,
                    height: 56.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: shimmer,
                    ),
                  ),
                ),
              ),
              Container(
                height: 10.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: shimmer,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                height: 8.h,
                width: 36.w,
                decoration: BoxDecoration(
                  color: shimmer.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
