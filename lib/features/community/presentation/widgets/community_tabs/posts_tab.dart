import 'package:egy_akin/app/shared/widgets/loading_for_feeds.dart';
import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/community/presentation/cubit/community_state.dart';
import 'package:egy_akin/features/community/presentation/widgets/post_card.dart';

class PostsTab extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const PostsTab(
      {super.key,
      required this.currentDoctorModel,
      required this.homeDataModel});

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
                        // physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(20) +
                            EdgeInsets.only(bottom: 60.h),
                        itemBuilder: (context, index) {
                          var feed = feedsResponse.data!.data![index];
                          return PostCard(
                            feed: feed,
                            homeDataModel: homeDataModel,
                            currentDoctorModel: currentDoctorModel,
                          );
                        },
                      ),
                    ),
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
