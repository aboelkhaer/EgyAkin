import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/community/presentation/cubit/community_state.dart';

class PostsTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final ScrollController feedsScrollController;

  const PostsTab({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.feedsScrollController,
  });

  @override
  State<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab> {
  @override
  Widget build(BuildContext context) {
    CommunityCubit cubit = CommunityCubit.get(context);

    return Container(
      color: Colors.grey.shade200,
      child: BlocBuilder<CommunityCubit, CommunityState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const ShimmerLoadingFeeds(
                numberOfShimmer: 5,
              );
            },
            loaded: (
              feedsResponse,
              isDeletePostLoading,
              isDeletePostLoaded,
              message,
              isSeeMore,
            ) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await cubit.getAllFeeds();
                      },
                      child: ListView.builder(
                        itemCount: feedsResponse.data!.data!.length,
                        controller: widget.feedsScrollController,
                        padding: const EdgeInsets.all(20) +
                            EdgeInsets.only(bottom: 60.h),
                        itemBuilder: (context, index) {
                          var feed = feedsResponse.data!.data![index];
                          return PostCard(
                            feed: feed,
                            homeDataModel: widget.homeDataModel,
                            currentDoctorModel: widget.currentDoctorModel,
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isSeeMore
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            )
                          : GestureDetector(
                              onTap: () {
                                // Add logic here if needed
                              },
                              child: const Text(
                                '',
                              ),
                            ),
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
