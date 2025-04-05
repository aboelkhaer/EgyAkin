import 'dart:developer';

import 'package:egy_akin/features/community/presentation/cubit/trending_cubit/trending_state.dart';

import '../../../../../exports.dart';

class TrendingTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const TrendingTab({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<TrendingTab> createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab> with WidgetsBindingObserver {
  late final TrendingCubit _cubit;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _cubit = context.read<TrendingCubit>();
    _scrollController = ScrollController()..addListener(_onScroll);

    // Initialize only once
    if (_cubit.callTrendsTabTimes == 0) {
      _cubit.getTrendingPostsInCommunity();
      _cubit.callTrendsTabTimes++;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _cubit.getTrendingPostsInCommunity();
    }
  }

  void _onScroll() {
    // Return early if we're already at the last page OR currently loading
    if (_cubit.isLastPage || _cubit.isLoadingMoreForScroll) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    const threshold = 200.0;

    if (maxScroll - currentScroll <= threshold) {
      _cubit.loadMoreTrends();
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
                  ? RefreshIndicator(
                      onRefresh: () {
                        return cubit.getTrendingPostsInCommunity();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 150.h),
                              Image.asset(
                                AppImages.notFound,
                                width: 150.w,
                                height: 150.h,
                              ),
                              SizedBox(height: 150.h),
                            ],
                          ),
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        return cubit.getTrendingPostsInCommunity();
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: response.data!.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _scrollController,
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
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
