import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/show_single_feed/presentation/widgets/comment_exit_animator.dart';
import 'package:egy_akin/features/show_single_feed/presentation/widgets/delete_feed_comment_dialog.dart';
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

  bool _isArabic(String text) {
    if (text.isEmpty) return false;
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text.trim());
  }

  TextDirection _getTextDirection(String text) {
    return _isArabic(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  void _openDoctorProfile(BuildContext context) {
    final doctor = commentModel.doctor;
    if (doctor?.id == null) return;

    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctor!.id.toString(),
        currentDoctorModel: currentDoctorModel,
        isSyndicateCardRequired:
            homeDataModel.isSyndicateCardRequired.toString(),
        accountVerification: homeDataModel.verified!,
        currentDoctorRole: homeDataModel.role.toString(),
        currentDoctorPoints: int.parse(homeDataModel.scoreValue!),
        homeDataModel: homeDataModel,
        initialIndex: 0,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  Future<void> _onLike(BuildContext context, ShowSingleFeedCubit cubit) async {
    final hasPermission =
        await PermissionHelper.hasPermission(AppPermissions.likeFeedComment);
    if (!hasPermission) {
      if (!context.mounted) return;
      showCustomDialog(
        context: context,
        title: context.tr(AppStrings.attention),
        description:
            context.tr(AppStrings.youDontHavePermissionToLikeFeedComments),
        coloredButtonText: context.tr(AppStrings.ok),
        coloredButtonOnTap: () => Navigator.of(context).pop(),
        isNoColorShow: false,
      );
      return;
    }

    if (isMainComment) {
      cubit.addLikeOrUnlikeOnCommentInCommunity(
        commentId: commentModel.id.toString(),
      );
    } else {
      cubit.addLikeOrUnlikeOnReplyInCommunity(
        commentId: commentModel.id.toString(),
      );
    }
  }

  Future<void> _onReply(BuildContext context, ShowSingleFeedCubit cubit) async {
    final hasPermission =
        await PermissionHelper.hasPermission(AppPermissions.replyFeedComment);
    if (!hasPermission) {
      if (!context.mounted) return;
      showCustomDialog(
        context: context,
        title: context.tr(AppStrings.attention),
        description:
            context.tr(AppStrings.youDontHavePermissionToReplyOnFeeds),
        coloredButtonText: context.tr(AppStrings.ok),
        coloredButtonOnTap: () => Navigator.of(context).pop(),
        isNoColorShow: false,
      );
      return;
    }

    if (!context.mounted) return;
    await cubit.beginReplyTo(commentModel);
  }

  Future<void> _onDelete(
    BuildContext context,
    ShowSingleFeedCubit cubit,
  ) async {
    final hasPermission =
        await PermissionHelper.hasPermission(AppPermissions.deleteFeedComment);
    if (!hasPermission) {
      if (!context.mounted) return;
      showCustomDialog(
        context: context,
        title: context.tr(AppStrings.attention),
        description:
            context.tr(AppStrings.youDontHavePermissionToDeleteFeedComments),
        coloredButtonText: context.tr(AppStrings.ok),
        coloredButtonOnTap: () => Navigator.of(context).pop(),
        isNoColorShow: false,
      );
      return;
    }

    if (!context.mounted) return;
    await showDeleteFeedCommentDialog(
      context: context,
      onConfirm: () {
        if (isMainComment) {
          cubit.deleteCommentOnPostInCommunity(
            commentModel.id.toString(),
            updatedFeed,
            index,
            homeDataModel,
            currentDoctorModel,
          );
        }
      },
    );
  }

  bool _canManage(ShowSingleFeedCubit cubit) {
    return homeDataModel.role == AppStrings.roleAdmin ||
        (commentModel.doctor != null &&
            currentDoctorModel.id.toString() ==
                commentModel.doctor!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final cubit = ShowSingleFeedCubit.get(context);

        return BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
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
                final isHighlighted =
                    commentModel.id.toString() == highlightedCommentId;
                final isOwn = commentModel.doctor != null &&
                    currentDoctorModel.id.toString() ==
                        commentModel.doctor!.id.toString();
                final name = commentModel.doctor == null
                    ? ''
                    : doctorName(
                        firstName: commentModel.doctor!.firstName,
                        lastName: commentModel.doctor!.lastName,
                        role: commentModel.doctor!.isSyndicateCardRequired
                            .toString(),
                      );
                final isVerified = commentModel.doctor
                        ?.isSyndicateCardRequired ==
                    'Verified';
                final commentText = commentModel.comment ?? '';
                final replies = commentModel.replies ?? [];
                final deleting = isDeleteCommentLoading &&
                    commentModel.id.toString() == cubit.deleteCommentId;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.easeOutCubic,
                  decoration: BoxDecoration(
                    color: isHighlighted
                        ? primary.withOpacity(isDark ? 0.18 : 0.1)
                        : HomeDashboardColors.cardBg(isDark),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isHighlighted
                          ? primary.withOpacity(0.45)
                          : HomeDashboardColors.border(isDark)
                              .withOpacity(0.7),
                      width: isHighlighted ? 1.4 : 1,
                    ),
                    boxShadow: isDark
                        ? (isHighlighted
                            ? [
                                BoxShadow(
                                  color: primary.withOpacity(0.22),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null)
                        : [
                            BoxShadow(
                              color: isHighlighted
                                  ? primary.withOpacity(0.14)
                                  : Colors.black.withOpacity(0.03),
                              blurRadius: isHighlighted ? 16 : 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 12.h, 10.w, 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KeyedSubtree(
                          key: cubit
                              .keyForComment(commentModel.id.toString()),
                          child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => _openDoctorProfile(context),
                              child: _CommentAvatar(
                                doctor: commentModel.doctor,
                                primary: primary,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12.5.sp,
                                                  fontWeight: FontWeight.w800,
                                                  color: isOwn
                                                      ? HomeDashboardColors
                                                          .success
                                                      : HomeDashboardColors
                                                          .title(isDark),
                                                ),
                                              ),
                                            ),
                                            if (isVerified)
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 4),
                                                child: VerificationIcon(
                                                  duration: 300,
                                                  isSmaller: true,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        TimeAgoService.instance
                                            .formatTimeAgoFromString(
                                          commentModel.createdAt.toString(),
                                          context,
                                        ),
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: HomeDashboardColors.subtitle(
                                              isDark),
                                        ),
                                      ),
                                      if (_canManage(cubit))
                                        deleting
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    left: 6.w),
                                                child: SizedBox(
                                                  width: 14,
                                                  height: 14,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 1.5,
                                                    color: primary,
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                width: 28,
                                                height: 28,
                                                child: PopupMenuButton<String>(
                                                  padding: EdgeInsets.zero,
                                                  iconSize: 18.sp,
                                                  icon: Icon(
                                                    Icons.more_horiz_rounded,
                                                    color: HomeDashboardColors
                                                        .subtitle(isDark),
                                                  ),
                                                  onSelected: (value) {
                                                    if (value == 'Delete') {
                                                      _onDelete(
                                                          context, cubit);
                                                    }
                                                  },
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      value: 'Delete',
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .delete_outline_rounded,
                                                            size: 18.sp,
                                                            color:
                                                                HomeDashboardColors
                                                                    .danger,
                                                          ),
                                                          SizedBox(width: 8.w),
                                                          Text(
                                                            context.tr(
                                                                AppStrings
                                                                    .delete),
                                                            style: TextStyle(
                                                              color:
                                                                  HomeDashboardColors
                                                                      .danger,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 10.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: HomeDashboardColors.surfaceBg(
                                          isDark),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Text(
                                      commentText,
                                      textDirection:
                                          _getTextDirection(commentText),
                                      textAlign: _isArabic(commentText)
                                          ? TextAlign.right
                                          : TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 1.45,
                                        fontFamily: 'Tajawal',
                                        color:
                                            HomeDashboardColors.title(isDark),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      _CommentActionChip(
                                        isDark: isDark,
                                        primary: primary,
                                        active: commentModel.isLiked == true,
                                        activeColor: const Color(0xFFE11D48),
                                        icon: commentModel.isLiked == true
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                        label:
                                            '${commentModel.likesCount ?? 0}',
                                        onTap: () => _onLike(context, cubit),
                                      ),
                                      if (isMainComment) ...[
                                        SizedBox(width: 8.w),
                                        _CommentActionChip(
                                          isDark: isDark,
                                          primary: primary,
                                          active: false,
                                          icon: Icons.reply_rounded,
                                          label: context.tr(AppStrings.reply),
                                          onTap: () =>
                                              _onReply(context, cubit),
                                        ),
                                      ],
                                      if (replies.isNotEmpty) ...[
                                        const Spacer(),
                                        Text(
                                          '${replies.length} ${replies.length == 1 ? 'reply' : 'replies'}',
                                          style: TextStyle(
                                            fontSize: 10.5.sp,
                                            fontWeight: FontWeight.w600,
                                            color: HomeDashboardColors.subtitle(
                                                isDark),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ),
                        if (isMainComment &&
                            commentModel.parentId == null &&
                            replies.isNotEmpty) ...[
                          SizedBox(height: 10.h),
                          Container(
                            margin: EdgeInsets.only(left: 18.w),
                            padding: EdgeInsets.only(left: 12.w),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: primary.withOpacity(0.28),
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Column(
                              children: List.generate(
                                replies.length,
                                (replyIndex) {
                                  final reply = replies[replyIndex];
                                  final replyId = reply.id.toString();
                                  return CommentExitAnimator(
                                    key: ValueKey('reply-exit-$replyId'),
                                    exiting: cubit.isItemExiting(replyId),
                                    onExited: () =>
                                        cubit.finalizeExitingItem(replyId),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: replyIndex ==
                                                replies.length - 1
                                            ? 0
                                            : 8.h,
                                      ),
                                      child: KeyedSubtree(
                                        key: cubit.keyForComment(replyId),
                                        child: ReplyWidgetInCommunity(
                                          replyModel: reply,
                                          homeDataModel: homeDataModel,
                                          currentDoctorModel:
                                              currentDoctorModel,
                                          commentModel: commentModel,
                                          replyIndex: replyIndex,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
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

class _CommentAvatar extends StatelessWidget {
  final DoctorModel? doctor;
  final Color primary;

  const _CommentAvatar({
    required this.doctor,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.r,
      height: 36.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: primary.withOpacity(0.25), width: 1.2),
      ),
      child: ClipOval(
        child: doctor == null
            ? ColoredBox(
                color: primary.withOpacity(0.15),
                child: Icon(Icons.person, size: 18.sp, color: primary),
              )
            : doctor!.id == null
                ? ColoredBox(
                    color: primary.withOpacity(0.15),
                    child: Center(
                      child: Text(
                        (doctor!.firstName ?? 'D')[0].toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                          color: primary,
                        ),
                      ),
                    ),
                  )
                : CustomCachedNetworkImage(
                    imageUrl: doctor!.image.toString(),
                    height: 36.r,
                    width: 36.r,
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }
}

class _CommentActionChip extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool active;
  final Color? activeColor;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CommentActionChip({
    required this.isDark,
    required this.primary,
    required this.active,
    required this.icon,
    required this.label,
    required this.onTap,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final accent = activeColor ?? primary;
    final fg = active ? accent : HomeDashboardColors.subtitle(isDark);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: active
                ? accent.withOpacity(isDark ? 0.18 : 0.1)
                : HomeDashboardColors.surfaceBg(isDark),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: active
                  ? accent.withOpacity(0.28)
                  : HomeDashboardColors.border(isDark).withOpacity(0.6),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14.sp, color: fg),
              SizedBox(width: 4.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
