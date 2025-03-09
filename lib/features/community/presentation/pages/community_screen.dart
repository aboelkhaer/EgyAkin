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
  late ScrollController _scrollController;
  late TabController _tabController;
  bool _isFabVisible = false;

  late CommunityCubit _communityCubit; // Store a reference to the cubit
  @override
  void initState() {
    super.initState();
    _communityCubit = context.read<CommunityCubit>(); // Initialize the cubit
    _communityCubit.getAllFeeds(); // Use the stored cubit

    _scrollController = ScrollController();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTab,
    );

    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && _tabController.index == 0) {
        setState(() {
          _isFabVisible = true;
        });
      } else {
        setState(() {
          _isFabVisible = false;
        });
      }
    });

    // Reinitialize the feedsScrollController if it was disposed
    if (_communityCubit.feedsScrollController == null ||
        !_communityCubit.feedsScrollController!.hasClients) {
      _communityCubit.feedsScrollController = ScrollController();
    }

    _communityCubit.feedsScrollController!.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();

    // Dispose of the feedsScrollController in the cubit
    _communityCubit.disposeScrollController();

    super.dispose();
  }

  void _onScroll() {
    if (_communityCubit.feedsScrollController == null ||
        !_communityCubit.feedsScrollController!.hasClients) {
      return;
    }

    final scrollController = _communityCubit.feedsScrollController!;
    if (_communityCubit.isLastPage) {
      return;
    } else {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      const threshold = 200.0;

      if ((_communityCubit.isLoadingMoreForScroll == false) &&
          maxScroll - currentScroll <= threshold) {
        _communityCubit.isLoadingMoreForScroll = true;
        _communityCubit.loadMoreFeeds();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // SliverAppBar for the status bar (fixed at the top)
              const SliverAppBar(
                toolbarHeight: 0, // Remove toolbar to keep only the status bar
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true, // This keeps the status bar fixed
                automaticallyImplyLeading: false,
              ),

              // SliverPersistentHeader for the Search and Row (this will scroll)
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10.w),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  navigatorKey.currentState?.pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    title: 'Search',
                                    textInputType: TextInputType.text,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 3),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () {
                                    navigatorKey.currentState?.pushNamed(
                                      AppRoutes.createPostInCommunity,
                                      arguments: AppRoutesArgs
                                          .createPostInCommunityRouteArgs(
                                        currentDoctorModel:
                                            widget.currentDoctorModel,
                                        homeDataModel: widget.homeDataModel,
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                ),
                pinned: true, // This allows it to scroll
              ),

              // TabBar with margin
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: TabBar(
                    controller: _tabController, // Link the TabController
                    labelColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController, // Link the TabController
            children: [
              PostsTab(
                homeDataModel: widget.homeDataModel,
                currentDoctorModel: widget.currentDoctorModel,
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
        floatingActionButton: _isFabVisible
            ? FloatingActionButton(
                onPressed: () {
                  animateToTopOfScreen(_scrollController);
                },
                backgroundColor: AppColors.primary.withOpacity(0.2),
                child: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                  size: 30,
                ),
              )
            : null,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => 80.0;

  @override
  double get maxExtent => 100.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, // Set the background color here
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
