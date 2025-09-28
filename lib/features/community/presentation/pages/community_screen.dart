import 'package:egy_akin/exports.dart';
import '../../../../app/services/theme_bloc.dart';

class CommunityScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final int initialTab;

  const CommunityScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.initialTab,
  });

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController feedsScrollController;

  bool _isFabVisible = false;

  late CommunityCubit _communityCubit; // Store a reference to the cubit

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
    )..addListener(_handleTabChange); // Add tab change listener

    _isFabVisible = false;
  }

  // Add this new method to handle tab changes
  void _handleTabChange() {
    if (_tabController.index != 0 && _isFabVisible) {
      setState(() {
        _isFabVisible = false;
      });
    }
  }

  void _handleFeedsScroll() {
    // Only handle scroll events when on the Feeds tab (index 0)
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

    // Remove pagination logic from here - let PostsTab handle it
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange); // Remove tab listener
    _tabController.dispose();
    feedsScrollController.removeListener(_handleFeedsScroll);
    feedsScrollController.dispose();
    super.dispose();
  }

  // void _onScroll() {
  //   if (!feedsScrollController.hasClients) {
  //     return;
  //   }

  //   final scrollController = feedsScrollController;
  //   if (_communityCubit.isLastPage) {
  //     return; // Stop if all data has been loaded
  //   }

  //   final maxScroll = scrollController.position.maxScrollExtent;
  //   final currentScroll = scrollController.position.pixels;
  //   const threshold = 200.0;

  //   if (!_communityCubit.isLoadingMoreForScroll &&
  //       maxScroll - currentScroll <= threshold) {
  //     _communityCubit.isLoadingMoreForScroll = true;
  //     _communityCubit.loadMoreFeeds(); // Load more feeds
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          backgroundColor: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: isDarkMode
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
            ),
          ),
          body: Column(
            children: [
              // Header with Search and Add Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        navigatorKey.currentState?.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        title: context.tr(AppStrings.searchInCommunity),
                        textAlign: TextAlign.center,
                        onTextClick: () {
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.communitySearch,
                            arguments: AppRoutesArgs.communitySearchRouteArgs(
                              currentDoctorModel: widget.currentDoctorModel,
                              homeDataModel: widget.homeDataModel,
                              initialValueInSearch: null,
                            ),
                          );
                        },
                        readOnly: true,
                        isCommunitySearch: true,
                        isSearchIconInCenter: true,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        navigatorKey.currentState?.pushNamed(
                          AppRoutes.createPostInCommunity,
                          arguments:
                              AppRoutesArgs.createPostInCommunityRouteArgs(
                            currentDoctorModel: widget.currentDoctorModel,
                            homeDataModel: widget.homeDataModel,
                          ),
                        );
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Hero(
                            tag: 'add_icon',
                            child: Image.asset(
                              'assets/images/app_icon.png',
                              width: 30,
                              height: 30,
                              color: isDarkMode ? AppColors.darkTitle : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            context.tr(AppStrings.addPost),
                            style: TextStyle(
                              fontSize: 10,
                              color: isDarkMode
                                  ? AppColors.darkDescription
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // TabBar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: TabBar(
                  controller: _tabController, // Link the TabController
                  padding: const EdgeInsets.only(bottom: 10),
                  labelColor:
                      isDarkMode ? AppColors.darkPrimary : AppColors.primary,
                  isScrollable: false,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                  unselectedLabelColor: isDarkMode
                      ? AppColors.darkDescription
                      : Colors.grey.shade500,
                  dividerColor: Colors.transparent,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  indicator: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.darkPrimary.withOpacity(0.1)
                        : AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.article_outlined,
                            size: 16,
                            color: isDarkMode
                                ? AppColors.darkTitle
                                : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            context.tr(AppStrings.feeds),
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode
                                  ? AppColors.darkTitle
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.trending_up,
                            size: 16,
                            color: isDarkMode
                                ? AppColors.darkTitle
                                : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            context.tr(AppStrings.trending),
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode
                                  ? AppColors.darkTitle
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.group,
                            size: 16,
                            color: isDarkMode
                                ? AppColors.darkTitle
                                : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            context.tr(AppStrings.groups),
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode
                                  ? AppColors.darkTitle
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // TabBarView with Scrollable Content
              Expanded(
                child: TabBarView(
                  controller: _tabController, // Link the TabController

                  children: [
                    PostsTab(
                      homeDataModel: widget.homeDataModel,
                      currentDoctorModel: widget.currentDoctorModel,
                      feedsScrollController:
                          feedsScrollController, // Pass the controller
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
            ],
          ),
          floatingActionButton: _isFabVisible
              ? FloatingActionButton(
                  onPressed: () {
                    animateToTopOfScreen(feedsScrollController);
                  },
                  backgroundColor: isDarkMode
                      ? AppColors.darkPrimary.withOpacity(0.2)
                      : AppColors.primary.withOpacity(0.2),
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              : null,
        );
      },
    );
  }
}
