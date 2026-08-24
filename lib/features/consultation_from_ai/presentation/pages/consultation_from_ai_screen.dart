import 'package:egy_akin/features/consultation_from_ai/presentation/cubit/consultation_from_ai_state.dart';
import 'package:egy_akin/features/consultation_from_ai/presentation/widgets/ai_consultation_bottom_cta.dart';
import 'package:egy_akin/features/consultation_from_ai/presentation/widgets/ai_consultation_header.dart';
import 'package:egy_akin/features/consultation_from_ai/presentation/widgets/ai_consultation_loading.dart';
import 'package:egy_akin/features/consultation_from_ai/presentation/widgets/ai_opinion_card.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

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
    super.initState();
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
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController?.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_cubit == null || _cubit!.isClosed) return;

    final cubit = context.read<ConsultationFromAICubit>();
    if (cubit.isLastPage || cubit.isLoadingMoreForScroll) return;
    if (cubit.scrollController == null || !cubit.scrollController!.hasClients) {
      return;
    }

    final currentScroll = cubit.scrollController!.position.pixels;
    const threshold = 10.0;
    final maxScroll = cubit.scrollController!.position.maxScrollExtent;

    if (maxScroll - currentScroll <= threshold) {
      cubit.isLoadingMoreForScroll = true;
      cubit.loadMorePatients(widget.patientId);
    }

    if (currentScroll < threshold) {
      if (showScrollToBottomFAB) {
        setState(() => showScrollToBottomFAB = false);
      }
    } else if (currentScroll > threshold) {
      if (!showScrollToBottomFAB) {
        setState(() => showScrollToBottomFAB = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ConsultationFromAICubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);

        return Scaffold(
          backgroundColor: HomeDashboardColors.scaffold(isDark),
          body: BlocConsumer<ConsultationFromAICubit, ConsultationFromAIState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  customSnackBar(context: context, message: message);
                },
                loaded: (
                  aiHistoryResponse,
                  isRequestAIOpinionLoading,
                  isRequestAIOpinionLoaded,
                  message,
                  isSeeMore,
                ) {
                  if (message.isNotEmpty) {
                    customSnackBar(context: context, message: message);
                  }
                },
              );
            },
            builder: (context, state) {
              final trialCount = state.maybeWhen(
                loaded: (response, _, __, ___, ____) =>
                    response.trialCount ?? 0,
                orElse: () => 0,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AiConsultationHeader(
                    isDark: isDark,
                    title: context.tr(AppStrings.aiOpinions),
                    subtitle: context.tr(
                      AppStrings.clinicalInsightsFromPatientRecord,
                    ),
                    trialCount: trialCount,
                    onBack: () => Navigator.of(context).maybePop(),
                  ),
                  Expanded(
                    child: state.maybeWhen(
                      orElse: () => AiConsultationLoadingList(isDark: isDark),
                      error: (message) => Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error_outline_rounded,
                                size: 36.sp,
                                color: HomeDashboardColors.danger,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                context.tr(AppStrings.somethingWentWrong),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800,
                                  color: HomeDashboardColors.title(isDark),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: HomeDashboardColors.subtitle(isDark),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      loaded: (
                        aiHistoryResponse,
                        isRequestAIOpinionLoading,
                        isRequestAIOpinionLoaded,
                        message,
                        isSeeMore,
                      ) {
                        final items =
                            aiHistoryResponse.history?.data ?? const [];

                        return Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            if (items.isEmpty)
                              AiConsultationEmptyState(isDark: isDark)
                            else
                              ListView.separated(
                                reverse: true,
                                controller: _cubit?.scrollController,
                                itemCount: items.length + (isSeeMore ? 1 : 0),
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  8.h,
                                  0,
                                  20.h,
                                ),
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 14.h),
                                itemBuilder: (context, index) {
                                  if (index == items.length && isSeeMore) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: 18.r,
                                          height: 18.r,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.2,
                                            color: primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  final aiHistory = items[index];
                                  return AiOpinionCard(
                                    isDark: isDark,
                                    response: aiHistory.response ?? '',
                                    timeAgo: TimeAgoService.instance
                                        .formatTimeAgoFromString(
                                      aiHistory.createdAt.toString(),
                                      context,
                                    ),
                                  );
                                },
                              ),
                            if (showScrollToBottomFAB && items.isNotEmpty)
                              PositionedDirectional(
                                end: 16.w,
                                bottom: 8.h,
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: InkWell(
                                    onTap: () {
                                      final controller = cubit.scrollController;
                                      if (controller != null) {
                                        animateToTopOfScreen(controller);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(14.r),
                                    child: Ink(
                                      width: 40.r,
                                      height: 40.r,
                                      decoration: BoxDecoration(
                                        color: HomeDashboardColors.cardBg(
                                          isDark,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        border: Border.all(
                                          color: HomeDashboardColors.border(
                                            isDark,
                                          ),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              isDark ? 0.25 : 0.08,
                                            ),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: primary,
                                        size: 22.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  state.maybeWhen(
                    loaded: (
                      aiHistoryResponse,
                      isRequestAIOpinionLoading,
                      _,
                      __,
                      ___,
                    ) {
                      return AiConsultationBottomCta(
                        isDark: isDark,
                        trialCount: aiHistoryResponse.trialCount ?? 0,
                        trialsLabel:
                            '${context.tr(AppStrings.youHave)} ${aiHistoryResponse.trialCount ?? 0} ${context.tr(AppStrings.remainingTrial)}',
                        actionLabel: context.tr(AppStrings.request),
                        isLoading: isRequestAIOpinionLoading,
                        onPressed: () {
                          cubit.sendAIConsultationRequest(widget.patientId);
                        },
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
