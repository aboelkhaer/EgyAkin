import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/community/presentation/widgets/community_chrome_scope.dart';

class CommunityScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final int initialTab;
  final bool isEmbeddedInHomeTab;

  const CommunityScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.initialTab,
    this.isEmbeddedInHomeTab = false,
  });

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with TickerProviderStateMixin {
  /// Intentional scroll distance before chrome reacts (Facebook-like).
  static const double _directionThreshold = 40;
  static const double _showNearTop = 48;
  static const Duration _chromeDuration = Duration(milliseconds: 240);

  late TabController _tabController;
  late AnimationController _chromeController;
  late ScrollController feedsScrollController;
  HomeCubit? _homeCubit;

  double _scrollAcc = 0;
  double _lastFeedOffset = 0;
  double _headerBodyHeight = 0;
  final GlobalKey _headerBodyKey = GlobalKey();
  int _settledCommunityTab = 0;

  late CommunityCubit _communityCubit;

  @override
  void initState() {
    super.initState();
    _communityCubit = context.read<CommunityCubit>();
    if (widget.isEmbeddedInHomeTab) {
      try {
        _homeCubit = context.read<HomeCubit>();
        _homeCubit!.communityFeedsScrollToTopSignal
            .addListener(_onCommunityScrollToTopSignal);
      } catch (_) {}
    }
    // Only auto-load when cubit has never fetched — avoids a second
    // getAllFeeds() if create-post already refreshed before opening this tab.
    final shouldLoad = _communityCubit.state.maybeWhen(
      initial: () => true,
      orElse: () => false,
    );
    if (shouldLoad) {
      _communityCubit.getAllFeeds();
    }

    feedsScrollController = ScrollController();
    feedsScrollController.addListener(_handleFeedsScroll);

    _chromeController = AnimationController(
      vsync: this,
      duration: _chromeDuration,
      value: 1.0,
    );

    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTab,
    )..addListener(_handleTabChange);

    _settledCommunityTab = widget.initialTab;
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureHeaderBody());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.isEmbeddedInHomeTab && _homeCubit == null) {
      try {
        _homeCubit = context.read<HomeCubit>();
        _homeCubit!.communityFeedsScrollToTopSignal
            .addListener(_onCommunityScrollToTopSignal);
      } catch (_) {}
    }
  }

  void _measureHeaderBody() {
    final box =
        _headerBodyKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final h = box.size.height;
    if ((h - _headerBodyHeight).abs() < 0.5) return;
    setState(() => _headerBodyHeight = h);
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      _settledCommunityTab = _tabController.index;
    }
    // Switching community tabs restores chrome (Facebook-like).
    _showChrome();
    if (!mounted) return;
    // Avoid setState during the same frame as a nav-bar gesture rebuild.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  void _onFeedsTabTapped(int index) {
    if (index != 0) return;
    // Already on Feeds — single tap scrolls to top.
    if (_settledCommunityTab == 0) {
      _scheduleScrollFeedsToTop(onlyIfOnFeeds: true);
    }
  }

  void _onCommunityScrollToTopSignal() {
    // Defer off the nav-bar gesture to avoid rebuild/scroll panics mid-tap.
    _scheduleScrollFeedsToTop(onlyIfOnFeeds: false);
  }

  bool _scrollToTopQueued = false;

  void _scheduleScrollFeedsToTop({required bool onlyIfOnFeeds}) {
    if (_scrollToTopQueued) return;
    _scrollToTopQueued = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToTopQueued = false;
      if (!mounted) return;
      unawaited(_scrollFeedsToTop(onlyIfOnFeeds: onlyIfOnFeeds));
    });
  }

  Future<void> _scrollFeedsToTop({required bool onlyIfOnFeeds}) async {
    if (!mounted) return;
    if (onlyIfOnFeeds && _tabController.index != 0) return;

    // Switch to Feeds first when needed, then wait for the list to attach.
    if (_tabController.index != 0 && !_tabController.indexIsChanging) {
      _tabController.animateTo(0);
      await Future<void>.delayed(const Duration(milliseconds: 60));
      if (!mounted) return;
    }

    _showChrome();
    _animateFeedsToTopWithRetry();
  }

  void _animateFeedsToTopWithRetry([int attempt = 0]) {
    if (!mounted) return;
    final controller = feedsScrollController;
    if (controller.hasClients && controller.positions.length == 1) {
      animateToTopOfScreen(controller);
      return;
    }
    // ListView may not be attached yet right after a tab switch.
    if (attempt >= 8) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateFeedsToTopWithRetry(attempt + 1);
    });
  }

  void _applyScrollDelta(double delta, double pixels, double maxExtent) {
    if (pixels <= _showNearTop) {
      _scrollAcc = 0;
      _showChrome();
      return;
    }

    if (delta.abs() < 1.0) return;

    final nearBottom = maxExtent > 0 && (maxExtent - pixels) < 420;
    // Ignore load-more / layout upward jumps near the bottom.
    if (delta < 0 &&
        (_isPaginationLoading() || (nearBottom && delta.abs() < 90))) {
      return;
    }

    if (_scrollAcc != 0 && _scrollAcc.sign != delta.sign) {
      _scrollAcc = 0;
    }
    _scrollAcc += delta;

    if (_scrollAcc > _directionThreshold) {
      _scrollAcc = 0;
      _hideChrome();
    } else if (_scrollAcc < -_directionThreshold) {
      _scrollAcc = 0;
      _showChrome();
    }
  }

  void _handleFeedsScroll() {
    if (!feedsScrollController.hasClients ||
        feedsScrollController.positions.length != 1 ||
        _tabController.index != 0) {
      return;
    }

    final offset = feedsScrollController.offset;
    final delta = offset - _lastFeedOffset;
    _lastFeedOffset = offset;

    // Ignore discrete layout corrections (link-preview remount height jumps).
    // Real finger flings rarely move this much in a single listener tick.
    if (delta.abs() > 80) return;

    final maxExtent = feedsScrollController.position.maxScrollExtent;
    _applyScrollDelta(delta, offset, maxExtent);
  }

  void _showChrome() {
    if (!mounted) return;
    if (_chromeController.value == 1.0 &&
        !_chromeController.isAnimating) {
      _homeCubit?.setHideFloatingNavBar(false);
      return;
    }
    if (_chromeController.status == AnimationStatus.forward) {
      _homeCubit?.setHideFloatingNavBar(false);
      return;
    }
    _chromeController.forward();
    _homeCubit?.setHideFloatingNavBar(false);
  }

  void _hideChrome() {
    if (!mounted) return;
    if (_chromeController.value == 0.0 &&
        !_chromeController.isAnimating) {
      _homeCubit?.setHideFloatingNavBar(true);
      return;
    }
    if (_chromeController.status == AnimationStatus.reverse) {
      _homeCubit?.setHideFloatingNavBar(true);
      return;
    }
    _chromeController.reverse();
    _homeCubit?.setHideFloatingNavBar(true);
  }

  bool _isPaginationLoading() {
    if (_communityCubit.isLoadingMoreForScroll) return true;
    if (_tabController.index == 1) {
      try {
        return context.read<TrendingCubit>().isLoadingMoreForScroll;
      } catch (_) {}
    }
    return false;
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;

    // Feeds tab is driven by ScrollController — avoid double-handling.
    if (_tabController.index == 0) return false;

    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta ?? 0;
      _applyScrollDelta(
        delta,
        notification.metrics.pixels,
        notification.metrics.maxScrollExtent,
      );
    } else if (notification is ScrollEndNotification) {
      _scrollAcc = 0;
    } else if (notification is OverscrollNotification) {
      if (notification.overscroll < 0) {
        _scrollAcc = 0;
        _showChrome();
      }
    }
    return false;
  }

  @override
  void dispose() {
    _homeCubit?.communityFeedsScrollToTopSignal
        .removeListener(_onCommunityScrollToTopSignal);
    _homeCubit?.setHideFloatingNavBar(false);
    _chromeController.dispose();
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    feedsScrollController.removeListener(_handleFeedsScroll);
    feedsScrollController.dispose();
    super.dispose();
  }

  void _openSearch() {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.communitySearch,
      arguments: AppRoutesArgs.communitySearchRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        initialValueInSearch: null,
      ),
    );
  }

  void _openCreatePost() {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.createPostInCommunity,
      arguments: AppRoutesArgs.createPostInCommunityRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;
        final scaffold =
            isDark ? AppColors.darkScaffoldBG : const Color(0xFFF5F5F7);

        final horizontalInset = 14.w;
        final topInset = MediaQuery.paddingOf(context).top;

        // Opaque purple-tinted fills so feed never shows through gaps.
        final headerTop = Color.alphaBlend(
          (isDark ? const Color(0xFF6B5B95) : const Color(0xFF9B8AD4))
              .withOpacity(isDark ? 0.42 : 0.32),
          scaffold,
        );
        final headerBottom = Color.alphaBlend(
          (isDark ? const Color(0xFF6B5B95) : const Color(0xFF9B8AD4))
              .withOpacity(isDark ? 0.18 : 0.14),
          scaffold,
        );

        // Fallback until first measure — status bar + search + tabs + paddings.
        final contentInset =
            _headerBodyHeight > 0 ? _headerBodyHeight : topInset + 110.h;

        final headerBlock = KeyedSubtree(
          key: _headerBodyKey,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [headerTop, headerBottom],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28.r),
                bottomRight: Radius.circular(28.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: topInset),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalInset,
                    4.h,
                    horizontalInset,
                    8.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!widget.isEmbeddedInHomeTab)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => navigatorKey.currentState?.pop(),
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18.sp,
                              color: HomeDashboardColors.title(isDark),
                            ),
                          ),
                        ),
                      if (!widget.isEmbeddedInHomeTab) SizedBox(height: 8.h),
                      SizedBox(
                        width: double.infinity,
                        child: _CommunitySearchBar(
                          isDark: isDark,
                          onTap: _openSearch,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        child: _CommunityTabs(
                          controller: _tabController,
                          isDark: isDark,
                          primary: primary,
                          onTabTap: _onFeedsTabTapped,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
            systemStatusBarContrastEnforced: false,
          ),
          child: Scaffold(
            backgroundColor: scaffold,
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              behavior: HitTestBehavior.deferToChild,
              child: CommunityChromeScope(
              scrollTopInset: contentInset,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  ColoredBox(
                    color: scaffold,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: _onScrollNotification,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          PostsTab(
                            homeDataModel: widget.homeDataModel,
                            currentDoctorModel: widget.currentDoctorModel,
                            feedsScrollController: feedsScrollController,
                            listHeader: Padding(
                              padding: EdgeInsets.fromLTRB(
                                horizontalInset,
                                4.h,
                                horizontalInset,
                                8.h,
                              ),
                              child: _CreatePostStrip(
                                isDark: isDark,
                                primary: primary,
                                doctor: widget.currentDoctorModel,
                                onTap: _openCreatePost,
                              ),
                            ),
                          ),
                          TrendingTab(
                            homeDataModel: widget.homeDataModel,
                            currentDoctorModel: widget.currentDoctorModel,
                          ),
                          GroupsTab(
                            key: ValueKey(
                              'community_groups_${widget.currentDoctorModel.id}',
                            ),
                            homeDataModel: widget.homeDataModel,
                            currentDoctorModel: widget.currentDoctorModel,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // One opaque header block (status → search → tabs).
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedBuilder(
                      animation: _chromeController,
                      builder: (context, child) {
                        final t = Curves.easeOutCubic
                            .transform(_chromeController.value);
                        return IgnorePointer(
                          ignoring: t < 0.05,
                          child: Transform.translate(
                            offset: Offset(0, -contentInset * (1.0 - t)),
                            child: child,
                          ),
                        );
                      },
                      child: headerBlock,
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
}

class _CommunitySearchBar extends StatelessWidget {
  final bool isDark;
  final VoidCallback onTap;

  const _CommunitySearchBar({
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              size: 20.sp,
              color: HomeDashboardColors.subtitle(isDark),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                context.tr(AppStrings.searchPostsPeopleHashtags),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommunityTabs extends StatelessWidget {
  final TabController controller;
  final bool isDark;
  final Color primary;
  final ValueChanged<int>? onTabTap;

  const _CommunityTabs({
    required this.controller,
    required this.isDark,
    required this.primary,
    this.onTabTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: TabBar(
        controller: controller,
        onTap: onTabTap,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelPadding: EdgeInsets.zero,
        indicator: BoxDecoration(
          color: isDark ? primary.withOpacity(0.28) : primary.withOpacity(0.14),
          borderRadius: BorderRadius.circular(11.r),
        ),
        labelColor: isDark ? Colors.white : primary,
        unselectedLabelColor: HomeDashboardColors.subtitle(isDark),
        labelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          _tab(Icons.article_outlined, context.tr(AppStrings.feeds)),
          _tab(Icons.trending_up_rounded, context.tr(AppStrings.trending)),
          _tab(Icons.groups_rounded, context.tr(AppStrings.groups)),
        ],
      ),
    );
  }

  Tab _tab(IconData icon, String label) {
    return Tab(
      height: 38.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 15.sp),
          SizedBox(width: 5.w),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _CreatePostStrip extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final DoctorModel doctor;
  final VoidCallback onTap;

  const _CreatePostStrip({
    required this.isDark,
    required this.primary,
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Prefer HomeCubit's live doctor so the strip shows the real photo even
    // when the route arg is a stale / incomplete DoctorModel.
    final avatarDoctor = resolveDoctorForAvatar(doctor) ?? doctor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DoctorCircleAvatar(
              doctor: avatarDoctor,
              primary: primary,
              size: 32.r,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                context.tr(AppStrings.shareUpdateWithCommunity),
                maxLines: 2,
                overflow: TextOverflow.visible,
                softWrap: true,
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1.25,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: primary.withOpacity(0.7)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit_outlined, size: 14.sp, color: primary),
                  SizedBox(width: 4.w),
                  Text(
                    context.tr(AppStrings.post),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
