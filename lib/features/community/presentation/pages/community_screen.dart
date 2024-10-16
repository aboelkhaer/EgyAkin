import 'package:egy_akin/exports.dart';

class CommunityScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const CommunityScreen(
      {super.key,
      required this.currentDoctorModel,
      required this.homeDataModel});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  bool _isFabVisible = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<CommunityCubit>().getAllFeeds();
    _scrollController = ScrollController();
    _tabController =
        TabController(length: 3, vsync: this); // Initialize the TabController

    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && _tabController.index == 0) {
        // Check if in Posts tab (index 0)
        setState(() {
          _isFabVisible = true;
        });
      } else {
        setState(() {
          _isFabVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommunityCubit cubit = CommunityCubit.get(context);

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
                                    title: 'Search in feeds...',
                                    textInputType: TextInputType.text,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {},
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Create\nPost',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          SizedBox(width: 15.w),
                        ],
                      ),
                    ],
                  ),
                ),
                pinned: false, // This allows it to scroll
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
                    indicator: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    tabs: const [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.article_outlined, size: 18),
                            SizedBox(width: 5),
                            Text('Feeds'),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.newspaper_outlined, size: 18),
                            SizedBox(width: 5),
                            Text('News'),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.trending_up, size: 18),
                            SizedBox(width: 5),
                            Text('Trending'),
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
              const NewsTab(),
              const TrendingTab(),
            ],
          ),
        ),
        floatingActionButton: _isFabVisible
            ? FloatingActionButton(
                onPressed: () {
                  // Action for creating a post
                },
                backgroundColor: AppColors.primary,
                child: const Icon(
                  Icons.add,
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
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
