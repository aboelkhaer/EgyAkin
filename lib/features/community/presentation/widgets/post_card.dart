import 'package:egy_akin/app/shared/functions/hint_dialog.dart';
import 'package:egy_akin/app/shared/widgets/hash_tag_text.dart';
import 'package:egy_akin/features/community/presentation/cubit/community_state.dart';

import '../../../../exports.dart';

class PostCard extends StatelessWidget {
  final PostCommunityModel feed;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  const PostCard({
    super.key,
    required this.feed,
    required this.homeDataModel,
    required this.currentDoctorModel,
  });

  @override
  Widget build(BuildContext context) {
    CommunityCubit cubit = CommunityCubit.get(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      // padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
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
                                              role: '',
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
                                    formatDateTimeForCommunity(
                                        feed.createdAt.toString()),
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
                            BlocConsumer<CommunityCubit, CommunityState>(
                              listener: (context, state) {
                                state.maybeWhen(
                                  orElse: () {},
                                  error: (message) {
                                    showHintDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        message: message);
                                  },
                                  loaded: (feedsResponse, isDeletePostLoading,
                                      isDeletePostLoaded, message) {
                                    if (message != '') {
                                      customSnackBar(
                                          context: context, message: message);
                                    }
                                  },
                                );
                              },
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () {
                                    return const SizedBox.shrink();
                                  },
                                  loaded: (feedsResponse, isDeletePostLoading,
                                      isDeletePostLoaded, message) {
                                    if (isDeletePostLoading &&
                                        (feed.id.toString() ==
                                            cubit.postIdDeleted)) {
                                      return Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              splashColor: Colors.transparent,
                                              icon: const Icon(
                                                Icons.more_vert,
                                                color: Colors.transparent,
                                              )),
                                          const SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
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
                                              AppRoutes.createPostInCommunity,
                                              arguments: AppRoutesArgs
                                                  .createPostInCommunityRouteArgs(
                                                currentDoctorModel:
                                                    currentDoctorModel,
                                                homeDataModel: homeDataModel,
                                                feed: feed,
                                              ),
                                            );
                                            break;
                                          case 'Delete':
                                            // Handle delete action
                                            cubit
                                                .deletePost(feed.id.toString());
                                            break;
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        final items = <PopupMenuEntry<String>>[
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
                                        if (feed.doctor!.id.toString() ==
                                                currentDoctorModel.id
                                                    .toString() ||
                                            homeDataModel.role ==
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
                                                    color:
                                                        AppColors.description),
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
                Row(
                  children: [
                    Flexible(
                      child: HashtagText(
                        content: feed.content.toString(),
                        trimLines: 4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          feed.mediaPath == null
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    // navigatorKey.currentState?.push(
                    //   MaterialPageRoute(
                    //     builder: (context) => FullScreenImage(
                    //       imageUrl: feed.mediaPath.toString(),
                    //     ),
                    //   ),
                    // );
                    navigatorKey.currentState?.pushNamed(
                      AppRoutes.showSingleFeed,
                      arguments: AppRoutesArgs.showSingleFeedRouteArgs(
                        homeDataModel: homeDataModel,
                        currentDoctorModel: currentDoctorModel,
                        feed: feed,
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Hero(
                      tag: feed.id.toString(),
                      child: CustomCachedNetworkImage(
                        imageUrl: feed.mediaPath.toString(),
                        width: double.infinity,
                        height: 150.h,
                      ),
                    ),
                  ),
                ),
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
                          cubit.addLikeOrUnlikeOnPost(feed.id.toString());
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
                      cubit.addSaveOrUnsaveOnPost(feed.id.toString());
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
