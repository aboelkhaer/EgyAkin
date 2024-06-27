import 'package:egy_akin/features/doctor_info_view/data/models/get_doctor_profile_score_history_model_response.dart';
import 'package:egy_akin/features/score_history/presentation/cubit/score_history_cubit.dart';
import 'package:egy_akin/features/score_history/presentation/cubit/score_history_state.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../exports.dart';

class ScoreHistoryScreen extends StatefulWidget {
  final String doctorId;
  const ScoreHistoryScreen({super.key, required this.doctorId});

  @override
  State<ScoreHistoryScreen> createState() => _ScoreHistoryScreenState();
}

class _ScoreHistoryScreenState extends State<ScoreHistoryScreen> {
  ScoreHistoryCubit? _cubit;

  @override
  void initState() {
    super.initState();
    context.read<ScoreHistoryCubit>().getScoreHistory(widget.doctorId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<ScoreHistoryCubit>();
      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
        _cubit!.scrollController!.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController!.dispose();
    }
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   context
  //       .read<AllDoctorsPatientsCubit>()
  //       .scrollController
  //       .addListener(_onScroll);
  // }

  void _onScroll() {
    if (context.read<ScoreHistoryCubit>().isLastPage) {
      return;
    } else {
      final maxScroll = context
          .read<ScoreHistoryCubit>()
          .scrollController!
          .position
          .maxScrollExtent;
      final currentScroll =
          context.read<ScoreHistoryCubit>().scrollController!.position.pixels;
      const threshold = 200.0;
      if (context.read<ScoreHistoryCubit>().isLoadingMoreForScroll == false &&
          maxScroll - currentScroll <= threshold) {
        context.read<ScoreHistoryCubit>().isLoadingMoreForScroll = true;

        context.read<ScoreHistoryCubit>().loadMorePatients(widget.doctorId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScoreHistoryCubit cubit = ScoreHistoryCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 5.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Row(
              children: [
                Text(
                  'Score History:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<ScoreHistoryCubit, ScoreHistoryState>(
              listener: (context, state) {},
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                  loaded: (scoreHistory, isSeeMore) {
                    return ListView.builder(
                      itemCount: scoreHistory.data!.length,
                      controller: cubit.scrollController,
                      itemBuilder: (context, index) {
                        ScoreModel scoreModel = scoreHistory.data![index];
                        return Container(
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 20, right: 20),
                          child: Card(
                            color: Colors.white,
                            elevation: 0.8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primary.withOpacity(0.8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        scoreModel.action.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            int.parse(scoreModel.score!) > 1
                                                ? 'Points:'
                                                : 'Point:',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            '${scoreModel.score}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 3.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        timeago
                                            .format(DateTime.parse(
                                              scoreModel.updateAt.toString(),
                                            ))
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 10.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          BlocBuilder<ScoreHistoryCubit, ScoreHistoryState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
                },
                loaded: (data, isSeeMore) {
                  return Row(
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
                                cubit.loadMorePatients(widget.doctorId);
                              },
                              child: const Text(
                                '',
                              ),
                            ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
