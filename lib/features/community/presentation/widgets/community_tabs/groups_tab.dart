import 'package:egy_akin/features/community/presentation/widgets/view_poll_widget.dart';

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
  late final GroupsCubit _cubit;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _cubit = context.read<GroupsCubit>();

    // Initialize ScrollController
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);

    if (_cubit.callGroupsTabTimes == 0) {
      _cubit.getGroupsTab();
      _cubit.callGroupsTabTimes++;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _cubit.getGroupsTab();
    }
  }

  void _onScroll() {
    if (_cubit.isLastPage || _cubit.isLoadingMoreForScroll) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    const threshold = 200.0;

    if (maxScroll - currentScroll <= threshold) {
      _cubit.isLoadingMoreForScroll = true;
      _cubit.loadMorePosts();
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
        onRefresh: () async {
          await _cubit.getGroupsTab();
        },
        child: CustomScrollView(
          controller: scrollController, // ✅ Directly using the controller
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20) +
                    const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          context.tr(AppStrings.joinGroup),
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                          child:  Text(
                            context.tr(AppStrings.seeAll),
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    BlocConsumer<GroupsCubit, GroupsState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => const LoadingForGroupRow(),
                          loaded: (
                            response,
                            snackBarMessage,
                            dialogMessage,
                            isSeeMore,
                            changeCounter,
                          ) {
                            if (response.data!.latestGroups!.isEmpty) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      navigatorKey.currentState?.pushNamed(
                                        AppRoutes.createGroupInCommunity,
                                        arguments: AppRoutesArgs
                                            .createGroupInCommunityRouteArgs(
                                          currentDoctorModel:
                                              widget.currentDoctorModel,
                                          homeDataModel: widget.homeDataModel,
                                          isCreateNewGroup: true,
                                          groupModel: null,
                                        ),
                                      );
                                    },
                                    child:  Text(
                                      context.tr(AppStrings.createFirstGroupInCommunity),

                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
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
                child: Container(height: 10, color: Colors.grey.shade100)),
            BlocBuilder<GroupsCubit, GroupsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => SliverToBoxAdapter(
                    child: SizedBox(
                      height: 500.h,
                      child: const ShimmerLoadingFeeds(numberOfShimmer: 3),
                    ),
                  ),
                  loaded: (
                    response,
                    snackBarMessage,
                    dialogMessage,
                    isSeeMore,
                    changeCounter,
                  ) {
                    if (response.data!.randomPosts!.data!.isEmpty) {
                      return SliverToBoxAdapter(
                        // Wrap Column in SliverToBoxAdapter
                        child: Column(
                          children: [
                            SizedBox(height: 100.h),
                            Image.asset(
                              AppImages.notFound,
                              width: 150,
                            ),
                          ],
                        ),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          PostCommunityModel feed =
                              response.data!.randomPosts!.data![index];
                          final poll = feed
                              .poll; // Store poll in a variable to avoid multiple null checks

                          if (poll != null) {
                            // Ensure initial values are set in postSelectedOptions
                            if (poll.allowMultipleChoice == true &&
                                !_cubit.postSelectedOptions
                                    .containsKey(feed.id)) {
                              _cubit.postSelectedOptions[feed.id!] = {
                                ...poll.options
                                        ?.where(
                                            (option) => option.isVoted ?? false)
                                        .map((option) => option.id!)
                                        .toSet() ??
                                    {}
                              };
                            }

                            // Ensure initial value for single-choice poll
                            if (poll.allowMultipleChoice == false &&
                                !_cubit.postSelectedOption
                                    .containsKey(feed.id)) {
                              _cubit.postSelectedOption[feed.id!] = poll.options
                                  ?.firstWhere(
                                      (option) => option.isVoted ?? false,
                                      orElse: () =>
                                          const PollOptionsModelResponse(
                                              id: -1))
                                  .id;
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 0),
                            child: PostCard(
                              feed: response.data!.randomPosts!.data![index],
                              homeDataModel: widget.homeDataModel,
                              currentDoctorModel: widget.currentDoctorModel,
                              isGroupPosts: true,
                              viewPollWidget: ViewPollWidget(
                                poll: feed.poll,
                                currentDoctorModel: widget.currentDoctorModel,
                                homeDataModel: widget.homeDataModel,
                                selectedOptions:
                                    _cubit.postSelectedOptions[feed.id] ?? {},
                                onAddOption: (pollId, option) async {
                                  await _cubit.addOptionOnPoll(pollId,
                                      option); // Call your function here
                                },
                                initiallyExpanded: false,
                                selectedOption:
                                    _cubit.postSelectedOption[feed.id],
                                onOptionSelected: (optionId) {
                                  _cubit.postSelectedOption[feed.id!] =
                                      optionId;
                                  _cubit.addVoteAndUnVote(
                                    feed.poll!.id.toString(),
                                    optionId!,
                                  );
                                  _cubit.refreshScreen();
                                },
                                onOptionToggled: (optionId, isSelected) {
                                  _cubit.postSelectedOptions[feed.id!] ??= {};
                                  _cubit.addVoteAndUnVote(
                                    feed.poll!.id.toString(),
                                    optionId,
                                  );
                                  if (isSelected) {
                                    _cubit.postSelectedOptions[feed.id!]!
                                        .add(optionId);
                                  } else {
                                    _cubit.postSelectedOptions[feed.id!]!
                                        .remove(optionId);
                                  }
                                  _cubit.refreshScreen();
                                },
                              ),
                              onLikeAndUnlikeAdditional: () {
                                _cubit.addLikeOrUnlikeOnPost(
                                    response.data!.randomPosts!.data![index].id
                                        .toString(),
                                    likeOrUnlike: response.data!.randomPosts!
                                            .data![index].isLiked!
                                        ? 'unlike'
                                        : 'like');
                              },
                              onSaveAndUnSaveAdditional: () {
                                _cubit.addSaveOrUnsaveOnPost(
                                  response.data!.randomPosts!.data![index].id
                                      .toString(),
                                  saveOrUnsave:
                                      feed.isSaved! ? 'unsave' : 'save',
                                );
                              },
                              onDeleteAdditional: () {
                                _cubit.deletePost(response
                                    .data!.randomPosts!.data![index].id
                                    .toString());
                              },
                              showPostFrom: ShowPostFromEnum.groupsTab.name,
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
              child: Column(
                children: [
                  Container(height: 30.h, color: Colors.transparent),
                  BlocBuilder<GroupsCubit, GroupsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () => const SizedBox.shrink(),
                        loaded: (
                          response,
                          snackBarMessage,
                          dialogMessage,
                          isSeeMore,
                          changeCounter,
                        ) {
                          return isSeeMore
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 3),
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                )
                              : const SizedBox.shrink();
                        },
                      );
                    },
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
