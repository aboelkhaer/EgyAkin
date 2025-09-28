import 'package:egy_akin/exports.dart';
import 'dart:ui' as ui;
import '../../../../app/services/theme_bloc.dart';

class ReplyWidgetInCommunity extends StatelessWidget {
  final CommentModelInCommunity replyModel;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final CommentModelInCommunity commentModel;
  final int replyIndex;
  const ReplyWidgetInCommunity(
      {super.key,
      required this.replyModel,
      required this.homeDataModel,
      required this.currentDoctorModel,
      required this.commentModel,
      required this.replyIndex});

  // Helper function to detect if text is Arabic
  bool _isArabic(String text) {
    if (text.isEmpty) return false;
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text.trim());
  }

  // Helper function to get text direction
  TextDirection _getTextDirection(String text) {
    return _isArabic(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  @override
  Widget build(BuildContext context) {
    ShowSingleFeedCubit cubit = ShowSingleFeedCubit.get(context);
    // Initialize key if absent
    cubit.listKeyForReplies.putIfAbsent(
      commentModel.id!,
      () => GlobalKey<AnimatedListState>(),
    );

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
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
                  key: cubit.listKeyForReplies[replyModel.id],

                  decoration: BoxDecoration(
                    color: replyModel.id.toString() == highlightedCommentId
                        ? isDarkMode
                            ? Colors.grey.shade900
                            : Colors.grey.shade300
                        : Colors
                            .transparent, // Ensure a clear start and end color
                    borderRadius: BorderRadius.circular(
                        8), // Add subtle rounding for effect
                  ),
                  duration: const Duration(
                      milliseconds:
                          100), // Shorter duration for smoother transition
                  curve: Curves.easeOut, // Add easing for smoother animation
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
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
                                    doctorId: replyModel.doctor!.id.toString(),
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
                                    child: replyModel.doctor == null
                                        ? const SizedBox.shrink()
                                        : replyModel.doctor!.id == null
                                            ? Text(
                                                replyModel.doctor!.firstName![0]
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.sp),
                                              )
                                            : CustomCachedNetworkImage(
                                                imageUrl: replyModel
                                                    .doctor!.image
                                                    .toString(),
                                                height: 100.h,
                                                width: 100.w,
                                              ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox.shrink(),
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
                                    width: 160.w,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            replyModel.doctor == null
                                                ? ''
                                                : doctorName(
                                                    firstName: replyModel
                                                        .doctor!.firstName,
                                                    lastName: replyModel
                                                        .doctor!.lastName,
                                                    role: replyModel.doctor!
                                                        .isSyndicateCardRequired
                                                        .toString(),
                                                  ),
                                            style: TextStyle(
                                              color: replyModel.doctor == null
                                                  ? Colors.grey.shade700
                                                  : currentDoctorModel.id
                                                              .toString() ==
                                                          replyModel.doctor!.id
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
                                        if (replyModel.doctor != null &&
                                            replyModel.doctor!
                                                    .isSyndicateCardRequired ==
                                                'Verified')
                                          if (replyModel.doctor != null &&
                                              replyModel.doctor!
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
                                    TimeAgoService.instance
                                        .formatTimeAgoFromString(
                                            replyModel.createdAt.toString(),
                                            context),
                                    style: TextStyle(
                                      color: AppColors.description,
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                replyModel.comment ?? '',
                                style: const TextStyle(
                                  color: ui.Color.fromRGBO(117, 117, 117, 1),
                                  fontWeight: FontWeight.w400,
                                ),
                                textDirection:
                                    _getTextDirection(replyModel.comment ?? ''),
                                textAlign: _isArabic(replyModel.comment ?? '')
                                    ? TextAlign.right
                                    : TextAlign.left,
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
                                              cubit
                                                  .addLikeOrUnlikeOnReplyInCommunity(
                                                      commentId: replyModel.id
                                                          .toString());
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              size: 16.r,
                                              color: replyModel.isLiked == true
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
                                    replyModel.likesCount.toString(),
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  TextButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      overlayColor: WidgetStateProperty.all(Colors
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
                                          updatedFeed,
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
                                                  (replyModel.doctor != null &&
                                                      currentDoctorModel.id
                                                              .toString() ==
                                                          replyModel.doctor!.id
                                                              .toString())
                                              ? (isDeleteCommentLoading &&
                                                      replyModel.id
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
                                                            debugPrint(
                                                                'Report clicked');
                                                            break;
                                                          case 'Delete':
                                                            // Handle delete action

                                                            showCustomDialog(
                                                              context: context,
                                                              title: context.tr(
                                                                  AppStrings
                                                                      .attention),
                                                              description: context
                                                                  .tr(AppStrings
                                                                      .areYouSureToDeleteComment),
                                                              coloredButtonText:
                                                                  context.tr(
                                                                      AppStrings
                                                                          .cancel),
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

                                                                cubit.deleteReplyOnComment(
                                                                    replyModel
                                                                        .id
                                                                        .toString(),
                                                                    commentModel,
                                                                    replyIndex,
                                                                    updatedFeed,
                                                                    commentsResponse,
                                                                    homeDataModel,
                                                                    currentDoctorModel);
                                                              },
                                                              noColoredButtonText:
                                                                  context.tr(
                                                                      AppStrings
                                                                          .delete),
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
                                                          //           Icons.report,
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

                                                        if (replyModel
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
                                                                    context.tr(
                                                                        AppStrings
                                                                            .delete),
                                                                  ),
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
        );
      },
    );
  }
}
