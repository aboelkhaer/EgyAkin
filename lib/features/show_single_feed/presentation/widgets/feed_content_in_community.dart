import 'package:egy_akin/features/community/presentation/widgets/share_button.dart';
import 'package:egy_akin/features/group_members/presentation/pages/group_members_screen.dart';
import 'package:egy_akin/features/show_single_feed/presentation/widgets/images_in_single_post.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../../../exports.dart';

class FeedContentInCommunity extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final PostCommunityModel feed;
  final String? highlightWord;
  const FeedContentInCommunity({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.feed,
    this.highlightWord,
  });

  @override
  Widget build(BuildContext context) {
    ShowSingleFeedCubit cubit = ShowSingleFeedCubit.get(context);
    bool isArabic =
        RegExp(r'[\u0600-\u06FF]').hasMatch(feed.content.toString());
    final poll =
        feed.poll; // Store poll in a variable to avoid multiple null checks

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
                orElse: () => const PollOptionsModelResponse(id: -1))
            .id;
      }
    }
    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        feed.content == null || feed.content == ''
            ? const SizedBox.shrink()
            : Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 10),
                    // child: RichText(
                    //   textAlign: feed.content == null
                    //       ? TextAlign.start // Default alignment when no content
                    //       : isArabic // Check for RTL characters
                    //           ? TextAlign.right // Align right for RTL languages
                    //           : TextAlign.left, // Align left for LTR languages
                    //   text: buildHashtagText(
                    //     '${feed.content}',
                    //     currentDoctorModel,
                    //     homeDataModel,
                    //     highlightWord,
                    //   ),
                    //   textDirection: feed.content == null
                    //       ? null
                    //       : isArabic
                    //           ? ui.TextDirection.rtl
                    //           : ui.TextDirection.ltr,
                    // ),
                    child: HashtagText(
                      content: feed.content.toString(),
                      trimLines: null,
                      currentDoctorModel: currentDoctorModel,
                      homeDataModel: homeDataModel,
                      disableTrimLines: true,
                    ),
                  ),
                ],
              ),
        //! Poll
        BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return ViewPollWidget(
                  poll: feed.poll,
                  currentDoctorModel: currentDoctorModel,
                  homeDataModel: homeDataModel,
                  selectedOptions: cubit.postSelectedOptions[feed.id] ?? {},
                  initiallyExpanded: true,
                  selectedOption: cubit.postSelectedOption[feed.id],
                  onOptionSelected: (optionId) {},
                  onOptionToggled: (optionId, isSelected) {},
                );
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
                if (updatedFeed.poll == null) {
                  return const SizedBox.shrink();
                }
                return ViewPollWidget(
                  poll: updatedFeed.poll,
                  currentDoctorModel: currentDoctorModel,
                  homeDataModel: homeDataModel,
                  selectedOptions:
                      cubit.postSelectedOptions[updatedFeed.id] ?? {},
                  initiallyExpanded: true,
                  onAddOption: (pollId, option) async {
                    await cubit.addOptionOnPoll(
                        pollId, option); // Call your function here
                  },
                  selectedOption: cubit.postSelectedOption[updatedFeed.id],
                  onOptionSelected: (optionId) {
                    cubit.postSelectedOption[updatedFeed.id!] = optionId;
                    cubit.addVoteAndUnVote(
                      updatedFeed.poll!.id.toString(),
                      optionId!,
                    );
                    cubit.refreshScreen();
                  },
                  onOptionToggled: (optionId, isSelected) {
                    cubit.postSelectedOptions[updatedFeed.id!] ??= {};
                    cubit.addVoteAndUnVote(
                      updatedFeed.poll!.id.toString(),
                      optionId,
                    );
                    if (isSelected) {
                      cubit.postSelectedOptions[updatedFeed.id!]!.add(optionId);
                    } else {
                      cubit.postSelectedOptions[updatedFeed.id!]!
                          .remove(optionId);
                    }
                    cubit.refreshScreen();
                  },
                );
              },
            );
          },
        ),
        feed.mediaPath == null || feed.mediaPath!.isEmpty
            ? const SizedBox.shrink()
            : KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  return ImagesInSinglePost(
                    mediaPaths: feed.mediaPath!, // Pass the list of image URLs
                    heroTag: feed.id.toString(), // Pass the Hero tag
                  );
                },
              ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkSubBG
                : AppColors.subBG,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              final isDarkMode =
                  themeState is ThemeLoaded && themeState.isDarkMode;

              return BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
                builder: (context, state) {
                  final feedResponse = state.maybeWhen(
                    loaded: (
                      _,
                      __,
                      updatedFeed,
                      ___,
                      ____,
                      _____,
                      ______,
                      _______,
                      ________,
                      _________,
                      __________,
                      ___________,
                    ) =>
                        updatedFeed,
                    orElse: () => feed,
                  );
                  final commentsCount = state.maybeWhen(
                    loaded: (
                      _,
                      __,
                      updatedFeed,
                      ___,
                      ____,
                      _____,
                      ______,
                      _______,
                      ________,
                      _________,
                      __________,
                      ___________,
                    ) =>
                        updatedFeed.commentsCount,
                    orElse: () => feed.commentsCount,
                  );

                  return Row(
                    children: [
                      InkWell(
                        onTap: () => cubit.addOrRemoveLike(),
                        borderRadius: BorderRadius.circular(20.r),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: feedResponse.isLiked == true
                                ? (isDarkMode
                                    ? const Color(0xFF5C1A1A)
                                    : const Color(0xFFFFE4E6))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                feedResponse.isLiked == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 16.sp,
                                color: feedResponse.isLiked == true
                                    ? (isDarkMode
                                        ? const Color(0xFFFDA4AF)
                                        : const Color(0xFFE11D48))
                                    : Colors.grey.shade400,
                              ),
                              SizedBox(width: 5.w),
                              GestureDetector(
                                onTap: () {
                                  if ((feedResponse.likesCount ?? 0) <= 0) {
                                    return;
                                  }
                                  showCustomBottomSheet(
                                    context: context,
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
                                          currentDoctorModel:
                                              currentDoctorModel,
                                          homeDataModel: homeDataModel,
                                          postId: feedResponse.id.toString(),
                                          isPostLikes: true,
                                          ownerId: '',
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  feedResponse.likesCount?.toString() ?? '0',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: feedResponse.isLiked == true
                                        ? (isDarkMode
                                            ? const Color(0xFFFDA4AF)
                                            : const Color(0xFFE11D48))
                                        : Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Row(
                        children: [
                          Icon(
                            Icons.mode_comment_outlined,
                            color: Colors.grey.shade400,
                            size: 20.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            commentsCount?.toString() ?? '0',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 14.w),
                      ShareButton(feed: feedResponse),
                      const Spacer(),
                      InkWell(
                        onTap: () => cubit.addOrRemoveSave(),
                        borderRadius: BorderRadius.circular(10.r),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: 34.r,
                          height: 34.r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: feedResponse.isSaved == true
                                ? (isDarkMode
                                    ? const Color(0xFF3D2E0A)
                                    : const Color(0xFFFEF3C7))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            feedResponse.isSaved == true
                                ? Icons.bookmark
                                : Icons.bookmark_outline,
                            size: 18.sp,
                            color: feedResponse.isSaved == true
                                ? (isDarkMode
                                    ? const Color(0xFFFBBF24)
                                    : const Color(0xFFF59E0B))
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
