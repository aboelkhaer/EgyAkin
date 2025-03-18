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
  CommunitySearchCubit? _cubit;
  @override
  void initState() {
    if (widget.initialValueInSearch != null) {
      context.read<CommunitySearchCubit>().isSearchContentEmpty = false;
      context
          .read<CommunitySearchCubit>()
          .getResponseOfSearchInCommunity(widget.initialValueInSearch!, 100);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<CommunitySearchCubit>();

      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
        _cubit!.scrollController!.addListener(_onScroll);
      }
    });
    super.initState();
  }

  void _onScroll() {
    final cubit = context.read<CommunitySearchCubit>();

    if (cubit.isLastPage || cubit.isLoadingMoreForScroll) {
      return;
    }

    final maxScroll = cubit.scrollController!.position.maxScrollExtent;
    final currentScroll = cubit.scrollController!.position.pixels;
    const threshold = 200.0;

    if (maxScroll - currentScroll <= threshold) {
      cubit.isLoadingMoreForScroll = true;

      // Use correct search value
      final searchValue = widget.initialValueInSearch ?? cubit.searchValue;

      if (searchValue!.isNotEmpty) {
        cubit.loadMorePosts(searchValue);
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
                        cubit.isSearchContentEmpty = false;
                        cubit.searchValue = value;
                        cubit.getResponseOfSearchInCommunity(value);
                      } else {
                        cubit.isSearchContentEmpty = true;
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
                    return const SizedBox.shrink();
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
                    return response.data!.data!.isEmpty ||
                            response.data!.data == null
                        ? Center(
                            child: Image.asset(
                              AppImages.notFound,
                              width: 200,
                              height: 200,
                            ),
                          )
                        : ListView.builder(
                            itemCount: response.data!.data!.length,
                            controller: cubit.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(20) +
                                EdgeInsets.only(bottom: 60.h),
                            itemBuilder: (context, index) {
                              var feed = response.data!.data![index];
                              return PostCard(
                                feed: feed,
                                homeDataModel: widget.homeDataModel,
                                isCommunitySearch: true,
                                currentDoctorModel: widget.currentDoctorModel,
                                highlightWord: widget.initialValueInSearch,
                                viewPollWidget: ViewPollWidget(
                                  poll: feed.poll,
                                  selectedOptions:
                                      _cubit!.postSelectedOptions[feed.id] ??
                                          {},
                                  initiallyExpanded: false,
                                  selectedOption:
                                      _cubit!.postSelectedOption[feed.id],
                                  onOptionSelected: (optionId) {
                                    _cubit!.postSelectedOption[feed.id!] =
                                        optionId;
                                    _cubit!.addVoteAndUnVote(
                                      feed.poll!.id.toString(),
                                      optionId!,
                                    );
                                    _cubit!.refreshScreen();
                                  },
                                  onOptionToggled: (optionId, isSelected) {
                                    _cubit!.postSelectedOptions[feed.id!] ??=
                                        {};
                                    _cubit!.addVoteAndUnVote(
                                      feed.poll!.id.toString(),
                                      optionId,
                                    );
                                    if (isSelected) {
                                      _cubit!.postSelectedOptions[feed.id!]!
                                          .add(optionId);
                                    } else {
                                      _cubit!.postSelectedOptions[feed.id!]!
                                          .remove(optionId);
                                    }
                                    _cubit!.refreshScreen();
                                  },
                                ),
                                onLikeAndUnlikeAdditional: () {
                                  cubit.addLikeOrUnlikeOnPost(
                                      feed.id.toString());
                                },
                                onSaveAndUnSaveAdditional: () {
                                  cubit.addSaveOrUnsaveOnPost(
                                      feed.id.toString());
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
