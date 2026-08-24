import 'package:egy_akin/features/community/presentation/widgets/view_poll_widget.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final titleColor = HomeDashboardColors.title(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: Colors.transparent)
              : SystemUiOverlayStyle.dark
                  .copyWith(statusBarColor: Colors.transparent),
          child: Scaffold(
            backgroundColor: scaffold,
            body: Column(
              children: [
                _PostsListHeader(
                  isDark: isDark,
                  scaffold: scaffold,
                  primary: primary,
                  titleColor: titleColor,
                  title: context.tr(AppStrings.savedPosts),
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                Expanded(
                  child: BlocBuilder<SavedPostsCubit, SavedPostsState>(
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
                  final posts = response.data?.data ?? [];
                  if (posts.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () => cubit.getSavedPosts(widget.doctorId),
                      color: primary,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.62,
                            child: _SavedPostsEmptyState(
                              isDark: isDark,
                              primary: primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () {
                              return cubit.getSavedPosts(widget.doctorId);
                            },
                            color: primary,
                            child: ListView.builder(
                              itemCount: response.data!.data!.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: cubit.scrollController,
                              padding: EdgeInsets.fromLTRB(
                                0,
                                12.h,
                                0,
                                60.h,
                              ),
                              itemBuilder: (context, index) {
                                var feed = response.data!.data![index];
                                final poll = feed
                                    .poll; // Store poll in a variable to avoid multiple null checks

                                if (poll != null) {
                                  // Ensure initial values are set in postSelectedOptions
                                  if (poll.allowMultipleChoice == true &&
                                      !_cubit!.postSelectedOptions
                                          .containsKey(feed.id)) {
                                    _cubit!.postSelectedOptions[feed.id!] = {
                                      ...poll.options
                                              ?.where((option) =>
                                                  option.isVoted ?? false)
                                              .map((option) => option.id!)
                                              .toSet() ??
                                          {}
                                    };
                                  }

                                  // Ensure initial value for single-choice poll
                                  if (poll.allowMultipleChoice == false &&
                                      !_cubit!.postSelectedOption
                                          .containsKey(feed.id)) {
                                    _cubit!.postSelectedOption[feed.id!] = poll
                                        .options
                                        ?.firstWhere(
                                            (option) => option.isVoted ?? false,
                                            orElse: () =>
                                                const PollOptionsModelResponse(
                                                    id: -1))
                                        .id;
                                  }
                                }
                                return PostCard(
                                  feed: feed,
                                  homeDataModel: widget.homeDataModel,
                                  isCommunitySearch: true,
                                  showPostFrom:
                                      ShowPostFromEnum.savedPosts.name,
                                  currentDoctorModel: widget.currentDoctorModel,
                                  viewPollWidget: ViewPollWidget(
                                    poll: feed.poll,
                                    currentDoctorModel:
                                        widget.currentDoctorModel,
                                    homeDataModel: widget.homeDataModel,
                                    selectedOptions:
                                        _cubit!.postSelectedOptions[feed.id] ??
                                            {},
                                    onAddOption: (pollId, option) async {
                                      await _cubit!.addOptionOnPoll(pollId,
                                          option); // Call your function here
                                    },
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

                                          return (widget.homeDataModel.role !=
                                                      AppStrings.roleAdmin &&
                                                  widget.currentDoctorModel.id
                                                          .toString() !=
                                                      feed.doctor!.id
                                                          .toString())
                                              ? const SizedBox.shrink()
                                              : PopupMenuButton<String>(
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color: titleColor,
                                                  ),
                                                  onSelected: (String value) {
                                                    switch (value) {
                                                      case 'Report':
                                                        // Handle report action
                                                        debugPrint(
                                                            'Report clicked');
                                                        break;
                                                      case 'Edit':
                                                        // Handle edit action
                                                        navigatorKey
                                                            .currentState
                                                            ?.pushNamed(
                                                          AppRoutes
                                                              .createPostInCommunity,
                                                          arguments: AppRoutesArgs
                                                              .createPostInCommunityRouteArgs(
                                                            currentDoctorModel:
                                                                widget
                                                                    .currentDoctorModel,
                                                            homeDataModel: widget
                                                                .homeDataModel,
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
                                                        <PopupMenuEntry<
                                                            String>>[];

                                                    if (feed.doctor!.id
                                                                .toString() ==
                                                            widget
                                                                .currentDoctorModel
                                                                .id
                                                                .toString() ||
                                                        widget.homeDataModel
                                                                .role ==
                                                            AppStrings
                                                                .roleAdmin) {
                                                      items.add(
                                                        PopupMenuItem(
                                                          value: 'Edit',
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons.edit,
                                                                  color: AppColors
                                                                      .description),
                                                              SizedBox(
                                                                  width: 8.w),
                                                              Text(context.tr(
                                                                  AppStrings
                                                                      .edit)),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    if ((feed.doctor!.id
                                                                .toString() ==
                                                            widget
                                                                .currentDoctorModel
                                                                .id
                                                                .toString() ||
                                                        widget.homeDataModel
                                                                .role ==
                                                            AppStrings
                                                                .roleAdmin)) {
                                                      items.add(
                                                        PopupMenuItem(
                                                          value: 'Delete',
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons.delete,
                                                                  color: AppColors
                                                                      .description),
                                                              SizedBox(
                                                                  width: 8.w),
                                                              Text(
                                                                context.tr(
                                                                    AppStrings
                                                                        .delete),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    // items.add(
                                                    //   PopupMenuItem(
                                                    //     value: 'Report',
                                                    //     child: Row(
                                                    //       children: [
                                                    //         const Icon(
                                                    //             Icons.report,
                                                    //             color: AppColors
                                                    //                 .description),
                                                    //         SizedBox(
                                                    //             width: 8.w),
                                                    //         const Text(
                                                    //             'Report'),
                                                    //       ],
                                                    //     ),
                                                    //   ),
                                                    // );

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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PostsListHeader extends StatelessWidget {
  final bool isDark;
  final Color scaffold;
  final Color primary;
  final Color titleColor;
  final String title;
  final VoidCallback onBack;

  const _PostsListHeader({
    required this.isDark,
    required this.scaffold,
    required this.primary,
    required this.titleColor,
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF4A2F7A),
                  const Color(0xFF2B1A52),
                  scaffold,
                ]
              : [
                  primary.withOpacity(0.28),
                  primary.withOpacity(0.14),
                  scaffold,
                ],
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 12.h),
          child: SizedBox(
            height: 36.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44.w),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : titleColor,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Material(
                    color: isDark ? const Color(0xFF2A2733) : Colors.white,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onBack,
                      child: Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark
                                ? const Color(0xFF3A3645)
                                : const Color(0xFFE6E2F0),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16.sp,
                          color:
                              isDark ? Colors.white : const Color(0xFF1F2937),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SavedPostsEmptyState extends StatelessWidget {
  final bool isDark;
  final Color primary;

  const _SavedPostsEmptyState({
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final border = isDark
        ? Colors.white.withOpacity(0.06)
        : const Color(0xFFE8E8EE);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88.r,
              height: 88.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primary.withOpacity(isDark ? 0.28 : 0.16),
                    primary.withOpacity(isDark ? 0.1 : 0.05),
                  ],
                ),
                border: Border.all(color: primary.withOpacity(0.22)),
              ),
              child: Icon(
                Icons.bookmark_border_rounded,
                size: 36.sp,
                color: primary,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              context.tr(AppStrings.noSavedPostsYet),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                color: HomeDashboardColors.title(isDark),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              context.tr(AppStrings.bookmarkPostsToRevisit),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
                height: 1.45,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ),
            SizedBox(height: 18.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: border),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bookmark_rounded,
                    size: 14.sp,
                    color: primary,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    context.tr(AppStrings.tapBookmarkOnAnyPostToSave),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: HomeDashboardColors.subtitle(isDark),
                    ),
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
