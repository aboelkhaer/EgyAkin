import '../../../../exports.dart';

class CommentsInCommunity extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final PostCommunityModel feed;
  const CommentsInCommunity(
      {super.key,
      required this.homeDataModel,
      required this.currentDoctorModel,
      required this.feed});

  @override
  Widget build(BuildContext context) {
    ShowSingleFeedCubit cubit = ShowSingleFeedCubit.get(context);
    return BlocConsumer<ShowSingleFeedCubit, ShowSingleFeedState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
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
            // if (isSendCommentLoaded) {
            //   animateToBottomOfScreen(cubit.scrollController);
            // }
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const ShimmerLoadingPatientsCards(
              ishorizontal: false,
              numberOfShimmer: 3,
              isFeedsComments: true,
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
            return AnimatedList(
              key: cubit.listKeyForComments,
              initialItemCount: commentsResponse.data!.data!.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                top: 10,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index, animation) {
                if (index >= commentsResponse.data!.data!.length) {
                  return const SizedBox
                      .shrink(); // Return an empty widget if out of bounds
                }
                var commentModel = commentsResponse.data!.data![index];
                return CommentWidgetInCommunity(
                  commentModel: commentModel,
                  homeDataModel: homeDataModel,
                  currentDoctorModel: currentDoctorModel,
                  commentsResponse: commentsResponse,
                  index: index,
                  updatedFeed: updatedFeed,
                );
              },
            );
          },
        );
      },
    );
  }
}
