import '../../../../exports.dart';

class WriteCommentInCommunity extends StatefulWidget {
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final PostCommunityModel feed;
  final DoctorModel currentDoctorModel;

  const WriteCommentInCommunity({
    super.key,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.feed,
    required this.currentDoctorModel,
  });

  @override
  State<WriteCommentInCommunity> createState() =>
      _WriteCommentInCommunityState();
}

class _WriteCommentInCommunityState extends State<WriteCommentInCommunity> {
  @override
  Widget build(BuildContext context) {
    ShowSingleFeedCubit cubit = ShowSingleFeedCubit.get(context);

    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const SizedBox.shrink();
          },
          loading: () {
            return Container(
              height: cubit.commentToReply == null
                  ? size.height * 0.10
                  : size.height * 0.13,
              width: double.infinity,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(
                left: 20,
                right: 10,
                top: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                  color: Colors.black12,
                )),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  cubit.commentToReply == null
                      ? const SizedBox(height: 5)
                      : Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Text(context.tr(AppStrings.replyTo)),
                                const SizedBox(width: 5),
                                Text(
                                  '@${doctorName(
                                    firstName:
                                        cubit.commentToReply!.doctor!.firstName,
                                    lastName:
                                        cubit.commentToReply!.doctor!.lastName,
                                    role: cubit.commentToReply!.doctor!
                                        .isSyndicateCardRequired
                                        .toString(),
                                  )}',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                GestureDetector(
                                  onTap: () {
                                    cubit.commentToReply = null;
                                    cubit.refreshScreen();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          title: context.tr(AppStrings.writeComment),

                          textInputType: TextInputType.text,
                          enableSuggestions: true,
                          onChanged: (val) {
                            cubit.commentContent.text = val;
                          },
                          onFieldSubmitted: (val) {},
                          textInputAction: TextInputAction.done,
                          validator: (val) {
                            return null;
                          },
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.send_outlined,
                              size: 30,
                              color: AppColors.primary.withOpacity(0.7),
                            ),
                          ),
                          // SizedBox(
                          //   height: size.height * 0.012,
                          // )
                        ],
                      ),
                    ],
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
            if (isSendCommentLoading) {
              return const SizedBox.shrink();
            }
            if (isSendReplyLoading) {
              return const SizedBox.shrink();
            }

            return Container(
              height: cubit.commentToReply == null
                  ? size.height * 0.10
                  : size.height * 0.13,
              width: double.infinity,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(
                left: 20,
                right: 10,
                top: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                  color: Colors.black12,
                )),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  cubit.commentToReply == null
                      ? const SizedBox(height: 5)
                      : Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Text(context.tr(AppStrings.replyTo),
                                 ),
                                const SizedBox(width: 5),
                                Text(
                                  '@${doctorName(
                                    firstName:
                                        cubit.commentToReply!.doctor!.firstName,
                                    lastName:
                                        cubit.commentToReply!.doctor!.lastName,
                                    role: cubit.commentToReply!.doctor!
                                        .isSyndicateCardRequired
                                        .toString(),
                                  )}',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                GestureDetector(
                                  onTap: () {
                                    cubit.commentToReply = null;
                                    cubit.refreshScreen();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          title: context.tr(AppStrings.writeComment),

                          textInputType: TextInputType.text,
                          enableSuggestions: true,
                          onChanged: (val) {
                            cubit.commentContent.text = val;
                          },
                          onFieldSubmitted: (val) {},
                          textInputAction: TextInputAction.done,
                          validator: (val) {
                            return null;
                          },
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (cubit.commentToReply != null) {
                                cubit.createReplyOnComment(
                                  feed.id.toString(),
                                  cubit.commentToReply!.id.toString(),
                                  cubit.commentToReply!,
                                  widget.currentDoctorModel,
                                );
                              } else {
                                cubit.createCommentOnPostInCommunity(
                                  feed.id.toString(),
                                  cubit.commentContent.text,
                                  feed,
                                  commentsResponse.data!.data ?? [],
                                  widget.currentDoctorModel,
                                );
                              }
                            },
                            icon: Icon(
                              Icons.send_outlined,
                              size: 30,
                              color: AppColors.primary.withOpacity(0.7),
                            ),
                          ),
                          // SizedBox(
                          //   height: size.height * 0.012,
                          // )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
