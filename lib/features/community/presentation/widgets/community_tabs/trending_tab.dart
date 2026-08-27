import 'package:egy_akin/features/community/data/models/trending_fake_data.dart';
import 'package:egy_akin/features/community/presentation/cubit/trending_cubit/trending_state.dart';
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
                orElse: () => const SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: LoadingForGroupRow(
                      count: 12,
                      isTrends: true,
                    ),
                  ),
                ),
                error: (_) => RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: primary,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    children: [
                      SizedBox(height: 120.h),
                      Center(
                        child: Image.asset(
                          AppImages.notFound,
                          width: 150.w,
                          height: 150.h,
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
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        children: [
                          SizedBox(height: 120.h),
                          Center(
                            child: Image.asset(
                              AppImages.notFound,
                              width: 150.w,
                              height: 150.h,
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
                    child: ListView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 100.h),
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
