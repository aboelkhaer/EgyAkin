import 'dart:developer';
import 'dart:ui' as ui;
import 'package:egy_akin/features/show_single_feed/presentation/widgets/reply_widget_in_community.dart';
import '../../../../exports.dart';

class CommentWidgetInCommunity extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final CommentModelInCommunity commentModel;
  final GetCommentsInCommunityModelResponse commentsResponse;
  final int index;
  final bool isMainComment;
  final String? parentCommentId;
  final PostCommunityModel updatedFeed;

  const CommentWidgetInCommunity({
    super.key,
    required this.commentModel,
    required this.homeDataModel,
    required this.currentDoctorModel,
    this.isMainComment = true,
    required this.commentsResponse,
    required this.index,
    required this.updatedFeed,
    this.parentCommentId,
  });

  @override
  Widget build(BuildContext context) {
    ShowSingleFeedCubit cubit = ShowSingleFeedCubit.get(context);
    return Column(
      children: [
        BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox.shrink();
              },
              loaded: (
                commentsResponse,
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
                isSeeMore,
              ) {
                return AnimatedContainer(
                  decoration: BoxDecoration(
                    color: commentModel.id.toString() == highlightedCommentId
                        ? Colors.grey.shade300
                        : Colors
                            .transparent, // Ensure a clear start and end color
                    borderRadius: BorderRadius.circular(
                        8), // Add subtle rounding for effect
                  ),
                  duration: const Duration(
                      milliseconds:
                          300), // Shorter duration for smoother transition
                  curve: Curves.easeInOut, // Add easing for smoother animation
                  padding: EdgeInsets.symmetric(
                    horizontal: isMainComment ? 20 : 0,
                    vertical: 10,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.doctorInfoView,
                                  arguments:
                                      AppRoutesArgs.doctorInfoViewRouteArgs(
                                    doctorId:
                                        commentModel.doctor!.id.toString(),
                                    currentDoctorModel: currentDoctorModel,
                                    isSyndicateCardRequired: homeDataModel
                                        .isSyndicateCardRequired
                                        .toString(),
                                    accountVerification:
                                        homeDataModel.verified!,
                                    currentDoctorRole:
                                        homeDataModel.role.toString(),
                                    currentDoctorPoints:
                                        int.parse(homeDataModel.scoreValue!),
                                    homeDataModel: homeDataModel,
                                    initialIndex: 0,
                                    isNavigateToTheButtonOfInformationTab:
                                        false,
                                  ),
                                );
                              },
                              child: Container(
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
                                  child: CircleAvatar(
                                    radius: 15.r,
                                    backgroundColor:
                                        AppColors.primary.withOpacity(0.8),
                                    child: commentModel.doctor == null
                                        ? const SizedBox.shrink()
                                        : commentModel.doctor!.id == null
                                            ? Text(
                                                commentModel
                                                    .doctor!.firstName![0]
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.sp),
                                              )
                                            : CustomCachedNetworkImage(
                                                imageUrl: commentModel
                                                    .doctor!.image
                                                    .toString(),
                                                height: 100.h,
                                                width: 100.w,
                                              ),
                                  ),
                                ),
                              ),
                            ),
                            isMainComment
                                ? Expanded(
                                    child: Container(
                                      width: 1.5,
                                      color:
                                          Colors.grey.shade300, // Divider color
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: isMainComment ? 190.w : 160.w,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            commentModel.doctor == null
                                                ? ''
                                                : doctorName(
                                                    firstName: commentModel
                                                        .doctor!.firstName,
                                                    lastName: commentModel
                                                        .doctor!.lastName,
                                                    role: commentModel.doctor!
                                                        .isSyndicateCardRequired
                                                        .toString(),
                                                  ),
                                            style: TextStyle(
                                              color: commentModel.doctor == null
                                                  ? Colors.grey.shade700
                                                  : currentDoctorModel.id
                                                              .toString() ==
                                                          commentModel
                                                              .doctor!.id
                                                              .toString()
                                                      ? Colors.green
                                                      : Colors.grey.shade700,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        if (commentModel.doctor != null &&
                                            commentModel.doctor!
                                                    .isSyndicateCardRequired ==
                                                'Verified')
                                          if (commentModel.doctor != null &&
                                              commentModel.doctor!
                                                      .isSyndicateCardRequired ==
                                                  'Verified')
                                            const VerificationIcon(
                                              duration: 300,
                                              isSmaller: true,
                                            ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    TimeAgoService.instance.formatTimeAgoFromString(
                                        commentModel.createdAt.toString(),
                                        context),
                                    style: TextStyle(
                                      color: AppColors.description,
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    isArabic(commentModel.comment ?? '')
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                children: [
                                  Text(
                                    commentModel.comment ?? '',
                                    style: const TextStyle(
                                      color:
                                          ui.Color.fromRGBO(117, 117, 117, 1),
                                      // fontWeight: FontWeight.w400,
                                      fontFamily: 'Tajawal',
                                      fontWeight: FontWeight.w500,
                                      height: 1.6,
                                    ),
                                    textDirection: RegExp(r'[\u0600-\u06FF]')
                                            .hasMatch(
                                                commentModel.comment.toString())
                                        ? ui.TextDirection.rtl
                                        : ui.TextDirection.ltr,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  BlocBuilder<ShowSingleFeedCubit,
                                      ShowSingleFeedState>(
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                        orElse: () {
                                          return const SizedBox.shrink();
                                        },
                                        loaded: (
                                          commentsResponse,
                                          changeCounter,
                                          updatedFeed2,
                                          isSendCommentLoading,
                                          isSendCommentLoaded,
                                          message,
                                          highlightedCommentId,
                                          isDeleteCommentLoading,
                                          isDeleteCommentLoaded,
                                          isSendReplyLoading,
                                          isSendReplyLoaded,
                                          isSeeMore,
                                        ) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (isMainComment) {
                                                cubit
                                                    .addLikeOrUnlikeOnCommentInCommunity(
                                                        commentId: commentModel
                                                            .id
                                                            .toString());
                                              } else {
                                                cubit
                                                    .addLikeOrUnlikeOnReplyInCommunity(
                                                        commentId: commentModel
                                                            .id
                                                            .toString());
                                                // cubit
                                                //     .addLikeOrUnlikeOnReplyInCommunity(
                                                //         commentId: commentModel
                                                //             .id
                                                //             .toString());
                                              }
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              size: 16.r,
                                              color:
                                                  commentModel.isLiked == true
                                                      ? Colors.red.shade600
                                                      : Colors.grey.shade400,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    commentModel.likesCount.toString(),
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  isMainComment
                                      ? TextButton(
                                          onPressed: () {
                                            cubit.commentToReply = commentModel;
                                            cubit.refreshScreen();
                                          },
                                          child: const Text('Reply'),
                                        )
                                      : TextButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                            overlayColor:
                                                WidgetStateProperty.all(Colors
                                                    .transparent), // Remove feedback color
                                            splashFactory: NoSplash
                                                .splashFactory, // Remove ripple effect
                                          ),
                                          child: const Text(''),
                                        ),
                                  const Spacer(),
                                  BlocBuilder<ShowSingleFeedCubit,
                                      ShowSingleFeedState>(
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                        orElse: () {
                                          return const SizedBox.shrink();
                                        },
                                        loaded: (
                                          commentsResponse,
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
                                          isSeeMore,
                                        ) {
                                          return homeDataModel.role ==
                                                      AppStrings.roleAdmin ||
                                                  (commentModel.doctor !=
                                                          null &&
                                                      currentDoctorModel.id
                                                              .toString() ==
                                                          commentModel
                                                              .doctor!.id
                                                              .toString())
                                              ? (isDeleteCommentLoading &&
                                                      commentModel.id
                                                              .toString() ==
                                                          cubit.deleteCommentId)
                                                  ? IconButton(
                                                      highlightColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      splashColor:
                                                          Colors.transparent,
                                                      onPressed: () {},
                                                      icon: const SizedBox(
                                                        width: 15,
                                                        height: 15,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 1,
                                                        ),
                                                      ))
                                                  // : IconButton(
                                                  //     onPressed: () {
                                                  //       showCustomDialog(
                                                  //         context: context,
                                                  //         title: 'Attention',
                                                  //         description:
                                                  //             'Are you sure to delete comment?',
                                                  //         coloredButtonText:
                                                  //             'Cancel',
                                                  //         coloredButtonOnTap:
                                                  //             () {
                                                  //           Navigator.pop(
                                                  //               context);
                                                  //         },
                                                  //         isNoColorShow: true,
                                                  //         noColoredButtonOnTap:
                                                  //             () {
                                                  //           Navigator.pop(
                                                  //               context);
                                                  //           cubit
                                                  //               .deleteCommentOnPostInCommunity(
                                                  //             commentModel.id
                                                  //                 .toString(),
                                                  //             updatedFeed,
                                                  //             index,
                                                  //             homeDataModel,
                                                  //             currentDoctorModel,
                                                  //           );
                                                  //         },
                                                  //         noColoredButtonText:
                                                  //             'Delete',
                                                  //       );
                                                  //     },
                                                  //     icon: Icon(
                                                  //       Icons.delete,
                                                  //       color: Colors.red
                                                  //           .withOpacity(0.5),
                                                  //     ),
                                                  //   )
                                                  : PopupMenuButton<String>(
                                                      icon: Icon(
                                                        Icons.more_vert,
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                      onSelected:
                                                          (String value) {
                                                        switch (value) {
                                                          case 'Report':
                                                            // Handle report action
                                                            print(
                                                                'Report clicked');
                                                            break;
                                                          case 'Delete':
                                                            // Handle delete action

                                                            showCustomDialog(
                                                              context: context,
                                                              title:
                                                                  context.tr(AppStrings.attention),
                                                              description:
                                                                  context.tr(AppStrings.areYouSureToDeleteComment),
                                                              coloredButtonText:
                                                                  context.tr(AppStrings.cancel),
                                                              coloredButtonOnTap:
                                                                  () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              isNoColorShow:
                                                                  true,
                                                              noColoredButtonOnTap:
                                                                  () {
                                                                Navigator.pop(
                                                                    context);

                                                                if (isMainComment) {
                                                                  cubit
                                                                      .deleteCommentOnPostInCommunity(
                                                                    commentModel
                                                                        .id
                                                                        .toString(),
                                                                    updatedFeed,
                                                                    index,
                                                                    homeDataModel,
                                                                    currentDoctorModel,
                                                                  );
                                                                }
                                                              },
                                                              noColoredButtonText:
                                                                  context.tr(AppStrings.delete),

                                                            );
                                                            break;
                                                        }
                                                      },
                                                      itemBuilder: (BuildContext
                                                          context) {
                                                        final items =
                                                            <PopupMenuEntry<
                                                                String>>[
                                                          // PopupMenuItem(
                                                          //   value: 'Report',
                                                          //   child: Row(
                                                          //     children: [
                                                          //       const Icon(
                                                          //           Icons
                                                          //               .report,
                                                          //           color: AppColors
                                                          //               .description),
                                                          //       SizedBox(
                                                          //           width: 8.w),
                                                          //       const Text(
                                                          //           'Report'),
                                                          //     ],
                                                          //   ),
                                                          // ),
                                                        ];

                                                        if (commentModel
                                                                    .doctor!.id
                                                                    .toString() ==
                                                                currentDoctorModel
                                                                    .id
                                                                    .toString() ||
                                                            homeDataModel
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
                                                                      width:
                                                                          8.w),
                                                                   Text(
                                                                      context.tr(AppStrings.delete),),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }

                                                        return items;
                                                      },
                                                    )
                                              : const SizedBox.shrink();
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              commentModel.parentId != null
                                  ? const SizedBox.shrink()
                                  : commentModel.replies!.isEmpty
                                      ? const SizedBox.shrink()
                                      : Column(
                                          children: [
                                            ...List.generate(
                                              commentModel.replies!.length,
                                              (replyIndex) {
                                                var replyModel = commentModel
                                                    .replies![replyIndex];
                                                return ReplyWidgetInCommunity(
                                                  replyModel: replyModel,
                                                  homeDataModel: homeDataModel,
                                                  currentDoctorModel:
                                                      currentDoctorModel,
                                                  commentModel: commentModel,
                                                  replyIndex: replyIndex,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        // const SizedBox(height: 5),
        isMainComment
            ? commentsResponse.data!.data!.length - 1 != index
                ? const Divider(thickness: 0.4)
                : const SizedBox.shrink()
            : const SizedBox.shrink(),
        // const SizedBox(height: 20),
      ],
    );
  }
}
