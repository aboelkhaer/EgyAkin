import 'dart:developer';

import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/community/presentation/cubit/trending_cubit/trending_cubit.dart';

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
  late ScrollController _scrollController;
  late TabController _tabController;
  late ScrollController feedsScrollController;

  bool _isFabVisible = false;
  bool _showTabs = true; // Track visibility of the TabBar

  late CommunityCubit _communityCubit; // Store a reference to the cubit

  @override
  void initState() {
    super.initState();
    _communityCubit = context.read<CommunityCubit>(); // Initialize the cubit
    _communityCubit.getAllFeeds(); // Fetch feeds

    // Initialize ScrollController
    _scrollController = ScrollController();

    // Initialize feedsScrollController
    feedsScrollController = ScrollController();

    // Initialize TabController
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTab,
    );

    // Add listener to ScrollController
    _scrollController.addListener(_scrollListener);

    // Add listener to feedsScrollController
    feedsScrollController.addListener(_onScroll);

    // Reset FloatingActionButton visibility
    _isFabVisible = false;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener); // Remove the listener
    _scrollController.dispose(); // Dispose of the main scroll controller
    _tabController.dispose(); // Dispose of the tab controller

    // Dispose of the feedsScrollController
    feedsScrollController.removeListener(_onScroll); // Remove the listener
    feedsScrollController.dispose(); // Dispose of the feedsScrollController

    super.dispose();
  }

  void _scrollListener() {
    // Show or hide the TabBar based on scroll offset
    if (_scrollController.offset > 100 && _showTabs) {
      setState(() {
        _showTabs = false; // Hide the TabBar
      });
    } else if (_scrollController.offset <= 100 && !_showTabs) {
      setState(() {
        _showTabs = true; // Show the TabBar
      });
    }

    // Show or hide the FloatingActionButton
    if (_scrollController.offset > 100 && _tabController.index == 0) {
      setState(() {
        _isFabVisible = true;
      });
    } else {
      setState(() {
        _isFabVisible = false;
      });
    }
  }

  void _onScroll() {
    if (!feedsScrollController.hasClients) {
      return;
    }

    final scrollController = feedsScrollController;
    if (_communityCubit.isLastPage) {
      return; // Stop if all data has been loaded
    }

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    const threshold = 200.0;

    if (!_communityCubit.isLoadingMoreForScroll &&
        maxScroll - currentScroll <= threshold) {
      _communityCubit.isLoadingMoreForScroll = true;
      _communityCubit.loadMoreFeeds(); // Load more feeds
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with Search and Add Button
          SizedBox(height: 40.h),
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
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollNotification) {
                // Handle scroll notifications here
                if (scrollNotification is ScrollUpdateNotification) {
                  // Show FAB only in the Feeds tab (index 0) when scrolled down
                  if (_tabController.index == 0) {
                    if (scrollNotification.metrics.pixels > 100) {
                      setState(() {
                        _isFabVisible = true; // Show FAB when scrolled down
                      });
                    } else {
                      setState(() {
                        _isFabVisible = false; // Hide FAB when at the top
                      });
                    }
                  } else {
                    // Hide FAB in other tabs
                    setState(() {
                      _isFabVisible = false;
                    });
                  }
                }
                return false; // Return false to allow the notification to continue propagating
              },
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
