import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/community/presentation/cubit/community_state.dart';

class PostsTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final ScrollController feedsScrollController;

  const PostsTab({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.feedsScrollController,
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

    return Container(
      // color: Colors.grey.shade200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 1.0,
          ),
        ),
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await cubit.getAllFeeds();
                      },
                      child: feedsResponse.data!.data!.isEmpty
                          ? SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 150.h),
                                    Image.asset(
                                      AppImages.notFound,
                                      width: 150.w,
                                      height: 150.h,
                                    ),
                                    SizedBox(height: 150.h),
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: feedsResponse.data!.data!.length + (isSeeMore ? 1 : 0),
                              controller: widget.feedsScrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(20) +
                                  EdgeInsets.only(bottom: 60.h),
                              itemBuilder: (context, index) {
                                if (index == feedsResponse.data!.data!.length) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: 20.h),
                                    child: Center(
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
                                var feed = feedsResponse.data!.data![index];
                                return PostCard(
                                  feed: feed,
                                  homeDataModel: widget.homeDataModel,
                                  currentDoctorModel: widget.currentDoctorModel,
                                  showPostFrom: ShowPostFromEnum.feedsTab.name,
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
  }
}
