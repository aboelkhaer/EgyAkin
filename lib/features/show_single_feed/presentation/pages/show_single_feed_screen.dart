import 'dart:developer';

import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class ShowSingleFeedScreen extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final PostCommunityModel feed;
  final bool isComeFromNotification;
  final String? feedId;
  final String showPostFrom;

  const ShowSingleFeedScreen({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.feed,
    this.isComeFromNotification = false,
    this.feedId,
    required this.showPostFrom,
  });

  @override
  State<ShowSingleFeedScreen> createState() => _ShowSingleFeedScreenState();
}

class _ShowSingleFeedScreenState extends State<ShowSingleFeedScreen> {
  late final ShowSingleFeedCubit _cubit;
  late ScrollController scrollController;
  PostCommunityModel? _currentFeed;
  @override
  void initState() {
    super.initState();
    _cubit = context.read<ShowSingleFeedCubit>();
    _currentFeed = widget.feed; // Initialize with the widget's feed
    _cubit.showPostFrom = widget.showPostFrom;
    log(_cubit.showPostFrom);

    scrollController = ScrollController();
    scrollController.addListener(onScroll);

    if (widget.isComeFromNotification) {
      loadFeedFromNotification();
    } else {
      // Initial load for normal case
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_currentFeed != null) {
          _cubit.getCommentsInCommunity(
            _currentFeed!.id.toString(),
            _currentFeed!,
            widget.isComeFromNotification,
          );
        }
      });
    }
  }

  Future<void> loadFeedFromNotification() async {
    try {
      final newFeed =
          await _cubit.getPostByIdWhenComeFromNotification(widget.feedId!);
      setState(() {
        _currentFeed = newFeed;
      });
      // Load comments after getting the feed
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_currentFeed != null) {
          _cubit.getCommentsInCommunity(
            _currentFeed!.id.toString(),
            _currentFeed!,
            widget.isComeFromNotification,
          );
        }
      });
    } catch (e) {
      debugPrint('Error loading feed from notification: $e');
    }
  }

  void onScroll() {
    // Only trigger if we're not already loading and have scroll positions
    if (!scrollController.hasClients ||
        _cubit.isLastPage ||
        _cubit.isLoadingMoreForScroll) return;

    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      _cubit.loadMoreComments(_currentFeed!.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ShowSingleFeedCubit cubit = ShowSingleFeedCubit.get(context);
    final feedToUse = _currentFeed ?? widget.feed;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          backgroundColor: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0), // Set height to 0
            child: AppBar(
              systemOverlayStyle: isDarkMode
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
              backgroundColor: Colors.transparent,
            ),
          ),
          body: widget.isComeFromNotification
              ? BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      error: (message) {
                        if (message ==
                            'An error occurred while retrieving post comments') {
                          return Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    SizedBox(width: 10.h),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                      ),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          context.tr(AppStrings
                                              .thisContentIsNoLongerAvailable),
                                          style: TextStyle(
                                              color: Colors.grey.shade700),
                                        ),
                                        SizedBox(height: 50.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      loaded: (commentsResponse,
                          changeCounter,
                          feed,
                          isSendCommentLoading,
                          isSendCommentLoaded,
                          message,
                          highlightedCommentId,
                          isDeleteCommentLoading,
                          isDeleteCommentLoaded,
                          isSendReplyLoading,
                          isSendReplyLoaded,
                          isSeeMore) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        navigatorKey.currentState?.pop();
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 9,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(80.r),
                                        child: GestureDetector(
                                          onTap: () {
                                            navigatorKey.currentState
                                                ?.pushNamed(
                                              AppRoutes.doctorInfoView,
                                              arguments: AppRoutesArgs
                                                  .doctorInfoViewRouteArgs(
                                                doctorId: feedToUse.doctor!.id
                                                    .toString(),
                                                currentDoctorModel:
                                                    widget.currentDoctorModel,
                                                currentDoctorPoints: int.parse(
                                                    widget.homeDataModel
                                                        .scoreValue!),
                                                accountVerification: widget
                                                    .homeDataModel.verified!,
                                                initialIndex: 0,
                                                isSyndicateCardRequired: widget
                                                    .homeDataModel
                                                    .isSyndicateCardRequired
                                                    .toString(),
                                                currentDoctorRole: widget
                                                    .homeDataModel.role
                                                    .toString(),
                                                homeDataModel:
                                                    widget.homeDataModel,
                                                isNavigateToTheButtonOfInformationTab:
                                                    false,
                                              ),
                                            );
                                          },
                                          child: CircleAvatar(
                                            radius: 20.r,
                                            backgroundColor: AppColors.primary
                                                .withOpacity(0.8),
                                            child: CustomCachedNetworkImage(
                                              imageUrl: feedToUse.doctor!.image
                                                  .toString(),
                                              height: 100.h,
                                              width: 100.w,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          navigatorKey.currentState?.pushNamed(
                                            AppRoutes.doctorInfoView,
                                            arguments: AppRoutesArgs
                                                .doctorInfoViewRouteArgs(
                                              doctorId: feedToUse.doctor!.id
                                                  .toString(),
                                              currentDoctorModel:
                                                  widget.currentDoctorModel,
                                              currentDoctorPoints: int.parse(
                                                  widget.homeDataModel
                                                      .scoreValue!),
                                              accountVerification: widget
                                                  .homeDataModel.verified!,
                                              initialIndex: 0,
                                              isSyndicateCardRequired: widget
                                                  .homeDataModel
                                                  .isSyndicateCardRequired
                                                  .toString(),
                                              currentDoctorRole: widget
                                                  .homeDataModel.role
                                                  .toString(),
                                              homeDataModel:
                                                  widget.homeDataModel,
                                              isNavigateToTheButtonOfInformationTab:
                                                  false,
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 12.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          doctorName(
                                                            firstName: feedToUse
                                                                .doctor!
                                                                .firstName,
                                                            lastName: feedToUse
                                                                .doctor!
                                                                .lastName,
                                                            role: feedToUse
                                                                .doctor!
                                                                .isSyndicateCardRequired
                                                                .toString(),
                                                          ),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                AppColors.title,
                                                            fontSize: 12.sp,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      isVerifiedUser(feed
                                                              .doctor!
                                                              .isSyndicateCardRequired)
                                                          ? const VerificationIcon(
                                                              isPatientCard:
                                                                  false,
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                    ],
                                                  ),
                                                  Text(
                                                    // formatDateTimeForCommunity(
                                                    //     widget.feed.createdAt.toString()),
                                                    TimeAgoService.instance
                                                        .formatTimeAgoFromString(
                                                            feedToUse.createdAt
                                                                .toString(),
                                                            context),
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.description,
                                                      fontSize: 11.sp,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            (widget.homeDataModel.role !=
                                                        AppStrings.roleAdmin &&
                                                    widget.currentDoctorModel.id
                                                            .toString() !=
                                                        feed.doctor!.id
                                                            .toString())
                                                ? const SizedBox.shrink()
                                                : PopupMenuButton<String>(
                                                    icon: const Icon(
                                                        Icons.more_vert),
                                                    onSelected: (String value) {
                                                      switch (value) {
                                                        case 'Report':
                                                          // Handle report action
                                                          print(
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
                                                              feed: feedToUse,
                                                            ),
                                                          );
                                                          break;
                                                        case 'Delete':
                                                          // Handle delete action

                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                  context.tr(
                                                                      AppStrings
                                                                          .deletePost),
                                                                ),
                                                                content: Text(
                                                                  context.tr(
                                                                      AppStrings
                                                                          .areYouSureYouWantToDeleteThisPost),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context); // Close the dialog
                                                                    },
                                                                    child: Text(
                                                                      context.tr(
                                                                          AppStrings
                                                                              .cancel),
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      // Perform the deletion logic here
                                                                      // For example, update the state or call a callback
                                                                      sl<CommunityCubit>()
                                                                          .deletePost(
                                                                        feedToUse
                                                                            .id
                                                                            .toString(),
                                                                      );
                                                                      Navigator.pop(
                                                                          context); // Close the dialog
                                                                      navigatorKey
                                                                          .currentState
                                                                          ?.pop();
                                                                    },
                                                                    child: Text(
                                                                      context.tr(
                                                                          AppStrings
                                                                              .delete),
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );

                                                          break;
                                                      }
                                                    },
                                                    itemBuilder:
                                                        (BuildContext context) {
                                                      final items =
                                                          <PopupMenuEntry<
                                                              String>>[];
                                                      if (feedToUse.doctor!.id
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
                                                                Text(
                                                                  context.tr(
                                                                      AppStrings
                                                                          .edit),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }

                                                      if (feedToUse.doctor!.id
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
                                                            value: 'Delete',
                                                            child: Row(
                                                              children: [
                                                                const Icon(
                                                                    Icons
                                                                        .delete,
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
                                                      //         const Icon(Icons.report,
                                                      //             color: AppColors
                                                      //                 .description),
                                                      //         SizedBox(width: 8.w),
                                                      //         const Text('Report'),
                                                      //       ],
                                                      //     ),
                                                      //   ),
                                                      // );

                                                      return items;
                                                    },
                                                  ),
                                            const SizedBox(width: 5),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        FeedContentInCommunity(
                                          homeDataModel: widget.homeDataModel,
                                          currentDoctorModel:
                                              widget.currentDoctorModel,
                                          feed: feedToUse,
                                        ),
                                        CommentsInCommunity(
                                          homeDataModel: widget.homeDataModel,
                                          currentDoctorModel:
                                              widget.currentDoctorModel,
                                          feed: feedToUse,
                                        ),
                                        SizedBox(height: 100.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: WriteCommentInCommunity(
                                accountVerification:
                                    widget.homeDataModel.verified ?? false,
                                isSyndicateCardRequired: widget.homeDataModel
                                        .isSyndicateCardRequired ??
                                    'Required',
                                feed: feedToUse,
                                currentDoctorModel: widget.currentDoctorModel,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                navigatorKey.currentState?.pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 2,
                                    blurRadius: 9,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80.r),
                                child: GestureDetector(
                                  onTap: () {
                                    navigatorKey.currentState?.pushNamed(
                                      AppRoutes.doctorInfoView,
                                      arguments:
                                          AppRoutesArgs.doctorInfoViewRouteArgs(
                                        doctorId:
                                            feedToUse.doctor!.id.toString(),
                                        currentDoctorModel:
                                            widget.currentDoctorModel,
                                        currentDoctorPoints: int.parse(
                                            widget.homeDataModel.scoreValue!),
                                        accountVerification:
                                            widget.homeDataModel.verified!,
                                        initialIndex: 0,
                                        isSyndicateCardRequired: widget
                                            .homeDataModel
                                            .isSyndicateCardRequired
                                            .toString(),
                                        currentDoctorRole: widget
                                            .homeDataModel.role
                                            .toString(),
                                        homeDataModel: widget.homeDataModel,
                                        isNavigateToTheButtonOfInformationTab:
                                            false,
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor:
                                        AppColors.primary.withOpacity(0.8),
                                    child: CustomCachedNetworkImage(
                                      imageUrl:
                                          feedToUse.doctor!.image.toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.doctorInfoView,
                                    arguments:
                                        AppRoutesArgs.doctorInfoViewRouteArgs(
                                      doctorId: feedToUse.doctor!.id.toString(),
                                      currentDoctorModel:
                                          widget.currentDoctorModel,
                                      currentDoctorPoints: int.parse(
                                          widget.homeDataModel.scoreValue!),
                                      accountVerification:
                                          widget.homeDataModel.verified!,
                                      initialIndex: 0,
                                      isSyndicateCardRequired: widget
                                          .homeDataModel.isSyndicateCardRequired
                                          .toString(),
                                      currentDoctorRole:
                                          widget.homeDataModel.role.toString(),
                                      homeDataModel: widget.homeDataModel,
                                      isNavigateToTheButtonOfInformationTab:
                                          false,
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  doctorName(
                                                    firstName: feedToUse
                                                        .doctor!.firstName,
                                                    lastName: feedToUse
                                                        .doctor!.lastName,
                                                    role: feedToUse.doctor!
                                                        .isSyndicateCardRequired
                                                        .toString(),
                                                  ),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.title,
                                                    fontSize: 12.sp,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              isVerifiedUser(feedToUse.doctor!
                                                      .isSyndicateCardRequired)
                                                  ? const VerificationIcon(
                                                      isPatientCard: false,
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                          Text(
                                            // formatDateTimeForCommunity(
                                            //     widget.feed.createdAt.toString()),
                                            TimeAgoService.instance
                                                .formatTimeAgoFromString(
                                                    feedToUse.createdAt
                                                        .toString(),
                                                    context),
                                            style: TextStyle(
                                              color: AppColors.description,
                                              fontSize: 11.sp,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    !isVerifiedUser(widget.homeDataModel
                                            .isSyndicateCardRequired)
                                        ? const SizedBox.shrink()
                                        : PopupMenuButton<String>(
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
                                                      feed: feedToUse,
                                                    ),
                                                  );
                                                  break;
                                                case 'Delete':
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          context.tr(AppStrings
                                                              .deletePost),
                                                        ),
                                                        content: Text(
                                                          context.tr(AppStrings
                                                              .areYouSureYouWantToDeleteThisPost),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context); // Close the dialog
                                                            },
                                                            child: Text(
                                                              context.tr(
                                                                  AppStrings
                                                                      .cancel),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              // Perform the deletion logic here
                                                              // For example, update the state or call a callback
                                                              sl<CommunityCubit>()
                                                                  .deletePost(
                                                                feedToUse.id
                                                                    .toString(),
                                                              );
                                                              Navigator.pop(
                                                                  context); // Close the dialog
                                                              navigatorKey
                                                                  .currentState
                                                                  ?.pop();
                                                            },
                                                            child: Text(
                                                              context.tr(
                                                                  AppStrings
                                                                      .delete),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );

                                                  break;
                                              }
                                            },
                                            itemBuilder:
                                                (BuildContext context) {
                                              final items =
                                                  <PopupMenuEntry<String>>[];
                                              if (feedToUse.doctor!.id
                                                          .toString() ==
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
                                                        Text(
                                                          context.tr(
                                                              AppStrings.edit),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }

                                              if (feedToUse.doctor!.id
                                                          .toString() ==
                                                      widget
                                                          .currentDoctorModel.id
                                                          .toString() ||
                                                  widget.homeDataModel.role ==
                                                      AppStrings.roleAdmin) {
                                                items.add(
                                                  PopupMenuItem(
                                                    value: 'Delete',
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.delete,
                                                            color: AppColors
                                                                .description),
                                                        SizedBox(width: 8.w),
                                                        Text(
                                                          context.tr(AppStrings
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
                                              //         const Icon(Icons.report,
                                              //             color: AppColors.description),
                                              //         SizedBox(width: 8.w),
                                              //         const Text('Report'),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // );

                                              return items;
                                            },
                                          ),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: scrollController,
                            child: Column(
                              children: [
                                FeedContentInCommunity(
                                  homeDataModel: widget.homeDataModel,
                                  currentDoctorModel: widget.currentDoctorModel,
                                  feed: feedToUse,
                                ),
                                CommentsInCommunity(
                                  homeDataModel: widget.homeDataModel,
                                  currentDoctorModel: widget.currentDoctorModel,
                                  feed: feedToUse,
                                ),
                                SizedBox(height: 220.h),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: WriteCommentInCommunity(
                        accountVerification:
                            widget.homeDataModel.verified ?? false,
                        isSyndicateCardRequired:
                            widget.homeDataModel.isSyndicateCardRequired!,
                        feed: feedToUse,
                        currentDoctorModel: widget.currentDoctorModel,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
