import 'package:egy_akin/features/community/presentation/cubit/trending_cubit/trending_cubit.dart';
import 'package:egy_akin/features/community/presentation/cubit/trending_cubit/trending_state.dart';

import '../../../../../exports.dart';

class TrendingTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const TrendingTab(
      {super.key,
      required this.currentDoctorModel,
      required this.homeDataModel});

  @override
  State<TrendingTab> createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    // Add the observer to listen for lifecycle events
    WidgetsBinding.instance.addObserver(this);

    // Fetch groups data on initial load
    if (context.read<TrendingCubit>().callTrendsTabTimes == 0) {
      context.read<TrendingCubit>().getTrendingPostsInCommunity();
      context.read<TrendingCubit>().callTrendsTabTimes++;
    }
  }

  @override
  void dispose() {
    // Remove the observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Check if the app has resumed
    if (state == AppLifecycleState.resumed) {
      // Fetch groups data when the app resumes
      context.read<TrendingCubit>().getTrendingPostsInCommunity();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dummy data for trending hashtags with counters
    final Map<String, int> trendingHashtags = {
      '#Flutter': 120,
      '#Dart': 85,
      '#UI': 75,
      '#MobileApp': 60,
      '#OpenSource': 50,
    };

    final List<Map<String, String>> trendingPosts = [
      {
        'username': 'user1',
        'content': 'Check out this amazing Flutter UI! #Flutter #UI',
      },
      {
        'username': 'user2',
        'content': 'Exploring Dart language features. #Dart #Programming',
      },
      {
        'username': 'user3',
        'content': 'Building a mobile app with Flutter. #MobileApp #OpenSource',
      },
      {
        'username': 'user4',
        'content': 'Just released a new Flutter package! #Flutter #OpenSource',
      },
    ];

    TrendingCubit cubit = TrendingCubit.get(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Top Section: Trending Hashtags
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Top Hashtags',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<TrendingCubit, TrendingState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const SizedBox.shrink();
                      },
                      loaded: (snackBarMessage, dialogMessage, response) {
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: response.data!
                              .map((trendModel) => GestureDetector(
                                    onTap: () {
                                      // Handle hashtag click
                                      // _onHashtagClicked(context, entry.key);
                                    },
                                    child: Chip(
                                      label: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            trendModel.tag.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              '${trendModel.usageCount}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: AppColors.primary,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Divider
          const Divider(height: 1, color: Colors.grey),

          // Bottom Section: Trending Posts
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: trendingPosts.length,
              itemBuilder: (context, index) {
                final post = trendingPosts[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.primary,
                              child: Text(
                                post['username']![0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              post['username']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          post['content']!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.thumb_up, size: 20),
                              color: Colors.grey,
                              onPressed: () {
                                // Handle like action
                              },
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.comment, size: 20),
                              color: Colors.grey,
                              onPressed: () {
                                // Handle comment action
                              },
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.share, size: 20),
                              color: Colors.grey,
                              onPressed: () {
                                // Handle share action
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
