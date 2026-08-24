import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/show_single_feed/presentation/widgets/delete_feed_comment_dialog.dart';

import '../../../../exports.dart';

class ReplyWidgetInCommunity extends StatelessWidget {
  final CommentModelInCommunity replyModel;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final CommentModelInCommunity commentModel;
  final int replyIndex;

  const ReplyWidgetInCommunity({
    super.key,
    required this.replyModel,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.commentModel,
    required this.replyIndex,
  });

  bool _isArabic(String text) {
    if (text.isEmpty) return false;
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text.trim());
  }

  TextDirection _getTextDirection(String text) {
    return _isArabic(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  void _openDoctorProfile() {
    final doctor = replyModel.doctor;
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

  bool _canManage() {
    return homeDataModel.role == AppStrings.roleAdmin ||
        (replyModel.doctor != null &&
            currentDoctorModel.id.toString() ==
                replyModel.doctor!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ShowSingleFeedCubit.get(context);
    cubit.listKeyForReplies.putIfAbsent(
      commentModel.id!,
      () => GlobalKey<AnimatedListState>(),
    );

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);

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
                    replyModel.id.toString() == highlightedCommentId;
                final isOwn = replyModel.doctor != null &&
                    currentDoctorModel.id.toString() ==
                        replyModel.doctor!.id.toString();
                final name = replyModel.doctor == null
                    ? ''
                    : doctorName(
                        firstName: replyModel.doctor!.firstName,
                        lastName: replyModel.doctor!.lastName,
                        role: replyModel.doctor!.isSyndicateCardRequired
                            .toString(),
                      );
                final isVerified =
                    replyModel.doctor?.isSyndicateCardRequired == 'Verified';
                final replyText = replyModel.comment ?? '';
                final deleting = isDeleteCommentLoading &&
                    replyModel.id.toString() == cubit.deleteCommentId;

                return AnimatedContainer(
                  key: cubit.listKeyForReplies[replyModel.id],
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 8.w, 8.h),
                  decoration: BoxDecoration(
                    color: isHighlighted
                        ? primary.withOpacity(isDark ? 0.16 : 0.1)
                        : (isDark
                            ? Colors.white.withOpacity(0.03)
                            : Colors.black.withOpacity(0.02)),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isHighlighted
                          ? primary.withOpacity(0.3)
                          : HomeDashboardColors.border(isDark)
                              .withOpacity(0.45),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _openDoctorProfile,
                        child: Container(
                          width: 28.r,
                          height: 28.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primary.withOpacity(0.22),
                              width: 1,
                            ),
                          ),
                          child: ClipOval(
                            child: replyModel.doctor == null
                                ? ColoredBox(
                                    color: primary.withOpacity(0.12),
                                    child: Icon(
                                      Icons.person,
                                      size: 14.sp,
                                      color: primary,
                                    ),
                                  )
                                : replyModel.doctor!.id == null
                                    ? ColoredBox(
                                        color: primary.withOpacity(0.12),
                                        child: Center(
                                          child: Text(
                                            (replyModel.doctor!.firstName ??
                                                    'D')[0]
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 11.sp,
                                              color: primary,
                                            ),
                                          ),
                                        ),
                                      )
                                    : CustomCachedNetworkImage(
                                        imageUrl:
                                            replyModel.doctor!.image.toString(),
                                        height: 28.r,
                                        width: 28.r,
                                        fit: BoxFit.cover,
                                      ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
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
                                            fontSize: 11.5.sp,
                                            fontWeight: FontWeight.w800,
                                            color: isOwn
                                                ? HomeDashboardColors.success
                                                : HomeDashboardColors.title(
                                                    isDark),
                                          ),
                                        ),
                                      ),
                                      if (isVerified)
                                        const Padding(
                                          padding: EdgeInsets.only(left: 3),
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
                                    replyModel.createdAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    fontSize: 9.5.sp,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        HomeDashboardColors.subtitle(isDark),
                                  ),
                                ),
                                if (_canManage())
                                  deleting
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 4.w),
                                          child: SizedBox(
                                            width: 12,
                                            height: 12,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1.4,
                                              color: primary,
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: 26,
                                          height: 26,
                                          child: PopupMenuButton<String>(
                                            padding: EdgeInsets.zero,
                                            iconSize: 16.sp,
                                            icon: Icon(
                                              Icons.more_horiz_rounded,
                                              color:
                                                  HomeDashboardColors.subtitle(
                                                      isDark),
                                            ),
                                            onSelected: (value) {
                                              if (value != 'Delete') return;
                                              showDeleteFeedCommentDialog(
                                                context: context,
                                                isReply: true,
                                                onConfirm: () {
                                                  cubit.deleteReplyOnComment(
                                                    replyModel.id.toString(),
                                                    commentModel,
                                                    replyIndex,
                                                    feed,
                                                    commentsResponse,
                                                    homeDataModel,
                                                    currentDoctorModel,
                                                  );
                                                },
                                              );
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
                                                      color: HomeDashboardColors
                                                          .danger,
                                                    ),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      context.tr(
                                                          AppStrings.delete),
                                                      style: TextStyle(
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
                                        ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              replyText,
                              textDirection: _getTextDirection(replyText),
                              textAlign: _isArabic(replyText)
                                  ? TextAlign.right
                                  : TextAlign.left,
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                                fontFamily: 'Tajawal',
                                color: HomeDashboardColors.title(isDark),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            GestureDetector(
                              onTap: () {
                                cubit.addLikeOrUnlikeOnReplyInCommunity(
                                  commentId: replyModel.id.toString(),
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: replyModel.isLiked == true
                                      ? const Color(0xFFE11D48).withOpacity(
                                          isDark ? 0.18 : 0.1,
                                        )
                                      : HomeDashboardColors.surfaceBg(isDark),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      replyModel.isLiked == true
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_border_rounded,
                                      size: 13.sp,
                                      color: replyModel.isLiked == true
                                          ? const Color(0xFFE11D48)
                                          : HomeDashboardColors.subtitle(
                                              isDark),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      '${replyModel.likesCount ?? 0}',
                                      style: TextStyle(
                                        fontSize: 10.5.sp,
                                        fontWeight: FontWeight.w700,
                                        color: replyModel.isLiked == true
                                            ? const Color(0xFFE11D48)
                                            : HomeDashboardColors.subtitle(
                                                isDark),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
