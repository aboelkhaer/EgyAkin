import 'package:egy_akin/exports.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                    title: 'Search',
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
                IconButton(
                  onPressed: () {
                    navigatorKey.currentState?.pushNamed(
                      AppRoutes.createPostInCommunity,
                      arguments: AppRoutesArgs.createPostInCommunityRouteArgs(
                        currentDoctorModel: widget.currentDoctorModel,
                        homeDataModel: widget.homeDataModel,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 30,
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
              labelColor: AppColors.primary,
              isScrollable: false,
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              unselectedLabelColor: Colors.grey.shade500,
              dividerColor: Colors.transparent,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              indicator: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              tabs: const [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.article_outlined, size: 16),
                      SizedBox(width: 5),
                      Text(
                        'Feeds',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.trending_up, size: 16),
                      SizedBox(width: 5),
                      Text(
                        'Trending',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.group, size: 16),
                      SizedBox(width: 5),
                      Text(
                        'Groups',
                        style: TextStyle(
                          fontSize: 14,
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
              backgroundColor: AppColors.primary.withOpacity(0.2),
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
                size: 30,
              ),
            )
          : null,
    );
  }
}
