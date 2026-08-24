import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/score_history/presentation/cubit/score_history_state.dart';
import '../../../../exports.dart';

class ScoreHistoryScreen extends StatefulWidget {
  final String doctorId;
  const ScoreHistoryScreen({super.key, required this.doctorId});

  @override
  State<ScoreHistoryScreen> createState() => _ScoreHistoryScreenState();
}

class _ScoreHistoryScreenState extends State<ScoreHistoryScreen> {
  ScoreHistoryCubit? _cubit;

  @override
  void initState() {
    super.initState();
    context.read<ScoreHistoryCubit>().getScoreHistory(widget.doctorId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<ScoreHistoryCubit>();
      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
        _cubit!.scrollController!.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController!.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    final cubit = context.read<ScoreHistoryCubit>();
    if (cubit.isLastPage) return;

    final maxScroll = cubit.scrollController!.position.maxScrollExtent;
    final currentScroll = cubit.scrollController!.position.pixels;
    const threshold = 200.0;
    if (!cubit.isLoadingMoreForScroll &&
        maxScroll - currentScroll <= threshold) {
      cubit.isLoadingMoreForScroll = true;
      cubit.loadMorePatients(widget.doctorId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ScoreHistoryCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final titleColor = HomeDashboardColors.title(isDark);
        final muted = HomeDashboardColors.subtitle(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);

        return ColoredBox(
          color: scaffold,
          child: Column(
            children: [
              Padding(
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
                                HomeDashboardColors.score,
                                Color.lerp(
                                  HomeDashboardColors.score,
                                  primary,
                                  0.35,
                                )!,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: HomeDashboardColors.score
                                    .withOpacity(0.35),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.stars_rounded,
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
                                context.tr(AppStrings.scoreHistory),
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w800,
                                  color: titleColor,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                context.tr(
                                  AppStrings.trackPointsEarnedFromYourActivity,
                                ),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<ScoreHistoryCubit, ScoreHistoryState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => Center(
                        child: CircularProgressIndicator(color: primary),
                      ),
                      loaded: (scoreHistory, isSeeMore) {
                        final entries = scoreHistory.data ?? [];
                        if (entries.isEmpty) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              await cubit.getScoreHistory(widget.doctorId);
                            },
                            color: primary,
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.4,
                                  child: DashboardEmptyState(
                                    isDark: isDark,
                                    icon: Icons.workspace_premium_outlined,
                                    title: context.tr(
                                      AppStrings.noScoreActivityYet,
                                    ),
                                    subtitle: context.tr(
                                      AppStrings.pointsEarnedWillAppearInHistory,
                                    ),
                                    hint: context.tr(
                                      AppStrings.completeTasksToStartEarningPoints,
                                    ),
                                    hintIcon: Icons.star_outline_rounded,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.separated(
                          controller: cubit.scrollController,
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 20.h),
                          itemCount: entries.length + (isSeeMore ? 1 : 0),
                          separatorBuilder: (_, __) => SizedBox(height: 8.h),
                          itemBuilder: (context, index) {
                            if (index >= entries.length) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: Center(
                                  child: SizedBox(
                                    width: 22.r,
                                    height: 22.r,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: primary,
                                    ),
                                  ),
                                ),
                              );
                            }

                            final scoreModel = entries[index];
                            final points =
                                int.tryParse(scoreModel.score ?? '0') ?? 0;
                            final pointsLabel = points > 1
                                ? context.tr(AppStrings.points)
                                : (context.currentLocale?.languageCode == 'ar'
                                    ? context.tr(AppStrings.points)
                                    : context.tr(AppStrings.point));

                            return Container(
                              padding: EdgeInsets.fromLTRB(
                                12.w,
                                12.h,
                                12.w,
                                12.h,
                              ),
                              decoration: HomeDashboardDecor.card(isDark)
                                  .copyWith(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 42.r,
                                    height: 42.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: HomeDashboardColors.score
                                          .withOpacity(isDark ? 0.2 : 0.12),
                                    ),
                                    child: Icon(
                                      Icons.bolt_rounded,
                                      color: HomeDashboardColors.score,
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context.tr(
                                            scoreModel.action?.toString() ?? '',
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700,
                                            color: titleColor,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          TimeAgoService.instance
                                              .formatTimeAgoFromString(
                                            scoreModel.updateAt.toString(),
                                            context,
                                          ),
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            color: muted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: HomeDashboardColors.score
                                          .withOpacity(isDark ? 0.18 : 0.12),
                                      borderRadius: BorderRadius.circular(99),
                                      border: Border.all(
                                        color: HomeDashboardColors.score
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                    child: Text(
                                      '+$points $pointsLabel',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w800,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF047857),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
