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
  TrendingCubit? _cubit;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<TrendingCubit>();

      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
        _cubit!.scrollController!.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    // Remove the observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController!.dispose();
    }
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

  void _onScroll() {
    if (context.read<TrendingCubit>().isLastPage) {
      return;
    } else {
      final maxScroll = context
          .read<TrendingCubit>()
          .scrollController!
          .position
          .maxScrollExtent;
      final currentScroll =
          context.read<TrendingCubit>().scrollController!.position.pixels;
      const threshold = 200.0;
      if (context.read<TrendingCubit>().isLoadingMoreForScroll == false &&
          maxScroll - currentScroll <= threshold) {
        context.read<TrendingCubit>().isLoadingMoreForScroll = true;

        context.read<TrendingCubit>().loadMoreTrends();
      }
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
      child: BlocBuilder<TrendingCubit, TrendingState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: LoadingForGroupRow(
                    count: 20,
                    isTrends: true,
                  ),
                ),
              );
            },
            loaded: (
              snackBarMessage,
              dialogMessage,
              response,
              isSeeMore,
            ) {
              return response.data!.isEmpty
                  ? Center(
                      child: Image.asset(
                        AppImages.notFound,
                        width: 150.w,
                        height: 150.h,
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: response.data!.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: cubit.scrollController,
                            padding: EdgeInsets.only(bottom: 50.h),
                            itemBuilder: (context, index) {
                              TrendModel trendModel = response.data![index];
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      navigatorKey.currentState?.pushNamed(
                                        AppRoutes.communitySearch,
                                        arguments: AppRoutesArgs
                                            .communitySearchRouteArgs(
                                          currentDoctorModel:
                                              widget.currentDoctorModel,
                                          homeDataModel: widget.homeDataModel,
                                          initialValueInSearch:
                                              '#${trendModel.tag}',
                                        ),
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
