import 'package:egy_akin/features/community/data/models/trending_fake_data.dart';
import 'package:egy_akin/features/community/presentation/cubit/trending_cubit/trending_state.dart';
import 'package:egy_akin/features/community/presentation/widgets/community_chrome_scope.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../../exports.dart';

class TrendingTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const TrendingTab({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<TrendingTab> createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab>
    with AutomaticKeepAliveClientMixin {
  late final TrendingCubit _cubit;
  late final ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<TrendingCubit>();
    _scrollController = ScrollController()..addListener(_onScroll);

    if (_cubit.callTrendsTabTimes == 0) {
      _cubit.callTrendsTabTimes = 1;
      _cubit.getTrendingPostsInCommunity();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_cubit.isLastPage || _cubit.isLoadingMoreForScroll) return;

    final position = _scrollController.position;
    if (!position.hasContentDimensions) return;
    if (position.pixels <= 0 || position.maxScrollExtent <= 0) return;

    const threshold = 200.0;
    if (position.maxScrollExtent - position.pixels <= threshold) {
      _cubit.loadMoreTrends();
    }
  }

  Future<void> _onRefresh() async {
    await _cubit.getTrendingPostsInCommunity();
  }

  void _openSearch(String query) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.communitySearch,
      arguments: AppRoutesArgs.communitySearchRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        initialValueInSearch: query,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final chromeInset = CommunityChromeScope.of(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);

        return ColoredBox(
          color: HomeDashboardColors.scaffold(isDark),
          child: BlocConsumer<TrendingCubit, TrendingState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  if (message.isNotEmpty) {
                    customSnackBar(context: context, message: message);
                  }
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20, chromeInset + 20, 20, 20),
                  child: const LoadingForGroupRow(
                    count: 12,
                    isTrends: true,
                  ),
                ),
                error: (_) => RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: primary,
                  edgeOffset: chromeInset,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.fromLTRB(
                      24.w,
                      chromeInset + 40.h,
                      24.w,
                      40.h,
                    ),
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.55,
                        child: _TrendingEmptyState(
                          isDark: isDark,
                          isError: true,
                        ),
                      ),
                    ],
                  ),
                ),
                loaded: (_, __, response, isSeeMore) {
                  final trends = response.data ?? const <TrendModel>[];
                  if (trends.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: primary,
                      edgeOffset: chromeInset,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: EdgeInsets.fromLTRB(
                          24.w,
                          chromeInset + 40.h,
                          24.w,
                          40.h,
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.55,
                            child: _TrendingEmptyState(
                              isDark: isDark,
                              isError: false,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final topics = TrendingTopicUi.fromTrends(trends);
                  final featured = topics.first;
                  final rest = topics.skip(1).toList();

                  final cardBg =
                      isDark ? const Color(0xFF161B22) : Colors.white;
                  final border = isDark
                      ? Colors.white.withOpacity(0.06)
                      : const Color(0xFFE5E7EB);
                  final muted =
                      isDark ? Colors.white54 : const Color(0xFF6B7280);
                  final title =
                      isDark ? Colors.white : const Color(0xFF111827);

                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: primary,
                    edgeOffset: chromeInset,
                    child: ListView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: EdgeInsets.fromLTRB(
                        14.w,
                        chromeInset + 6.h,
                        14.w,
                        100.h,
                      ),
                      children: [
                        _FeaturedRow(
                          topic: featured,
                          isDark: isDark,
                          onTap: () => _openSearch(featured.searchQuery),
                        ),
                        if (rest.isNotEmpty) ...[
                          SizedBox(height: 10.h),
                          Container(
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(18.r),
                              border: Border.all(color: border),
                            ),
                            child: Column(
                              children: [
                                for (var i = 0; i < rest.length; i++) ...[
                                  if (i > 0)
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      indent: 56.w,
                                      color: border,
                                    ),
                                  _RankedListRow(
                                    topic: rest[i],
                                    isDark: isDark,
                                    titleColor: title,
                                    mutedColor: muted,
                                    onTap: () =>
                                        _openSearch(rest[i].searchQuery),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                        if (isSeeMore) ...[
                          SizedBox(height: 16.h),
                          Center(
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _TrendingEmptyState extends StatelessWidget {
  final bool isDark;
  final bool isError;

  const _TrendingEmptyState({
    required this.isDark,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final title = HomeDashboardColors.title(isDark);
    final subtitle = HomeDashboardColors.subtitle(isDark);
    final cardBg = isDark ? const Color(0xFF161B22) : Colors.white;
    final border = isDark
        ? Colors.white.withOpacity(0.07)
        : const Color(0xFFE5E7EB);
    final accent = isError ? const Color(0xFFEF4444) : primary;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120.r,
            height: 120.r,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120.r,
                  height: 120.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        accent.withOpacity(isDark ? 0.22 : 0.14),
                        accent.withOpacity(0),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 84.r,
                  height: 84.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cardBg,
                    border: Border.all(color: border),
                    boxShadow: [
                      BoxShadow(
                        color: accent.withOpacity(isDark ? 0.22 : 0.12),
                        blurRadius: 28,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    isError
                        ? Icons.wifi_off_rounded
                        : Icons.local_fire_department_rounded,
                    size: 36.sp,
                    color: accent,
                  ),
                ),
                if (!isError)
                  Positioned(
                    right: 10.r,
                    top: 14.r,
                    child: Container(
                      width: 32.r,
                      height: 32.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            primary,
                            Color.lerp(primary, Colors.white, 0.2)!,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.trending_up_rounded,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 22.h),
          Text(
            context.tr(
              isError
                  ? AppStrings.couldNotLoadTrends
                  : AppStrings.noTrendsYet,
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              color: title,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.tr(
              isError
                  ? AppStrings.couldNotLoadTrendsSubtitle
                  : AppStrings.noTrendsYetSubtitle,
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              height: 1.45,
              color: subtitle,
            ),
          ),
          if (!isError) ...[
            SizedBox(height: 22.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0) SizedBox(width: 8.w),
                  _GhostTrendChip(
                    isDark: isDark,
                    rank: i + 1,
                    widthFactor: 1 - (i * 0.12),
                  ),
                ],
              ],
            ),
          ],
          SizedBox(height: 22.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
            decoration: BoxDecoration(
              color: accent.withOpacity(isDark ? 0.14 : 0.08),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: accent.withOpacity(0.22)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.swipe_down_alt_rounded,
                  size: 16.sp,
                  color: accent,
                ),
                SizedBox(width: 8.w),
                Text(
                  context.tr(AppStrings.pullDownToRefreshTrends),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: accent,
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

class _GhostTrendChip extends StatelessWidget {
  final bool isDark;
  final int rank;
  final double widthFactor;

  const _GhostTrendChip({
    required this.isDark,
    required this.rank,
    required this.widthFactor,
  });

  @override
  Widget build(BuildContext context) {
    final primary = HomeDashboardColors.primary(isDark);
    final base = isDark ? Colors.white : Colors.black;

    return Opacity(
      opacity: 0.55 - (rank - 1) * 0.1,
      child: Container(
        width: (72.w * widthFactor).clamp(48.0, 80.0),
        height: 28.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: primary.withOpacity(isDark ? 0.12 : 0.08),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: primary.withOpacity(isDark ? 0.18 : 0.12),
          ),
        ),
        child: Row(
          children: [
            Text(
              '#$rank',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w800,
                color: primary.withOpacity(0.85),
              ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: base.withOpacity(isDark ? 0.12 : 0.08),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedRow extends StatelessWidget {
  final TrendingTopicUi topic;
  final bool isDark;
  final VoidCallback onTap;

  const _FeaturedRow({
    required this.topic,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = isDark ? topic.darkColors : topic.lightColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Ink(
          height: 88.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: colors,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.last.withOpacity(isDark ? 0.3 : 0.16),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Text(
                    '${topic.rank}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.local_fire_department_rounded,
                            size: 12.sp,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${context.tr(AppStrings.topTrend)} · ${topic.category}',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        topic.tag,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${topic.postsCount} ${context.tr(AppStrings.postsCount)}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    if (topic.growthPercent != null) ...[
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.16),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '+${topic.growthPercent}%',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RankedListRow extends StatelessWidget {
  final TrendingTopicUi topic;
  final bool isDark;
  final Color titleColor;
  final Color mutedColor;
  final VoidCallback onTap;

  const _RankedListRow({
    required this.topic,
    required this.isDark,
    required this.titleColor,
    required this.mutedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final growth = topic.growthPercent;
    final growthColor = topic.isRising
        ? const Color(0xFF22C55E)
        : const Color(0xFFEF4444);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            children: [
              SizedBox(
                width: 36.w,
                child: Text(
                  '${topic.rank}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                    color: topic.accent,
                    height: 1,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 34.r,
                height: 34.r,
                decoration: BoxDecoration(
                  color: topic.accent.withOpacity(isDark ? 0.16 : 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  topic.icon,
                  size: 16.sp,
                  color: topic.accent,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.tag,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '${topic.postsCount} ${context.tr(AppStrings.postsCount)} · ${topic.category}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: mutedColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (growth != null) ...[
                SizedBox(width: 8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: growthColor.withOpacity(isDark ? 0.16 : 0.10),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        topic.isRising
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        size: 11.sp,
                        color: growthColor,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        topic.isRising
                            ? '$growth%'
                            : '${growth.abs()}%',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w800,
                          color: growthColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
