import 'package:egy_akin/app/shared/functions/hash_tags.dart';
import 'package:egy_akin/features/group_members/presentation/cubit/group_members_cubit.dart';
import 'package:egy_akin/features/group_members/presentation/pages/group_members_screen.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:ui' as ui;
import '../../../../exports.dart';

class FeedContentInCommunity extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final PostCommunityModel feed;
  const FeedContentInCommunity(
      {super.key,
      required this.homeDataModel,
      required this.currentDoctorModel,
      required this.feed});

  @override
  Widget build(BuildContext context) {
    ShowSingleFeedCubit cubit = ShowSingleFeedCubit.get(context);
    bool isArabic =
        RegExp(r'[\u0600-\u06FF]').hasMatch(feed.content.toString());
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
                    child: RichText(
                      textAlign: feed.content == null
                          ? TextAlign.start // Default alignment when no content
                          : isArabic // Check for RTL characters
                              ? TextAlign.right // Align right for RTL languages
                              : TextAlign.left, // Align left for LTR languages
                      text: buildHashtagText('${feed.content}'),
                      textDirection: feed.content == null
                          ? null
                          : isArabic
                              ? ui.TextDirection.rtl
                              : ui.TextDirection.ltr,
                    ),
                  ),
                ],
              ),
        feed.mediaPath == null
            ? const SizedBox.shrink()
            : KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  return GestureDetector(
                    onTap: isKeyboardVisible
                        ? null // Disable tap when the keyboard is visible
                        : () {
                            navigatorKey.currentState?.push(
                              MaterialPageRoute(
                                builder: (context) => FullScreenImage(
                                  imageUrl: feed.mediaPath.toString(),
                                ),
                              ),
                            );
                          },
                    child: Opacity(
                      opacity: 1.0,
                      child: Hero(
                        tag: feed.id.toString(),
                        child: CustomCachedNetworkImage(
                          imageUrl: feed.mediaPath.toString(),
                          width: double.infinity,
                        ),
                      ),
                    ),
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
                                Text(
                                  feed.likesCount.toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
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
                              feedResponse.likesCount! > 0
                                  ? InkWell(
                                      onTap: () async {
                                        showCustomBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return BlocProvider(
                                              create: (context) =>
                                                  GroupMembersCubit(
                                                      sl(), sl(), sl()),
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
                                      child: Text(
                                        feedResponse.likesCount.toString(),
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      feedResponse.likesCount.toString(),
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
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
        ),
      ],
    );
  }
}
