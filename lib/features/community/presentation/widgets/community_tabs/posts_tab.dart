import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/community/presentation/cubit/community_state.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import '../../../../../app/services/theme_bloc.dart';

class PostsTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final ScrollController feedsScrollController;
  final Widget? listHeader;

  const PostsTab({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.feedsScrollController,
    this.listHeader,
  });

  @override
  State<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab> {
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _setupScrollListener();
    // Reset pagination state when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CommunityCubit.get(context).resetPaginationState();
    });
  }

  @override
  void didUpdateWidget(PostsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.feedsScrollController != widget.feedsScrollController) {
      _setupScrollListener();
    }
  }

  void _setupScrollListener() {
    // Remove any existing listener first to prevent duplicates
    widget.feedsScrollController.removeListener(_onScroll);
    // Add the new listener
    widget.feedsScrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Check if scroll controller is still valid
    if (!widget.feedsScrollController.hasClients) return;

    final cubit = CommunityCubit.get(context);

    // Don't load more if already loading, at last page, or not near bottom
    if (!_isLoadingMore &&
        !cubit.isLoadingMoreForScroll &&
        !cubit.isLastPage &&
        widget.feedsScrollController.position.pixels >=
            widget.feedsScrollController.position.maxScrollExtent - 300) {
      debugPrint('Triggering loadMoreFeeds');
      _isLoadingMore = true;
      cubit.isLoadingMoreForScroll = true;
      cubit.loadMoreFeeds();
      // Reset loading flag after a delay to prevent multiple calls
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          setState(() {
            _isLoadingMore = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    widget.feedsScrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommunityCubit cubit = CommunityCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Container(
          decoration: BoxDecoration(
            color: isDarkMode
                ? AppColors.darkScaffoldBG
                : const Color(0xFFF5F5F7),
          ),
          child: BlocBuilder<CommunityCubit, CommunityState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const ShimmerLoadingFeeds(
                    numberOfShimmer: 5,
                  );
                },
                loaded: (
                  feedsResponse,
                  isDeletePostLoading,
                  isDeletePostLoaded,
                  message,
                  isSeeMore,
                  changeCounter,
                ) {
                  final headerCount = widget.listHeader != null ? 1 : 0;
                  final feeds = feedsResponse.data!.data!;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await cubit.getAllFeeds();
                          },
                          child: feeds.isEmpty
                              ? SingleChildScrollView(
                                  controller: widget.feedsScrollController,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      if (widget.listHeader != null)
                                        widget.listHeader!,
                                      SizedBox(height: 80.h),
                                      DashboardEmptyState(
                                        isDark: isDarkMode,
                                        icon: Icons.article_outlined,
                                        title: context.tr(AppStrings.noPostsYet),
                                        subtitle: context.tr(
                                          AppStrings.communityPostsWillShowHere,
                                        ),
                                        hint: context.tr(
                                          AppStrings.pullDownToRefreshFeed,
                                        ),
                                        hintIcon: Icons.refresh_rounded,
                                      ),
                                      SizedBox(height: 80.h),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: headerCount +
                                      feeds.length +
                                      (isSeeMore ? 1 : 0),
                                  controller: widget.feedsScrollController,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 60.h),
                                  itemBuilder: (context, index) {
                                    if (headerCount == 1 && index == 0) {
                                      return widget.listHeader!;
                                    }

                                    final feedIndex = index - headerCount;

                                    if (feedIndex == feeds.length) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.h),
                                        child: const Center(
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    final feed = feeds[feedIndex];
                                    return PostCard(
                                      feed: feed,
                                      homeDataModel: widget.homeDataModel,
                                      currentDoctorModel:
                                          widget.currentDoctorModel,
                                      showPostFrom:
                                          ShowPostFromEnum.feedsTab.name,
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
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
