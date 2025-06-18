import 'package:egy_akin/features/community/presentation/widgets/view_poll_widget.dart';
import 'package:egy_akin/features/community_search/presentation/cubit/community_search_cubit.dart';
import 'package:egy_akin/features/community_search/presentation/cubit/community_search_state.dart';

import '../../../../exports.dart';

class CommunitySearchScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String? initialValueInSearch;
  const CommunitySearchScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    this.initialValueInSearch,
  });

  @override
  State<CommunitySearchScreen> createState() => _CommunitySearchScreenState();
}

class _CommunitySearchScreenState extends State<CommunitySearchScreen> {
  late final CommunitySearchCubit _cubit;
  late final ScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CommunitySearchCubit>();
    _scrollController = ScrollController()..addListener(_onScroll);

    // Initialize search if initial value is provided
    if (widget.initialValueInSearch != null) {
      // _searchController.text = widget.initialValueInSearch!;
      _cubit.isSearchContentEmpty = false;
      _cubit.searchValue = widget.initialValueInSearch;
      _cubit.getResponseOfSearchInCommunity(100);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_cubit.isLastPage || _cubit.isLoadingMoreForScroll) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    const threshold = 200.0;

    if (maxScroll - currentScroll <= threshold) {
      _cubit.isLoadingMoreForScroll = true;
      final searchValue = widget.initialValueInSearch ?? _cubit.searchValue;

      if (searchValue?.isNotEmpty ?? false) {
        _cubit.loadMorePosts(searchValue!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final CommunitySearchCubit cubit = CommunitySearchCubit.get(context);
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
                    isSearchIconInCenter:
                        cubit.isSearchContentEmpty ? true : false,
                    initialValue: widget.initialValueInSearch,
                    autoFocus:
                        widget.initialValueInSearch == null ? true : false,
                    textInputType: TextInputType.text,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        cubit.currentPage = 1;
                        cubit.isSearchContentEmpty = false;

                        cubit.searchValue = value;

                        cubit.getResponseOfSearchInCommunity();
                      } else {
                        cubit.isSearchContentEmpty = true;
                        cubit.searchValue = value;
                        // Reset to empty state when search is cleared
                        cubit.resetPostsList();
                      }
                    },
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
          Divider(
            color: Colors.grey.shade200,
          ),
          Expanded(
            child: BlocBuilder<CommunitySearchCubit, CommunitySearchState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    // Show empty state for initial state
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.notFound,
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Start typing to search for posts',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () {
                    return const ShimmerLoadingFeeds(
                      numberOfShimmer: 5,
                    );
                  },
                  loaded: (
                    snackBarMessage,
                    dialogMessage,
                    response,
                    isSeeMore,
                    changeCounter,
                  ) {
                    // Check if search is empty and show initial state
                    if (cubit.isSearchContentEmpty || (cubit.searchValue?.isEmpty ?? true)) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.notFound,
                              width: 150,
                              height: 150,
                            ),
                            Text(
                              'Start typing to search for posts',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            SizedBox(height: 50.h),
                          ],
                        ),
                      );
                    }
                    
                    return response.data!.data!.isEmpty ||
                            response.data!.data == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.notFound,
                                  width: 200,
                                  height: 200,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No posts found for "${cubit.searchValue}"',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: response.data!.data!.length,
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(20) +
                                EdgeInsets.only(bottom: 60.h),
                            itemBuilder: (context, index) {
                              var feed = response.data!.data![index];
                              return PostCard(
                                feed: feed,
                                homeDataModel: widget.homeDataModel,
                                isCommunitySearch: true,
                                showPostFrom: ShowPostFromEnum.searchTab.name,
                                currentDoctorModel: widget.currentDoctorModel,
                                highlightWord: _cubit.searchValue,
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
                                  cubit.addLikeOrUnlikeOnPost(
                                    feed.id.toString(),
                                    likeOrUnlike:
                                        feed.isLiked! ? 'unlike' : 'like',
                                  );
                                },
                                onSaveAndUnSaveAdditional: () {
                                  cubit.addSaveOrUnsaveOnPost(
                                    feed.id.toString(),
                                    saveOrUnsave:
                                        feed.isSaved! ? 'unsave' : 'save',
                                  );
                                },
                                onDeleteAdditional: () {
                                  cubit.deletePost(feed.id.toString());
                                },
                              );
                            },
                          );
                  },
                );
              },
            ),
          ),
          BlocBuilder<CommunitySearchCubit, CommunitySearchState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
                },
                loaded: (
                  snackBarMessage,
                  dialogMessage,
                  response,
                  isSeeMore,
                  changeCounter,
                ) {
                  return isSeeMore
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(strokeWidth: 3),
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
    );
  }
}
