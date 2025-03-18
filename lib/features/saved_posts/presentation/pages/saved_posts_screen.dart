import 'package:egy_akin/features/community/presentation/widgets/view_poll_widget.dart';
import 'package:egy_akin/features/saved_posts/presentation/cubit/saved_posts_cubit.dart';
import 'package:egy_akin/features/saved_posts/presentation/cubit/saved_posts_state.dart';

import '../../../../exports.dart';

class SavedPostsScreen extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final String doctorId;
  final String doctorName;
  const SavedPostsScreen({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  SavedPostsCubit? _cubit;

  @override
  void initState() {
    super.initState();
    context.read<SavedPostsCubit>().getSavedPosts(widget.doctorId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<SavedPostsCubit>();

      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
        _cubit!.scrollController!.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController!.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (context.read<SavedPostsCubit>().isLastPage) {
      return;
    } else {
      final maxScroll = context
          .read<SavedPostsCubit>()
          .scrollController!
          .position
          .maxScrollExtent;
      final currentScroll =
          context.read<SavedPostsCubit>().scrollController!.position.pixels;
      const threshold = 200.0;
      if (context.read<SavedPostsCubit>().isLoadingMoreForScroll == false &&
          maxScroll - currentScroll <= threshold) {
        context.read<SavedPostsCubit>().isLoadingMoreForScroll = true;

        context.read<SavedPostsCubit>().loadMoreFeeds(widget.doctorId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SavedPostsCubit cubit = SavedPostsCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctorName),
      ),
      body: BlocBuilder<SavedPostsCubit, SavedPostsState>(
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
              response,
              snackBarMessage,
              dialogMessage,
              isDeletePostLoading,
              isDeletePostLoaded,
              isSeeMore,
              changeCounter,
            ) {
              return response.data!.data!.isEmpty
                  ? Center(
                      child: Image.asset(
                        AppImages.notFound,
                        width: 200,
                        height: 200,
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () {
                              return cubit.getSavedPosts(widget.doctorId);
                            },
                            color: AppColors.primary,
                            child: ListView.builder(
                              itemCount: response.data!.data!.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: cubit.scrollController,
                              padding: const EdgeInsets.all(20) +
                                  EdgeInsets.only(bottom: 60.h),
                              itemBuilder: (context, index) {
                                var feed = response.data!.data![index];
                                return PostCard(
                                  feed: feed,
                                  homeDataModel: widget.homeDataModel,
                                  isCommunitySearch: true,
                                  currentDoctorModel: widget.currentDoctorModel,
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
                                    // cubit.deletePost(feed.id.toString());
                                  },
                                  isAllDoctorPosts: true,
                                  allDoctorPostsMenu: BlocConsumer<
                                      SavedPostsCubit, SavedPostsState>(
                                    listener: (context, state) {
                                      state.maybeWhen(
                                        orElse: () {},
                                        error: (message) {
                                          showHintDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              message: message);
                                        },
                                        loaded: (
                                          response,
                                          snackBarMessage,
                                          dialogMessage,
                                          isDeletePostLoading,
                                          isDeletePostLoaded,
                                          isSeeMore,
                                          changeCounter,
                                        ) {
                                          if (snackBarMessage != '') {
                                            customSnackBar(
                                                context: context,
                                                message: snackBarMessage);
                                          }
                                        },
                                      );
                                    },
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                        orElse: () {
                                          return const SizedBox.shrink();
                                        },
                                        loaded: (
                                          response,
                                          snackBarMessage,
                                          dialogMessage,
                                          isDeletePostLoading,
                                          isDeletePostLoaded,
                                          isSeeMore,
                                          changeCounter,
                                        ) {
                                          if (isDeletePostLoading &&
                                              (feed.id.toString() ==
                                                  cubit.postIdDeleted)) {
                                            return Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {},
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    splashColor:
                                                        Colors.transparent,
                                                    icon: const Icon(
                                                      Icons.more_vert,
                                                      color: Colors.transparent,
                                                    )),
                                                const SizedBox(
                                                  height: 15,
                                                  width: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 3,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            );
                                          }

                                          return PopupMenuButton<String>(
                                            icon: const Icon(Icons.more_vert),
                                            onSelected: (String value) {
                                              switch (value) {
                                                case 'Report':
                                                  // Handle report action
                                                  debugPrint('Report clicked');
                                                  break;
                                                case 'Edit':
                                                  // Handle edit action
                                                  navigatorKey.currentState
                                                      ?.pushNamed(
                                                    AppRoutes
                                                        .createPostInCommunity,
                                                    arguments: AppRoutesArgs
                                                        .createPostInCommunityRouteArgs(
                                                      currentDoctorModel: widget
                                                          .currentDoctorModel,
                                                      homeDataModel:
                                                          widget.homeDataModel,
                                                      feed: feed,
                                                    ),
                                                  );
                                                  break;
                                                case 'Delete':
                                                  cubit.deletePost(
                                                    feed.id.toString(),
                                                  );

                                                  break;
                                              }
                                            },
                                            itemBuilder:
                                                (BuildContext context) {
                                              final items =
                                                  <PopupMenuEntry<String>>[];

                                              if (feed.doctor!.id.toString() ==
                                                      widget
                                                          .currentDoctorModel.id
                                                          .toString() ||
                                                  widget.homeDataModel.role ==
                                                      AppStrings.roleAdmin) {
                                                items.add(
                                                  PopupMenuItem(
                                                    value: 'Edit',
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.edit,
                                                            color: AppColors
                                                                .description),
                                                        SizedBox(width: 8.w),
                                                        const Text('Edit'),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                              if ((feed.doctor!.id.toString() ==
                                                      widget
                                                          .currentDoctorModel.id
                                                          .toString() ||
                                                  widget.homeDataModel.role ==
                                                      AppStrings.roleAdmin)) {
                                                items.add(
                                                  PopupMenuItem(
                                                    value: 'Delete',
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.delete,
                                                            color: AppColors
                                                                .description),
                                                        SizedBox(width: 8.w),
                                                        const Text('Delete'),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }

                                              items.add(
                                                PopupMenuItem(
                                                  value: 'Report',
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.report,
                                                          color: AppColors
                                                              .description),
                                                      SizedBox(width: 8.w),
                                                      const Text('Report'),
                                                    ],
                                                  ),
                                                ),
                                              );

                                              return items;
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isSeeMore
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      // Add logic here if needed
                                    },
                                    child: const Text(
                                      '',
                                    ),
                                  ),
                          ],
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
