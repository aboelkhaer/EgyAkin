import 'package:egy_akin/app/shared/functions/chat_text_direction.dart';
import 'package:egy_akin/app/shared/widgets/doctor_circle_avatar.dart';
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

  int? get _authorDoctorId =>
      replyModel.doctor?.id ?? replyModel.doctorId;

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

  void _openDoctorProfile() {
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
        currentDoctorPoints:
            int.tryParse(homeDataModel.scoreValue ?? '') ?? 0,
        homeDataModel: homeDataModel,
        initialIndex: 0,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  bool _canManage() {
    return homeDataModel.role == AppStrings.roleAdmin || _isOwnAuthor();
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
                final isOwn = _isOwnAuthor();
                final displayDoctor = resolveDoctorForAvatar(
                      replyModel.doctor ??
                          (isOwn ? currentDoctorModel : null),
                    ) ??
                    replyModel.doctor ??
                    (isOwn ? currentDoctorModel : null);
                final name = doctorDisplayName(
                  displayDoctor,
                  fallback: isOwn
                      ? doctorDisplayName(currentDoctorModel)
                      : '',
                );
                final isVerified = doctorIsVerified(displayDoctor);
                final replyText = replyModel.comment ?? '';
                final deleting = isDeleteCommentLoading &&
                    replyModel.id.toString() == cubit.deleteCommentId;

                return AnimatedContainer(
                  key: cubit.listKeyForReplies[replyModel.id],
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  padding: EdgeInsetsDirectional.fromSTEB(10.w, 10.h, 8.w, 8.h),
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
                        child: DoctorCircleAvatar(
                          doctor: displayDoctor ?? replyModel.doctor,
                          primary: primary,
                          size: 28.r,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: GestureDetector(
                                          onTap: _openDoctorProfile,
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
                                      ),
                                      if (isVerified)
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                            start: 3,
                                          ),
                                          child: const VerificationIcon(
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
                                          padding: EdgeInsetsDirectional.only(
                                            start: 4.w,
                                          ),
                                          child: SizedBox(
                                            width: 12,
                                            height: 12,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1.4,
                                              color: primary,
                                            ),
                                          ),
                                        )
                                      : PopupMenuButton<String>(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(
                                            minWidth: 30,
                                            minHeight: 30,
                                          ),
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
                                                      color: HomeDashboardColors
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
                            Container(
                              width: double.infinity,
                              alignment:
                                  ChatTextDirection.resolve(replyText) ==
                                          TextDirection.rtl
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: HashtagText(
                                content: replyText,
                                currentDoctorModel: currentDoctorModel,
                                homeDataModel: homeDataModel,
                                disableTrimLines: true,
                                showLinkPreviews: false,
                                style: TextStyle(
                                  fontSize: 12.5.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4,
                                  fontFamily: 'Tajawal',
                                  color: HomeDashboardColors.title(isDark),
                                ),
                                hashtagStyle: TextStyle(
                                  fontSize: 12.5.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.4,
                                  fontFamily: 'Tajawal',
                                  color: primary,
                                ),
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
