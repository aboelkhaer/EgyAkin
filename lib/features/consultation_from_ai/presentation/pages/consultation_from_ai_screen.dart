import 'package:egy_akin/features/consultation_from_ai/presentation/cubit/consultation_from_ai_state.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class ConsultationFromAiScreen extends StatefulWidget {
  final String patientId;
  const ConsultationFromAiScreen({
    super.key,
    required this.patientId,
  });

  @override
  State<ConsultationFromAiScreen> createState() =>
      _ConsultationFromAiScreenState();
}

class _ConsultationFromAiScreenState extends State<ConsultationFromAiScreen> {
  ConsultationFromAICubit? _cubit;
  bool showScrollToBottomFAB = false;

  @override
  void initState() {
    context
        .read<ConsultationFromAICubit>()
        .getAIConsultationHistory(widget.patientId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<ConsultationFromAICubit>();
      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
        _cubit!.scrollController!.addListener(_onScroll);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController!.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_cubit == null || _cubit!.isClosed) return;

    final cubit = context.read<ConsultationFromAICubit>();

    // Don't trigger scroll event when already loading more data or on the last page
    if (cubit.isLastPage || cubit.isLoadingMoreForScroll) return;

    final currentScroll = cubit.scrollController!.position.pixels;
    const threshold =
        10.0; // A small threshold to allow for minor scroll before showing/hiding FAB

    // Load more when nearing the bottom
    final maxScroll = cubit.scrollController!.position.maxScrollExtent;
    if (maxScroll - currentScroll <= threshold) {
      cubit.isLoadingMoreForScroll = true;
      cubit.loadMorePatients(widget.patientId);
    }

    // Hide FAB when at the bottom
    if (currentScroll < threshold) {
      if (showScrollToBottomFAB) {
        setState(() {
          showScrollToBottomFAB = false;
        });
      }
    }
    // Show FAB when scrolling up
    else if (currentScroll > threshold) {
      if (!showScrollToBottomFAB) {
        setState(() {
          showScrollToBottomFAB = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ConsultationFromAICubit cubit = ConsultationFromAICubit.get(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        return Scaffold(
          appBar: AppBar(
            title: Text(context.tr(AppStrings.aiOpinions)),
          ),
          body: BlocConsumer<ConsultationFromAICubit, ConsultationFromAIState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  customSnackBar(context: context, message: message);
                },
                loaded: (aiHistoryResponse, isRequestAIOpinionLoading,
                    isRequestAIOpinionLoaded, message, isSeeMore) {
                  if (message != '') {
                    customSnackBar(context: context, message: message);
                  }
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const Center(child: CircularProgressIndicator()),
                loaded: (aiHistoryResponse, isRequestAIOpinionLoading,
                    isRequestAIOpinionLoaded, message, isSeeMore) {
                  if (isRequestAIOpinionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      ListView.builder(
                        reverse: true,
                        controller: _cubit!.scrollController,
                        itemCount: aiHistoryResponse.history!.data!.length +
                            (isSeeMore ? 1 : 0),
                        padding: EdgeInsets.only(top: 20, bottom: 85.h),
                        itemBuilder: (context, index) {
                          if (index ==
                                  aiHistoryResponse.history!.data!.length &&
                              isSeeMore) {
                            return Column(
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
                            );
                          }

                          var aiHistory =
                              aiHistoryResponse.history!.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 20.r,
                                      backgroundImage: const AssetImage(
                                          'assets/images/ai.png'),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        margin: const EdgeInsets.only(top: 15),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary
                                              .withOpacity(0.1),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: MarkdownBody(
                                          data: aiHistory.response ?? '',
                                          styleSheet: MarkdownStyleSheet(
                                            h1: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                            h2: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            p: const TextStyle(fontSize: 16),
                                            strong: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            blockSpacing: 8.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      TimeAgoService.instance
                                          .formatTimeAgoFromString(
                                              aiHistory.createdAt.toString(),
                                              context),
                                      style: TextStyle(
                                          color: AppColors.description,
                                          fontSize: 9.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          // height: 60.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? AppColors.darkCardBG
                                : Colors.white,
                            border: const Border(
                                top: BorderSide(color: Colors.black12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 30),
                            child: Column(
                              children: [
                                Text(
                                  '${context.tr(AppStrings.youHave)} ${aiHistoryResponse.trialCount ?? 0} ${context.tr(AppStrings.remainingTrial)}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 35.h,
                                  child: CustomElevatedButton(
                                    onPressed: () {
                                      cubit.sendAIConsultationRequest(
                                          widget.patientId);
                                    },
                                    title:
                                        context.tr(AppStrings.requestAiOpinion),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (showScrollToBottomFAB)
                        Positioned(
                          bottom: 70.h,
                          right: 16,
                          child: FloatingActionButton(
                            onPressed: () => animateToTopOfScreen(cubit
                                .scrollController!), // Scroll back to the top
                            backgroundColor: AppColors.primary
                                .withOpacity(0.2), // Adjust color as needed
                            child: const Icon(
                              Icons.arrow_downward, // Set to an upward arrow
                              color: Colors.white, // Icon color
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
      },
    );
  }
}
