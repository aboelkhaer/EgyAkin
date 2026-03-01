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
    ShowSingleFeedCubit cubit = ShowSingleFeedCubit.get(context);
    final themeState = context.watch<ThemeBloc>().state;
    final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
    return PermissionGuard(
      permission: AppPermissions.viewFeedComments,
      fallback: Column(
        children: [
          Text(
            context.tr(
              AppStrings.youDontHavePermissionToViewFeedComments,
            ),
            style: TextStyle(
              color: isDarkMode ? AppColors.darkTitle : Colors.black,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
      child: BlocConsumer<ShowSingleFeedCubit, ShowSingleFeedState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              Navigator.pop(context);
              if (message !=
                  'An error occurred while retrieving post comments') {
                customSnackBar(context: context, message: message);
              } else {
                customSnackBar(context: context, message: message);
              }
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
                        AppStrings.thisOptionAlreadyExistsForThePoll));
              }
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
              isSeeMore,
            ) {
              if (commentsResponse.data == null) {
                return const SizedBox.shrink();
              }
              return Column(
                children: [
                  ListView.builder(
                    // Changed from AnimatedList to ListView.builder
                    key: cubit.listKeyForComments,
                    itemCount: commentsResponse.data!.data!.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    physics:
                        const NeverScrollableScrollPhysics(), // This is fine since parent scrolls
                    itemBuilder: (context, index) {
                      if (index >= commentsResponse.data!.data!.length) {
                        return const SizedBox.shrink();
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
                  ),
                  if (isSeeMore)
                    Column(
                      children: [
                        const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
