import 'package:egy_akin/app/shared/widgets/hash_tag_text.dart';
import 'package:egy_akin/features/community/presentation/cubit/community_state.dart';
import 'package:egy_akin/features/community/presentation/widgets/images_in_post_card.dart';
import 'package:egy_akin/features/community/presentation/widgets/view_poll_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../exports.dart';

class PostCard extends StatelessWidget {
  final PostCommunityModel feed;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final bool isGroupPosts;
  final bool isCommunitySearch;
  final bool isAllDoctorPosts;
  final Widget? allDoctorPostsMenu;
  final Widget? viewPollWidget;
  final String? highlightWord;

  final void Function()? onLikeAndUnlikeAdditional;
  final void Function()? onSaveAndUnSaveAdditional;
  final void Function()? onDeleteAdditional;

  const PostCard({
    super.key,
    required this.feed,
    required this.homeDataModel,
    required this.currentDoctorModel,
    this.viewPollWidget,
    this.isGroupPosts = false,
    this.onLikeAndUnlikeAdditional,
    this.onSaveAndUnSaveAdditional,
    this.onDeleteAdditional,
    this.allDoctorPostsMenu,
    this.isAllDoctorPosts = false,
    this.isCommunitySearch = false,
    this.highlightWord,
  });

  @override
  Widget build(BuildContext context) {
    CommunityCubit cubit = CommunityCubit.get(context);
    final PageController pageController = PageController();

    return Container(
      margin: EdgeInsets.only(bottom: isGroupPosts ? 0 : 16),
      // padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: isGroupPosts
                ? const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 20)
                : const EdgeInsets.all(20),
            child: Column(
              children: [
                isGroupPosts && feed.group != null
                    ? Column(
                        children: [
                          InkWell(
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.groupDetailsInCommunity,
                                arguments: AppRoutesArgs
                                    .groupDetailsInCommunityRouteArgs(
                                  currentDoctorModel: currentDoctorModel,
                                  homeDataModel: homeDataModel,
                                  groupId: feed.group!.id.toString(),
                                ),
                              );
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  'Posted at',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  feed.group!.name.toString(),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            thickness: 0.5,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox.shrink(),

                InkWell(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed(
                      AppRoutes.showSingleFeed,
                      arguments: AppRoutesArgs.showSingleFeedRouteArgs(
                        homeDataModel: homeDataModel,
                        currentDoctorModel: currentDoctorModel,
                        feed: feed,
                      ),
                    );
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
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
                              // Handle user profile navigation here
                            },
                            child: GestureDetector(
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.doctorInfoView,
                                  arguments:
                                      AppRoutesArgs.doctorInfoViewRouteArgs(
                                    doctorId: feed.doctor!.id.toString(),
                                    currentDoctorModel: currentDoctorModel,
                                    currentDoctorPoints:
                                        int.parse(homeDataModel.scoreValue!),
                                    accountVerification:
                                        homeDataModel.verified!,
                                    initialIndex: 0,
                                    isSyndicateCardRequired: homeDataModel
                                        .isSyndicateCardRequired
                                        .toString(),
                                    currentDoctorRole:
                                        homeDataModel.role.toString(),
                                    homeDataModel: homeDataModel,
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
                                  imageUrl: feed.doctor!.image.toString(),
                                  height: 100.h,
                                  width: 100.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: GestureDetector(
                                          onTap: () {
                                            navigatorKey.currentState
                                                ?.pushNamed(
                                              AppRoutes.doctorInfoView,
                                              arguments: AppRoutesArgs
                                                  .doctorInfoViewRouteArgs(
                                                doctorId:
                                                    feed.doctor!.id.toString(),
                                                currentDoctorModel:
                                                    currentDoctorModel,
                                                currentDoctorPoints: int.parse(
                                                    homeDataModel.scoreValue!),
                                                accountVerification:
                                                    homeDataModel.verified!,
                                                initialIndex: 0,
                                                isSyndicateCardRequired:
                                                    homeDataModel
                                                        .isSyndicateCardRequired
                                                        .toString(),
                                                currentDoctorRole: homeDataModel
                                                    .role
                                                    .toString(),
                                                homeDataModel: homeDataModel,
                                                isNavigateToTheButtonOfInformationTab:
                                                    false,
                                              ),
                                            );
                                          },
                                          child: Text(
                                            doctorName(
                                              firstName: feed.doctor!.firstName,
                                              lastName: feed.doctor!.lastName,
                                              role: feed.doctor!
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
                                    //     feed.createdAt.toString()),
                                    timeago.format(DateTime.parse(
                                        feed.createdAt.toString())),
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
                            isAllDoctorPosts
                                ? allDoctorPostsMenu!
                                : BlocConsumer<CommunityCubit, CommunityState>(
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
                                          feedsResponse,
                                          isDeletePostLoading,
                                          isDeletePostLoaded,
                                          message,
                                          isSeeMore,
                                          changeCounter,
                                        ) {
                                          if (message != '') {
                                            customSnackBar(
                                                context: context,
                                                message: message);
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
                                          feedsResponse,
                                          isDeletePostLoading,
                                          isDeletePostLoaded,
                                          message,
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
                                                      currentDoctorModel:
                                                          currentDoctorModel,
                                                      homeDataModel:
                                                          homeDataModel,
                                                      feed: feed,
                                                    ),
                                                  );
                                                  break;
                                                case 'Delete':
                                                  if (isGroupPosts ||
                                                      isCommunitySearch) {
                                                    onDeleteAdditional!();
                                                  } else {
                                                    cubit.deletePost(
                                                      feed.id.toString(),
                                                    );
                                                  }

                                                  break;
                                              }
                                            },
                                            itemBuilder:
                                                (BuildContext context) {
                                              final items =
                                                  <PopupMenuEntry<String>>[
                                                // PopupMenuItem(
                                                //   value: 'Report',
                                                //   child: Row(
                                                //     children: [
                                                //       const Icon(Icons.report,
                                                //           color:
                                                //               AppColors.description),
                                                //       SizedBox(width: 8.w),
                                                //       const Text('Report'),
                                                //     ],
                                                //   ),
                                                // ),
                                              ];

                                              if (feed.doctor!.id.toString() ==
                                                      currentDoctorModel.id
                                                          .toString() ||
                                                  homeDataModel.role ==
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
                                                      currentDoctorModel.id
                                                          .toString() ||
                                                  homeDataModel.role ==
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // const SizedBox(height: 20),
                feed.content == null
                    ? const SizedBox.shrink()
                    : Row(
                        children: [
                          Flexible(
                            child: HashtagText(
                              content: feed.content.toString(),
                              trimLines: 4,
                              currentDoctorModel: currentDoctorModel,
                              homeDataModel: homeDataModel,
                              highlightWord: highlightWord,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),

          //! Poll UI (if poll exists)
          viewPollWidget ??
              BlocBuilder<CommunityCubit, CommunityState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const SizedBox.shrink();
                    },
                    loaded: (
                      feedsResponse,
                      isDeletePostLoading,
                      isDeletePostLoaded,
                      message,
                      isSeeMore,
                      changeCounter,
                    ) {
                      final poll = feed
                          .poll; // Store poll in a variable to avoid multiple null checks

                      if (poll != null) {
                        // Ensure initial values are set in postSelectedOptions
                        if (poll.allowMultipleChoice == true &&
                            !cubit.postSelectedOptions.containsKey(feed.id)) {
                          cubit.postSelectedOptions[feed.id!] = {
                            ...poll.options
                                    ?.where((option) => option.isVoted ?? false)
                                    .map((option) => option.id!)
                                    .toSet() ??
                                {}
                          };
                        }

                        // Ensure initial value for single-choice poll
                        if (poll.allowMultipleChoice == false &&
                            !cubit.postSelectedOption.containsKey(feed.id)) {
                          cubit.postSelectedOption[feed.id!] = poll.options
                              ?.firstWhere((option) => option.isVoted ?? false,
                                  orElse: () =>
                                      const PollOptionsModelResponse(id: -1))
                              .id;
                        }
                      }

                      return ViewPollWidget(
                        poll: poll,
                        currentDoctorModel: currentDoctorModel,
                        homeDataModel: homeDataModel,
                        selectedOptions:
                            cubit.postSelectedOptions[feed.id] ?? {},
                        initiallyExpanded: false,
                        selectedOption: cubit.postSelectedOption[feed.id],
                        onAddOption: (pollId, option) async {
                          await cubit.addOptionOnPoll(
                              pollId, option); // Call your function here
                        },
                        onOptionSelected: (optionId) {
                          cubit.postSelectedOption[feed.id!] = optionId;
                          cubit.addVoteAndUnVote(
                            poll!.id.toString(),
                            optionId!,
                          );
                          cubit.refreshScreen();
                        },
                        onOptionToggled: (optionId, isSelected) {
                          cubit.postSelectedOptions[feed.id!] ??= {};
                          cubit.addVoteAndUnVote(
                            poll!.id.toString(),
                            optionId,
                          );
                          if (isSelected) {
                            cubit.postSelectedOptions[feed.id!]!.add(optionId);
                          } else {
                            cubit.postSelectedOptions[feed.id!]!
                                .remove(optionId);
                          }
                          cubit.refreshScreen();
                        },
                      );
                    },
                  );
                },
              ),

          ImagesInPostCard(
              feed: feed,
              homeDataModel: homeDataModel,
              currentDoctorModel: currentDoctorModel),

          InkWell(
            onTap: () {
              navigatorKey.currentState?.pushNamed(
                AppRoutes.showSingleFeed,
                arguments: AppRoutesArgs.showSingleFeedRouteArgs(
                  homeDataModel: homeDataModel,
                  currentDoctorModel: currentDoctorModel,
                  feed: feed,
                ),
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (isGroupPosts || isCommunitySearch) {
                            onLikeAndUnlikeAdditional!();
                          } else {
                            cubit.addLikeOrUnlikeOnPost(feed.id.toString());
                          }
                        },
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: feed.isLiked == true
                                  ? Colors.red.shade600
                                  : Colors.grey.shade400,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              feed.likesCount.toString(),
                              style: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.showSingleFeed,
                            arguments: AppRoutesArgs.showSingleFeedRouteArgs(
                              homeDataModel: homeDataModel,
                              currentDoctorModel: currentDoctorModel,
                              feed: feed,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.comment,
                              color: Colors.grey.shade400,
                              size: 23,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              feed.commentsCount.toString(),
                              style: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      if (isGroupPosts || isCommunitySearch) {
                        onSaveAndUnSaveAdditional!();
                      } else {
                        cubit.addSaveOrUnsaveOnPost(feed.id.toString());
                      }
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        Icon(
                          feed.isSaved == true
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                          color: feed.isSaved == true
                              ? Colors.amber
                              : Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
