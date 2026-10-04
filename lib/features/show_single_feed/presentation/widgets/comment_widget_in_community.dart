import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/functions/chat_text_direction.dart';
import 'package:egy_akin/app/shared/widgets/doctor_circle_avatar.dart';
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

  int? get _authorDoctorId => commentModel.doctor?.id ?? commentModel.doctorId;

  int? get _myDoctorId {
    if (currentDoctorModel.id != null) return currentDoctorModel.id;
    try {
      return resolveHomeCubit().currentDoctorModel.id;
    } catch (_) {
      return null;
    }
  }

  bool _isOwnAuthor() {
    final myId = _myDoctorId;
    final authorId = _authorDoctorId;
    return myId != null && authorId != null && myId == authorId;
  }

  void _openDoctorProfile(BuildContext context) {
    final doctorId = _authorDoctorId;
    if (doctorId == null) return;

    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctorId.toString(),
        currentDoctorModel: currentDoctorModel,
        isSyndicateCardRequired:
            homeDataModel.isSyndicateCardRequired?.toString() ?? '',
        accountVerification: homeDataModel.verified ?? false,
        currentDoctorRole: homeDataModel.role?.toString() ?? '',
        currentDoctorPoints: int.tryParse(homeDataModel.scoreValue ?? '') ?? 0,
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
        description: context.tr(AppStrings.youDontHavePermissionToReplyOnFeeds),
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

  bool _canManage() {
    return homeDataModel.role == AppStrings.roleAdmin || _isOwnAuthor();
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
                final isOwn = _isOwnAuthor();
                final displayDoctor = resolveDoctorForAvatar(
                      commentModel.doctor ??
                          (isOwn ? currentDoctorModel : null),
                    ) ??
                    commentModel.doctor ??
                    (isOwn ? currentDoctorModel : null);
                final name = doctorDisplayName(
                  displayDoctor,
                  fallback: isOwn ? doctorDisplayName(currentDoctorModel) : '',
                );
                final isVerified = doctorIsVerified(displayDoctor);
                final commentText = commentModel.comment ?? '';
                final replies = commentModel.replies ?? [];
                final deleting = isDeleteCommentLoading &&
                    commentModel.id.toString() == cubit.deleteCommentId;

                    return AnimatedContainer(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                      decoration: BoxDecoration(
                    color: isHighlighted
                        ? primary.withOpacity(isDark ? 0.14 : 0.08)
                        : HomeDashboardColors.cardBg(isDark),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isHighlighted
                          ? primary.withOpacity(0.35)
                          : HomeDashboardColors.border(isDark).withOpacity(0.7),
                      width: isHighlighted ? 1.2 : 1,
                    ),
                    boxShadow: isDark
                        ? null
                        : [
                                        BoxShadow(
                              color: isHighlighted
                                  ? primary.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.03),
                              blurRadius: isHighlighted ? 12 : 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KeyedSubtree(
                          key: cubit.keyForComment(commentModel.id.toString()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Avatar + name centered on one row.
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => _openDoctorProfile(context),
                                    child: DoctorCircleAvatar(
                                      doctor: displayDoctor ??
                                          commentModel.doctor,
                                      primary: primary,
                                      size: 36.r,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () =>
                                                _openDoctorProfile(context),
                                            child: Text(
                                              name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.5.sp,
                                                fontWeight: FontWeight.w800,
                                                height: 1.1,
                                                color: isOwn
                                                    ? HomeDashboardColors
                                                        .success
                                                    : HomeDashboardColors
                                                        .title(isDark),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (isVerified)
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .only(start: 4.w),
                                            child: const VerificationIcon(
                                              duration: 300,
                                              isSmaller: true,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (_canManage())
                                    deleting
                                        ? Padding(
                                            padding: EdgeInsetsDirectional
                                                .only(start: 6.w),
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
                                        : PopupMenuButton<String>(
                                            padding: EdgeInsets.zero,
                                            constraints:
                                                const BoxConstraints(
                                              minWidth: 28,
                                              minHeight: 28,
                                            ),
                                            iconSize: 18.sp,
                                            icon: Icon(
                                              Icons.more_horiz_rounded,
                                              color: HomeDashboardColors
                                                  .subtitle(isDark),
                                            ),
                                            onSelected: (value) {
                                              if (value == 'Delete') {
                                                _onDelete(context, cubit);
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
                                                          AppStrings.delete),
                                                      style: const TextStyle(
                                                        color:
                                                            HomeDashboardColors
                                                                .danger,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              // Content indented under the name column.
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 36.r + 10.w,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: HomeDashboardColors.surfaceBg(
                                            isDark),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      alignment: ChatTextDirection.resolve(
                                                commentText,
                                              ) ==
                                              TextDirection.rtl
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: HashtagText(
                                        content: commentText,
                                        currentDoctorModel:
                                            currentDoctorModel,
                                        homeDataModel: homeDataModel,
                                        disableTrimLines: true,
                                        showLinkPreviews: false,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          height: 1.45,
                                          fontFamily: 'Tajawal',
                                          color: HomeDashboardColors.title(
                                              isDark),
                                        ),
                                        hashtagStyle: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700,
                                          height: 1.45,
                                          fontFamily: 'Tajawal',
                                          color: primary,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        _CommentActionChip(
                                          isDark: isDark,
                                          primary: primary,
                                          active:
                                              commentModel.isLiked == true,
                                          activeColor:
                                              const Color(0xFFE11D48),
                                          icon: commentModel.isLiked == true
                                              ? Icons.favorite_rounded
                                              : Icons
                                                  .favorite_border_rounded,
                                          label:
                                              '${commentModel.likesCount ?? 0}',
                                          onTap: () =>
                                              _onLike(context, cubit),
                                        ),
                                        if (isMainComment) ...[
                                          SizedBox(width: 8.w),
                                          _CommentActionChip(
                                            isDark: isDark,
                                            primary: primary,
                                            active: false,
                                            icon: Icons.reply_rounded,
                                            label: context
                                                .tr(AppStrings.reply),
                                            onTap: () =>
                                                _onReply(context, cubit),
                                          ),
                                        ],
                                        if (replies.isNotEmpty) ...[
                                          SizedBox(width: 8.w),
                                          Text(
                                            replies.length == 1
                                                ? context.tr(
                                                    AppStrings.oneReplyCount,
                                                  )
                                                : context
                                                    .tr(
                                                      AppStrings
                                                          .repliesCountLabel,
                                                    )
                                                    .replaceAll(
                                                      '{count}',
                                                      '${replies.length}',
                                                    ),
                                            style: TextStyle(
                                              fontSize: 10.5.sp,
                                              fontWeight: FontWeight.w600,
                                              color: HomeDashboardColors
                                                  .subtitle(isDark),
                                            ),
                                          ),
                                        ],
                                        const Spacer(),
                                        Text(
                                          TimeAgoService.instance
                                              .formatTimeAgoFromString(
                                            commentModel.createdAt
                                                .toString(),
                                            context,
                                          ),
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: HomeDashboardColors
                                                .subtitle(isDark),
                                          ),
                                        ),
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
                            margin: EdgeInsetsDirectional.only(start: 18.w),
                            padding: EdgeInsetsDirectional.only(start: 12.w),
                            decoration: BoxDecoration(
                              border: BorderDirectional(
                                start: BorderSide(
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
                                        bottom: replyIndex == replies.length - 1
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
