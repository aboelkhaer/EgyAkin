import 'package:egy_akin/features/group_members/presentation/pages/group_members_screen.dart';

import '../../../../exports.dart';

/// Heart toggles like; the count chip opens the likers sheet (never toggles like).
class PostLikeAction extends StatelessWidget {
  final bool isLiked;
  final int likesCount;
  final bool isDark;
  final VoidCallback onToggleLike;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final String postId;

  const PostLikeAction({
    super.key,
    required this.isLiked,
    required this.likesCount,
    required this.isDark,
    required this.onToggleLike,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.postId,
  });

  void _openLikers(BuildContext context) {
    if (likesCount <= 0) return;
    // Grow with likers; stay compact for 1–2 so there’s no huge empty gap.
    final heightFactor =
        (0.28 + (likesCount * 0.075)).clamp(0.30, 0.72).toDouble();
    showCustomBottomSheet(
      context: context,
      heightFactor: heightFactor,
      builder: (context) {
        return BlocProvider(
          create: (context) => GroupMembersCubit(
            sl(),
            sl(),
            sl(),
            sl(),
          ),
          child: GroupMembersScreen(
            groupId: '',
            currentDoctorModel: currentDoctorModel,
            homeDataModel: homeDataModel,
            postId: postId,
            isPostLikes: true,
            ownerId: '',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final likedColor =
        isDark ? const Color(0xFFFDA4AF) : const Color(0xFFE11D48);
    final muted = Colors.grey.shade400;
    final chipBg = isLiked
        ? (isDark ? const Color(0xFF5C1A1A) : const Color(0xFFFFE4E6))
        : (isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.04));

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Compact heart — same visual height as comment icon
        GestureDetector(
          onTap: onToggleLike,
          behavior: HitTestBehavior.opaque,
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            size: 20.sp,
            color: isLiked ? likedColor : muted,
          ),
        ),
        SizedBox(width: 6.w),
        // Count chip — horizontal tap target, compact vertically
        GestureDetector(
          onTap: likesCount > 0 ? () => _openLikers(context) : null,
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: chipBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$likesCount',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                    color: isLiked ? likedColor : muted,
                  ),
                ),
                if (likesCount > 0) ...[
                  SizedBox(width: 1.w),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 14.sp,
                    color: isLiked ? likedColor.withOpacity(0.9) : muted,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
