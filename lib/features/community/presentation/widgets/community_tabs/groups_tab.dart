import '../../../../../exports.dart';

class GroupsTab extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  const GroupsTab({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
  });

  @override
  State<GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    // Add the observer to listen for lifecycle events
    WidgetsBinding.instance.addObserver(this);

    // Fetch groups data on initial load
    if (context.read<GroupsCubit>().callGroupsTabTimes == 0) {
      context.read<GroupsCubit>().getGroupsTab();
      context.read<GroupsCubit>().callGroupsTabTimes++;
    }
  }

  @override
  void dispose() {
    // Remove the observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Check if the app has resumed
    if (state == AppLifecycleState.resumed) {
      // Fetch groups data when the app resumes
      context.read<GroupsCubit>().getGroupsTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 1.0,
          ),
        ),
      ),
      child: RefreshIndicator(
        onRefresh: () {
          return context.read<GroupsCubit>().getGroupsTab();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20) +
                    const EdgeInsets.only(
                      bottom: 20,
                    ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Join Group',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.allGroupsInCommunity,
                              arguments:
                                  AppRoutesArgs.allGroupsInCommunityRouteArgs(
                                currentDoctorModel: widget.currentDoctorModel,
                                homeDataModel: widget.homeDataModel,
                              ),
                            );
                          },
                          style: ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocConsumer<GroupsCubit, GroupsState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          initial: () {},
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const LoadingForGroupRow();
                          },
                          loaded: (
                            response,
                            snackBarMessage,
                            dialogMessage,
                          ) {
                            return Column(
                              children: List.generate(
                                response.data!.latestGroups!.length,
                                (index) => GroupRow(
                                  currentDoctorModel: widget.currentDoctorModel,
                                  homeDataModel: widget.homeDataModel,
                                  groupModel:
                                      response.data!.latestGroups![index],
                                  groupPosition: GroupPosition.groupTab,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 10,
                color: Colors.grey.shade100,
              ),
            ),
            BlocBuilder<GroupsCubit, GroupsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 500.h, // Provide a fixed height
                        child: const ShimmerLoadingFeeds(
                          numberOfShimmer: 3,
                        ),
                      ),
                    );
                  },
                  loaded: (
                    response,
                    snackBarMessage,
                    dialogMessage,
                  ) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 0),
                            child: PostCard(
                              feed: response.data!.randomPosts!.data![index],
                              homeDataModel: widget.homeDataModel,
                              currentDoctorModel: widget.currentDoctorModel,
                              isGroupPosts: true,
                              onLikeAndUnlikeAdditional: () {
                                context
                                    .read<GroupsCubit>()
                                    .addLikeOrUnlikeOnPost(response
                                        .data!.randomPosts!.data![index].id
                                        .toString());
                              },
                              onSaveAndUnSaveAdditional: () {
                                context
                                    .read<GroupsCubit>()
                                    .addSaveOrUnsaveOnPost(response
                                        .data!.randomPosts!.data![index].id
                                        .toString());
                              },
                              onDeleteAdditional: () {
                                context.read<GroupsCubit>().deletePost(response
                                    .data!.randomPosts!.data![index].id
                                    .toString());
                              },
                            ),
                          );
                        },
                        childCount: response.data!.randomPosts!.data!.length,
                      ),
                    );
                  },
                );
              },
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 50.h,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
