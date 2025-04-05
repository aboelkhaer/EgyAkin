import '../../../../exports.dart';
import 'package:timeago/timeago.dart' as timeago;

class ShowSingleFeedScreen extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final PostCommunityModel feed;
  final bool isComeFromNotification;
  final String? feedId;

  const ShowSingleFeedScreen({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.feed,
    this.isComeFromNotification = false,
    this.feedId,
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

    scrollController = ScrollController();
    scrollController.addListener(onScroll);

    if (widget.isComeFromNotification) {
      loadFeedFromNotification();
    }
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // Set height to 0
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                                    borderRadius: BorderRadius.circular(80.r),
                                    child: GestureDetector(
                                      onTap: () {
                                        navigatorKey.currentState?.pushNamed(
                                          AppRoutes.doctorInfoView,
                                          arguments: AppRoutesArgs
                                              .doctorInfoViewRouteArgs(
                                            doctorId:
                                                feedToUse.doctor!.id.toString(),
                                            currentDoctorModel:
                                                widget.currentDoctorModel,
                                            currentDoctorPoints: int.parse(
                                                widget
                                                    .homeDataModel.scoreValue!),
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
                                                            .doctor!.firstName,
                                                        lastName: feedToUse
                                                            .doctor!.lastName,
                                                        role: feedToUse.doctor!
                                                            .isSyndicateCardRequired
                                                            .toString(),
                                                      ),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors.title,
                                                        fontSize: 12.sp,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  'Verified' == 'Verified'
                                                      ? const VerificationIcon(
                                                          isPatientCard: false,
                                                        )
                                                      : const SizedBox.shrink(),
                                                ],
                                              ),
                                              Text(
                                                // formatDateTimeForCommunity(
                                                //     widget.feed.createdAt.toString()),
                                                timeago.format(DateTime.parse(
                                                    feedToUse.createdAt
                                                        .toString())),
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
                                        PopupMenuButton<String>(
                                          icon: const Icon(Icons.more_vert),
                                          onSelected: (String value) {
                                            switch (value) {
                                              case 'Report':
                                                // Handle report action
                                                print('Report clicked');
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
                                                // Handle delete action
                                                navigatorKey.currentState
                                                    ?.pop();
                                                sl<CommunityCubit>().deletePost(
                                                  feedToUse.id.toString(),
                                                );

                                                break;
                                            }
                                          },
                                          itemBuilder: (BuildContext context) {
                                            final items =
                                                <PopupMenuEntry<String>>[];
                                            if (feedToUse.doctor!.id
                                                        .toString() ==
                                                    widget.currentDoctorModel.id
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

                                            if (feedToUse.doctor!.id
                                                        .toString() ==
                                                    widget.currentDoctorModel.id
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
                            isSyndicateCardRequired:
                                widget.homeDataModel.isSyndicateCardRequired!,
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
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor:
                                    AppColors.primary.withOpacity(0.8),
                                child: CustomCachedNetworkImage(
                                  imageUrl: feedToUse.doctor!.image.toString(),
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
                                  currentDoctorModel: widget.currentDoctorModel,
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
                                  isNavigateToTheButtonOfInformationTab: false,
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
                                                firstName:
                                                    feedToUse.doctor!.firstName,
                                                lastName:
                                                    feedToUse.doctor!.lastName,
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
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          'Verified' == 'Verified'
                                              ? const VerificationIcon(
                                                  isPatientCard: false,
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                      Text(
                                        // formatDateTimeForCommunity(
                                        //     widget.feed.createdAt.toString()),
                                        timeago.format(DateTime.parse(
                                            feedToUse.createdAt.toString())),
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
                                PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_vert),
                                  onSelected: (String value) {
                                    switch (value) {
                                      case 'Report':
                                        // Handle report action
                                        print('Report clicked');
                                        break;
                                      case 'Edit':
                                        // Handle edit action
                                        navigatorKey.currentState?.pushNamed(
                                          AppRoutes.createPostInCommunity,
                                          arguments: AppRoutesArgs
                                              .createPostInCommunityRouteArgs(
                                            currentDoctorModel:
                                                widget.currentDoctorModel,
                                            homeDataModel: widget.homeDataModel,
                                            feed: feedToUse,
                                          ),
                                        );
                                        break;
                                      case 'Delete':
                                        // Handle delete action
                                        navigatorKey.currentState?.pop();
                                        sl<CommunityCubit>().deletePost(
                                          feedToUse.id.toString(),
                                        );

                                        break;
                                    }
                                  },
                                  itemBuilder: (BuildContext context) {
                                    final items = <PopupMenuEntry<String>>[];
                                    if (feedToUse.doctor!.id.toString() ==
                                            widget.currentDoctorModel.id
                                                .toString() ||
                                        widget.homeDataModel.role ==
                                            AppStrings.roleAdmin) {
                                      items.add(
                                        PopupMenuItem(
                                          value: 'Edit',
                                          child: Row(
                                            children: [
                                              const Icon(Icons.edit,
                                                  color: AppColors.description),
                                              SizedBox(width: 8.w),
                                              const Text('Edit'),
                                            ],
                                          ),
                                        ),
                                      );
                                    }

                                    if (feedToUse.doctor!.id.toString() ==
                                            widget.currentDoctorModel.id
                                                .toString() ||
                                        widget.homeDataModel.role ==
                                            AppStrings.roleAdmin) {
                                      items.add(
                                        PopupMenuItem(
                                          value: 'Delete',
                                          child: Row(
                                            children: [
                                              const Icon(Icons.delete,
                                                  color: AppColors.description),
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
                                                color: AppColors.description),
                                            SizedBox(width: 8.w),
                                            const Text('Report'),
                                          ],
                                        ),
                                      ),
                                    );

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
                    accountVerification: widget.homeDataModel.verified ?? false,
                    isSyndicateCardRequired:
                        widget.homeDataModel.isSyndicateCardRequired!,
                    feed: feedToUse,
                    currentDoctorModel: widget.currentDoctorModel,
                  ),
                ),
              ],
            ),
    );
  }
}
