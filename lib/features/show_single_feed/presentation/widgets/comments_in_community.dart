import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/show_single_feed/presentation/widgets/comment_exit_animator.dart';

import '../../../../exports.dart';

class CommentsInCommunity extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final PostCommunityModel feed;

  const CommentsInCommunity({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
    final primary = HomeDashboardColors.primary(isDark);

    return PermissionGuard(
      permission: AppPermissions.viewFeedComments,
      fallback: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: _EmptyCommentsState(
          isDark: isDark,
          primary: primary,
          title: context.tr(AppStrings.youDontHavePermissionToViewFeedComments),
          subtitle: null,
          icon: Icons.lock_outline_rounded,
        ),
      ),
      child: BlocConsumer<ShowSingleFeedCubit, ShowSingleFeedState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              Navigator.pop(context);
              customSnackBar(context: context, message: message);
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
              if (message == 'This option already exists for the poll') {
                customSnackBar(
                  context: context,
                  message: LocalizationService.instance.translate(
                    AppStrings.thisOptionAlreadyExistsForThePoll,
                  ),
                );
              }
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => Padding(
              padding: EdgeInsets.symmetric(vertical: 36.h),
              child: Center(
                child: SizedBox(
                  width: 22.r,
                  height: 22.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: primary,
                  ),
                ),
              ),
            ),
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
              if (commentsResponse.data == null) {
                return const SizedBox.shrink();
              }

              final comments = commentsResponse.data!.data ?? [];
              // Match the post bar: include top-level comments + replies.
              final total = updatedFeed.commentsCount ??
                  comments.fold<int>(
                    0,
                    (sum, comment) =>
                        sum +
                        1 +
                        (comment.repliesCount ??
                            comment.replies?.length ??
                            0),
                  );

              return Padding(
                padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _CommentsSectionHeader(
                      isDark: isDark,
                      primary: primary,
                      count: total,
                    ),
                    SizedBox(height: 10.h),
                    if (comments.isEmpty)
                      _EmptyCommentsState(
                        isDark: isDark,
                        primary: primary,
                        title: context.tr(AppStrings.noCommentsYet),
                        subtitle: context.tr(
                          AppStrings.beTheFirstToShareYourThoughts,
                        ),
                        icon: Icons.forum_outlined,
                      )
                    else
                      Column(
                        children: [
                          for (var index = 0;
                              index < comments.length;
                              index++) ...[
                            Builder(
                              builder: (context) {
                                final cubit =
                                    ShowSingleFeedCubit.get(context);
                                final comment = comments[index];
                                final commentId = comment.id.toString();
                                final shouldAnimate =
                                    highlightedCommentId != null &&
                                        commentId == highlightedCommentId;
                                return CommentExitAnimator(
                                  key: ValueKey('comment-exit-$commentId'),
                                  exiting: cubit.isItemExiting(commentId),
                                  onExited: () =>
                                      cubit.finalizeExitingItem(commentId),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: index < comments.length - 1
                                          ? 10.h
                                          : 0,
                                    ),
                                    child: _CommentEntrance(
                                      key: ValueKey(
                                        'comment-entrance-$commentId',
                                      ),
                                      animate: shouldAnimate,
                                      child: CommentWidgetInCommunity(
                                        commentModel: comment,
                                        homeDataModel: homeDataModel,
                                        currentDoctorModel:
                                            currentDoctorModel,
                                        commentsResponse: commentsResponse,
                                        index: index,
                                        updatedFeed: updatedFeed,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                    if (isSeeMore) ...[
                      SizedBox(height: 14.h),
                      Center(
                        child: SizedBox(
                          width: 18.r,
                          height: 18.r,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: primary,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _CommentEntrance extends StatefulWidget {
  final Widget child;
  final bool animate;

  const _CommentEntrance({
    super.key,
    required this.child,
    required this.animate,
  });

  @override
  State<_CommentEntrance> createState() => _CommentEntranceState();
}

class _CommentEntranceState extends State<_CommentEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _fade = curved;
    _slide = Tween<Offset>(
      begin: const Offset(0, -0.06),
      end: Offset.zero,
    ).animate(curved);
    _scale = Tween<double>(begin: 0.98, end: 1).animate(curved);

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant _CommentEntrance oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(
          scale: _scale,
          alignment: Alignment.topCenter,
          child: widget.child,
        ),
      ),
    );
  }
}

class _CommentsSectionHeader extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final int count;

  const _CommentsSectionHeader({
    required this.isDark,
    required this.primary,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28.r,
          height: 28.r,
          decoration: BoxDecoration(
            color: primary.withOpacity(isDark ? 0.18 : 0.1),
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Icon(
            Icons.chat_bubble_outline_rounded,
            size: 14.sp,
            color: primary,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          context.tr(AppStrings.comments),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
            color: HomeDashboardColors.title(isDark),
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3),
          decoration: BoxDecoration(
            color: primary.withOpacity(isDark ? 0.2 : 0.12),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w800,
              color: primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyCommentsState extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String title;
  final String? subtitle;
  final IconData icon;

  const _EmptyCommentsState({
    required this.isDark,
    required this.primary,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
      decoration: HomeDashboardDecor.card(isDark).copyWith(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Container(
            width: 52.r,
            height: 52.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary.withOpacity(isDark ? 0.28 : 0.16),
                  primary.withOpacity(isDark ? 0.1 : 0.05),
                ],
              ),
            ),
            child: Icon(icon, size: 24.sp, color: primary),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: HomeDashboardColors.title(isDark),
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 4.h),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w500,
                color: HomeDashboardColors.subtitle(isDark),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
