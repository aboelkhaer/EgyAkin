import 'package:egy_akin/features/community/presentation/widgets/share_button.dart';
import 'package:egy_akin/features/group_members/presentation/pages/group_members_screen.dart';
import 'package:egy_akin/features/show_single_feed/presentation/widgets/images_in_single_post.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:ui' as ui;
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
          padding: const EdgeInsets.only(
            top: 15,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return InkWell(
                            onTap: () {
                              // Handle like functionality here
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: feed.isLiked == true
                                      ? Colors.red.shade600
                                      : Colors.grey.shade400,
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding:
                                      context.currentLocale?.languageCode ==
                                              'ar'
                                          ? const EdgeInsets.only(left: 10)
                                          : const EdgeInsets.only(right: 10),
                                  child: Text(
                                    feed.likesCount.toString(),
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        loaded: (
                          commentsResponse,
                          changeCounter,
                          feedResponse,
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
                          return Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  cubit.addOrRemoveLike();
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Icon(
                                  Icons.favorite,
                                  color: feedResponse.isLiked == true
                                      ? Colors.red.shade600
                                      : Colors.grey.shade400,
                                ),
                              ),
                              const SizedBox(width: 5),
                              feedResponse.likesCount != null &&
                                      feedResponse.likesCount! > 0
                                  ? InkResponse(
                                      onTap: () async {
                                        showCustomBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return BlocProvider(
                                              create: (context) =>
                                                  GroupMembersCubit(
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
                                                postId:
                                                    feedResponse.id.toString(),
                                                isPostLikes: true,
                                                ownerId: '',
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      radius:
                                          20, // This increases the ripple effect area
                                      containedInkWell: true,
                                      child: Padding(
                                        padding: context.currentLocale
                                                    ?.languageCode ==
                                                'ar'
                                            ? const EdgeInsets.only(left: 10)
                                            : const EdgeInsets.only(right: 10),
                                        child: Text(
                                          feedResponse.likesCount.toString(),
                                          style: const TextStyle(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    )
                                  : InkResponse(
                                      onTap: () async {},
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      radius:
                                          20, // This increases the ripple effect area
                                      containedInkWell: true,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          feedResponse.likesCount.toString(),
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.comment,
                          color: Colors.grey.shade400,
                          size: 23,
                        ),
                        const SizedBox(width: 5),
                        BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return Text(
                                  feed.commentsCount.toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                  ),
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
                                return Text(
                                  updatedFeed.commentsCount.toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ShareButton(feed: feed),
                  BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return InkWell(
                            onTap: () {},
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                Icon(
                                  feed.isSaved == true
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline,
                                  color: feed.isSaved == true
                                      ? Colors.amber
                                      : Colors.grey.shade400,
                                ),
                              ],
                            ),
                          );
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
                          return InkWell(
                            onTap: () {
                              // Handle save functionality here
                              cubit.addOrRemoveSave();
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                Icon(
                                  feed.isSaved == true
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline,
                                  color: feed.isSaved == true
                                      ? Colors.amber
                                      : Colors.grey.shade400,
                                ),
                              ],
                            ),
                          );
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
    );
  }
}
