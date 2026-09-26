import 'package:egy_akin/features/community/presentation/widgets/share_button.dart';
import 'package:egy_akin/features/community/presentation/widgets/post_like_action.dart';
import 'package:egy_akin/features/show_single_feed/presentation/widgets/images_in_single_post.dart';
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
            : ImagesInSinglePost(
                mediaPaths: feed.mediaPath!,
                heroTag: feed.id.toString(),
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
                      // Heart = like/unlike · count = open likers
                      PostLikeAction(
                        isLiked: feedResponse.isLiked == true,
                        likesCount: feedResponse.likesCount ?? 0,
                        isDark: isDarkMode,
                        homeDataModel: homeDataModel,
                        currentDoctorModel: currentDoctorModel,
                        postId: feedResponse.id.toString(),
                        onToggleLike: () => cubit.addOrRemoveLike(),
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
                              fontWeight: FontWeight.w600,
                              height: 1.1,
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
                            size: 20.sp,
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
