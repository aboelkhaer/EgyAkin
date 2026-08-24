import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import '../../../../app/services/theme_bloc.dart';

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
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController feedsScrollController;

  bool _isFabVisible = false;

  late CommunityCubit _communityCubit;

  @override
  void initState() {
    super.initState();
    _communityCubit = context.read<CommunityCubit>();
    _communityCubit.getAllFeeds();

    feedsScrollController = ScrollController();
    feedsScrollController.addListener(_handleFeedsScroll);

    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTab,
    )..addListener(_handleTabChange);

    _isFabVisible = false;
  }

  void _handleTabChange() {
    if (_tabController.index != 0 && _isFabVisible) {
      setState(() {
        _isFabVisible = false;
      });
    }
    if (mounted) setState(() {});
  }

  void _handleFeedsScroll() {
    if (!feedsScrollController.hasClients || _tabController.index != 0) {
      if (_isFabVisible) {
        setState(() {
          _isFabVisible = false;
        });
      }
      return;
    }

    final offset = feedsScrollController.offset;
    final shouldShow = offset > 300;

    if (_isFabVisible != shouldShow) {
      setState(() {
        _isFabVisible = shouldShow;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    feedsScrollController.removeListener(_handleFeedsScroll);
    feedsScrollController.dispose();
    super.dispose();
  }

  String _initials() {
    final first = widget.currentDoctorModel.firstName;
    final last = widget.currentDoctorModel.lastName;
    final a = (first != null && first.isNotEmpty) ? first[0] : '';
    final b = (last != null && last.isNotEmpty) ? last[0] : '';
    final value = ('$a$b').toUpperCase();
    return value.isEmpty ? 'DR' : value;
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

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
            systemStatusBarContrastEnforced: false,
          ),
          child: Scaffold(
            // Must match body — rounded header corners cut out to this color.
            // Using the purple header color here caused purple "triangle" wedges.
            backgroundColor: scaffold,
            body: Column(
              children: [
                // Soft purple wash over scaffold (lower opacity), rounded bottom
                Container(
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDark
                          ? [
                              const Color(0xFF6B5B95).withOpacity(0.38),
                              const Color(0xFF6B5B95).withOpacity(0.18),
                              const Color(0xFF6B5B95).withOpacity(0.0),
                            ]
                          : [
                              const Color(0xFF9B8AD4).withOpacity(0.28),
                              const Color(0xFF9B8AD4).withOpacity(0.12),
                              const Color(0xFF9B8AD4).withOpacity(0.0),
                            ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28.r),
                      bottomRight: Radius.circular(28.r),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalInset,
                        4.h,
                        horizontalInset,
                        8.h,
                      ),
                      child: Column(
                        children: [
                          if (!widget.isEmbeddedInHomeTab)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () =>
                                    navigatorKey.currentState?.pop(),
                                icon: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 18.sp,
                                  color: HomeDashboardColors.title(isDark),
                                ),
                              ),
                            ),
                          if (!widget.isEmbeddedInHomeTab)
                            SizedBox(height: 8.h),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ColoredBox(
                    color: scaffold,
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
                              initials: _initials(),
                              imageUrl: widget.currentDoctorModel.image,
                              onTap: _openCreatePost,
                            ),
                          ),
                        ),
                        TrendingTab(
                          homeDataModel: widget.homeDataModel,
                          currentDoctorModel: widget.currentDoctorModel,
                        ),
                        GroupsTab(
                          homeDataModel: widget.homeDataModel,
                          currentDoctorModel: widget.currentDoctorModel,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: _isFabVisible
                ? FloatingActionButton(
                    onPressed: () {
                      animateToTopOfScreen(feedsScrollController);
                    },
                    backgroundColor: primary.withOpacity(0.9),
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                      size: 26,
                    ),
                  )
                : null,
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

  const _CommunityTabs({
    required this.controller,
    required this.isDark,
    required this.primary,
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
  final String initials;
  final String? imageUrl;
  final VoidCallback onTap;

  const _CreatePostStrip({
    required this.isDark,
    required this.primary,
    required this.initials,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
            CircleAvatar(
              radius: 16.r,
              backgroundColor: primary.withOpacity(0.15),
              child: imageUrl == null || imageUrl!.isEmpty
                  ? Text(
                      initials,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w800,
                        color: primary,
                      ),
                    )
                  : ClipOval(
                      child: CustomCachedNetworkImage(
                        imageUrl: imageUrl!,
                        height: 32.h,
                        width: 32.w,
                      ),
                    ),
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
