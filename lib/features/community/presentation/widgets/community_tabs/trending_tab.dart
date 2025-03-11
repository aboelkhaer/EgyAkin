import 'dart:developer';

import 'package:egy_akin/features/community/data/models/get_trending_tab_in_community_model_response.dart';
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

    TrendingCubit cubit = TrendingCubit.get(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        children: [
          // Top Section: Trending Hashtags
          Expanded(
            child: BlocBuilder<TrendingCubit, TrendingState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: LoadingForGroupRow(
                          count: 20,
                          isTrends: true,
                        ),
                      ),
                    );
                  },
                  loaded: (snackBarMessage, dialogMessage, response) {
                    return ListView.builder(
                      itemCount: response.data!.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        TrendModel trendModel = response.data![index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.communitySearch,
                                  arguments:
                                      AppRoutesArgs.communitySearchRouteArgs(
                                    currentDoctorModel:
                                        widget.currentDoctorModel,
                                    homeDataModel: widget.homeDataModel,
                                    initialValueInSearch: '#${trendModel.tag}',
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '#${capitalizeFirstText(trendModel.tag.toString())}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${trendModel.usageCount} posts',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                    Text(
                                      '${index + 1}. Trending in Egypt',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade100,
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
